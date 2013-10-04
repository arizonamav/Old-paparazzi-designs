/*
 * Paparazzi $Id: main_fbw.c,v 1.60 2007/01/14 12:35:32 hecto Exp $
 *  
 * Copyright (C) 2003-2006 Pascal Brisset, Antoine Drouin
 *
 * This file is part of paparazzi.
 *
 * paparazzi is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * paparazzi is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with paparazzi; see the file COPYING.  If not, write to
 * the Free Software Foundation, 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA. 
 *
 */

/** \file main_fbw.c
 *  \brief FBW ( FlyByWire ) process
 *
 *   This process is responsible for decoding radio control, generating actuators 
 * signals either from the radio control or from the commands provided by the 
 * AP (autopilot) process. It also performs a telemetry task and a low level monitoring
 * ( for parameters like the supply )
 */

#include "main_fbw.h"

#include "init_hw.h"
#include "interrupt_hw.h"
#include "led.h"
#include "uart.h"
#include "spi.h"
#include "adc.h"

#include "sys_time.h"
#include "commands.h"
#include "actuators.h"
#include "radio_control.h"
#include "fbw_downlink.h"
#include "autopilot.h"
#include "paparazzi.h"
#include "estimator.h"

#ifdef MCU_SPI_LINK
#include "link_mcu.h"
#endif

#include "link_imu.h"
#include "control_grz.h"

#ifdef ADC
struct adc_buf vsupply_adc_buf;
#endif

uint8_t fbw_vsupply_decivolt;

uint8_t fbw_mode;

#include "inter_mcu.h"

/********** INIT *************************************************************/
void init_fbw( void ) {
  hw_init();
  sys_time_init();
#ifdef LED
  led_init();
#endif
#ifdef USE_UART0
  uart0_init_tx();
#endif
#ifdef USE_UART1
  uart1_init_tx();
#endif
#ifdef ADC
  adc_init();
  adc_buf_channel(ADC_CHANNEL_VSUPPLY, &vsupply_adc_buf, DEFAULT_AV_NB_SAMPLE);
#endif
#ifdef ACTUATORS
  actuators_init();
  /* Load the failsafe defaults */
  SetCommands(commands_failsafe);
#endif
#ifdef RADIO_CONTROL
 ppm_init();
#endif
#ifdef INTER_MCU
 inter_mcu_init();
#endif
#ifdef MCU_SPI_LINK
 spi_init();
 link_mcu_restart();
#endif
#ifdef LINK_IMU
 spi_init();
 link_imu_init();
#endif
#ifdef CTL_GRZ
 ctl_grz_init();
#endif
#ifndef SINGLE_MCU
  int_enable();
#endif
}


static inline void set_failsafe_mode( void ) {
  fbw_mode = FBW_MODE_FAILSAFE;
  SetCommands(commands_failsafe);
}


/********** EVENT ************************************************************/

void event_task_fbw( void) {
#ifdef RADIO_CONTROL
  if (ppm_valid) {
    ppm_valid = FALSE;
    radio_control_event_task();
    if (rc_values_contains_avg_channels) {
      fbw_mode = FBW_MODE_OF_PPRZ(rc_values[RADIO_MODE]);
    }
    if (fbw_mode == FBW_MODE_MANUAL)
      SetCommandsFromRC(commands);
#ifdef CTL_GRZ
    if (fbw_mode == FBW_MODE_MANUAL)
      ctl_grz_set_setpoints_rate();
/*     else if (fbw_mode == FBW_MODE_AUTO) { */
/*       SetCommandsFromRC(commands); */
/*     } */
#endif /* CTL_GRZ */
  }
#endif


#ifdef INTER_MCU
#ifdef MCU_SPI_LINK
  if (spi_message_received) {
    /* Got a message on SPI. */
    spi_message_received = FALSE;

    /* Sets link_mcu_received */
    /* Sets inter_mcu_received_ap if checksum is ok */
    link_mcu_event_task();
  }
#endif /* MCU_SPI_LINK */

  if (inter_mcu_received_ap) {
    inter_mcu_received_ap = FALSE;
    inter_mcu_event_task();
    if (fbw_mode == FBW_MODE_AUTO) {
      SetCommands(ap_state->commands);
    }
#ifdef SINGLE_MCU
    inter_mcu_fill_fbw_state();
#endif /**Else the buffer is filled even if the last receive was not correct */
  }

#ifdef MCU_SPI_LINK
  if (link_mcu_received) {
    link_mcu_received = FALSE;
    inter_mcu_fill_fbw_state(); /** Prepares the next message for AP */
    link_mcu_restart(); /** Prepares the next SPI communication */
  }
#endif /* MCU_SPI_LINK */
#endif /* INTER_MCU */

#ifdef LINK_IMU
  if (spi_message_received) {
    /* Got a message on SPI. */
    spi_message_received = FALSE;
    link_imu_event_task();
    EstimatorSetAtt(link_imu_state.eulers[AXIS_X], link_imu_state.eulers[AXIS_Z],  link_imu_state.eulers[AXIS_Y]);
#ifdef CTL_GRZ
    ctl_grz_set_measures(); 
#endif /* CTL_GRZ */
  }
#endif /* LINK_IMU */
}


/************* PERIODIC ******************************************************/
void periodic_task_fbw( void ) {
  static uint8_t _10Hz; /* FIXME : sys_time should provide it */
  _10Hz++;
  if (_10Hz >= 6) _10Hz = 0;

#ifdef RADIO_CONTROL
  radio_control_periodic_task();
  if (fbw_mode == FBW_MODE_MANUAL && rc_status == RC_REALLY_LOST) {
    fbw_mode = FBW_MODE_AUTO;
  }
#endif

#ifdef INTER_MCU
  inter_mcu_periodic_task();
  if (fbw_mode == FBW_MODE_AUTO && !ap_ok)
    set_failsafe_mode();
#endif

#ifdef DOWNLINK
  fbw_downlink_periodic_task();
#endif

#ifdef ADC
  if (!_10Hz)
    fbw_vsupply_decivolt = VoltageOfAdc((10*(vsupply_adc_buf.sum/vsupply_adc_buf.av_nb_sample)));
#endif

#ifdef ACTUATORS
#ifdef CTL_GRZ
  if (rc_status == RC_REALLY_LOST) {
    set_failsafe_mode();
  } else {
    ctl_grz_rate_run();
  }
#endif /* CTL_GRZ */
  SetActuatorsFromCommands(commands);
#endif


}
