/*
 * $Id: autopilot.h,v 1.18 2006/11/14 21:26:00 hecto Exp $
 *  
 * Copyright (C) 2003  Pascal Brisset, Antoine Drouin
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

/** \file autopilot.h
 *  \brief Autopilot modes
 *
 */

#ifndef AUTOPILOT_H
#define AUTOPILOT_H

//#include "inter_mcu.h"
#include <inttypes.h>
#include "std.h"
#include "sys_time.h"


#ifndef M_PI_2
#define M_PI_2 1.57075
#endif

#ifndef M_PI_4
#define M_PI_4 0.785375
#endif

#define TRESHOLD_MANUAL_PPRZ (MIN_PPRZ / 2)

#define TRESHOLD1 TRESHOLD_MANUAL_PPRZ
#define TRESHOLD2 (MAX_PPRZ/2)


#define  PPRZ_MODE_MANUAL 0
#define  PPRZ_MODE_AUTO1 1
#define  PPRZ_MODE_AUTO2 2
#define  PPRZ_MODE_HOME	3
#define  PPRZ_MODE_GPS_OUT_OF_ORDER 4
#define  PPRZ_MODE_NB 5

#define PPRZ_MODE_OF_PULSE(pprz, mega8_status) \
  (pprz > TRESHOLD2 ? PPRZ_MODE_AUTO2 : \
        (pprz > TRESHOLD1 ? PPRZ_MODE_AUTO1 : PPRZ_MODE_MANUAL))

extern uint8_t pprz_mode;
extern bool_t kill_throttle;


#define LATERAL_MODE_MANUAL    0
#define LATERAL_MODE_ROLL_RATE 1
#define LATERAL_MODE_ROLL      2
#define LATERAL_MODE_COURSE    3
#define LATERAL_MODE_NB        4

#define IR_ESTIM_MODE_OFF        0
#define IR_ESTIM_MODE_ON         1

#define IR_ESTIM_MODE_OF_PULSE(pprz) (pprz < TRESHOLD2 ? IR_ESTIM_MODE_OFF:  \
                                                          IR_ESTIM_MODE_ON)

extern uint8_t ir_estim_mode;

#define STICK_PUSHED(pprz) (pprz < TRESHOLD1 || pprz > TRESHOLD2)


#define FLOAT_OF_PPRZ(pprz, center, travel) ((float)pprz / (float)MAX_PPRZ * travel + center)
#define PPRZ_OF_FLOAT(flt) ((flt-center)/travel*MAX_PPRZ)


extern uint8_t fatal_error_nb;

#define THROTTLE_THRESHOLD_TAKEOFF (pprz_t)(MAX_PPRZ * 0.3)

extern uint8_t lateral_mode;
extern uint8_t vsupply;
extern uint8_t vdrop2throt_coeff;


extern bool_t rc_event_1, rc_event_2;

extern float slider_1_val, slider_2_val;

extern bool_t launch;

extern uint8_t light_mode;
extern bool_t gps_lost;

extern bool_t sum_err_reset;

/** Assignment, returning _old_value != _value
 * Using GCC expression statements */
#define ModeUpdate(_mode, _value) ({ \
  uint8_t new_mode = _value; \
  (_mode != new_mode ? _mode = new_mode, TRUE : FALSE); \
})

#define CheckEvent(_event) (_event ? _event = FALSE, TRUE : FALSE)


void periodic_task( void );
void telecommand_task(void);

#ifdef RADIO_CONTROL
#include "radio_control.h"
static inline void autopilot_process_radio_control ( void ) {
  pprz_mode = PPRZ_MODE_OF_PULSE(rc_values[RADIO_MODE], 0);
}
#endif

#endif /* AUTOPILOT_H */
