/*
 * Paparazzi $Id: ap_downlink.h,v 1.32 2006/12/12 06:27:15 hecto Exp $
 *  
 * Copyright (C) 2006- Pascal Brisset, Antoine Drouin
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

/** \file ap_downlink.h
 *  \brief Set of macros defining the periodic telemetry messages of AP process
 *
 * The PeriodicSendAp() macro is generated from the telemetry description
 * (named in conf.xml, usually in conf/telemetry directory). This macro
 * is a sequence of calls to PERIODIC_SEND_message() which have to be defined
 * in the present file.
 *
 */

#ifndef AP_DOWNLINK_H
#define AP_DOWNLINK_H

#include <inttypes.h>

#include "airframe.h"

#define DOWNLINK_DEVICE DOWNLINK_AP_DEVICE
#include "downlink.h"

#include "messages.h"
#include "periodic.h"

#if defined DOWNLINK
#define Downlink(x) x
#else
#define Downlink(x) {}
#endif


#if defined( ADC_CHANNEL_IR4 ) && defined (INFRARED)
#define PERIODIC_SEND_IR_DEBUG() DOWNLINK_SEND_IR_DEBUG(&x1_dbg, &x2_dbg, &x3_dbg, &x4_dbg)
#elif defined (INFRARED)
#define PERIODIC_SEND_IR_DEBUG() DOWNLINK_SEND_IR_DEBUG(&x1_dbg, &x2_dbg,&x1_dbg, &x2_dbg)
#else 
#define PERIODIC_SEND_IR_DEBUG() {}
#endif

#define PERIODIC_SEND_SERVO() DOWNLINK_SEND_SERVO(&h_ctl_elevator_setpoint,&h_ctl_aileron_setpoint, &v_ctl_throttle_setpoint)



#define PERIODIC_SEND_IDENT()  DOWNLINK_SEND_IDENT(&ac_ident);

#define PERIODIC_SEND_BAT() Downlink({ int16_t e = energy; DOWNLINK_SEND_BAT(&v_ctl_throttle_slewed, &vsupply, &estimator_flight_time, &kill_throttle, &block_time, &stage_time, &e); })

#ifdef MCU_SPI_LINK
#define PERIODIC_SEND_DEBUG_MCU_LINK() DOWNLINK_SEND_DEBUG_MCU_LINK(&link_mcu_nb_err, &link_mcu_fbw_nb_err, &mcu1_ppm_cpt);
#else
#define PERIODIC_SEND_DEBUG_MCU_LINK() {}
#endif


#ifdef MODEM
#include "modem.h"
#define PERIODIC_SEND_DEBUG_MODEM() DOWNLINK_SEND_DEBUG_MODEM(&modem_nb_ovrn)
#else
#define PERIODIC_SEND_DEBUG_MODEM()
#endif


#define PERIODIC_SEND_ATTITUDE() Downlink({ \
  int16_t phi = DegOfRad(estimator_phi); \
  int16_t psi = DegOfRad(estimator_psi); \
  int16_t theta = DegOfRad(estimator_theta); \
  DOWNLINK_SEND_ATTITUDE(&phi, &psi, &theta); \
})

#define PERIODIC_SEND_PPRZ_MODE() DOWNLINK_SEND_PPRZ_MODE(&pprz_mode, &v_ctl_mode, &lateral_mode, &horizontal_mode, &rc_settings_mode, &mcu1_status, &ir_estim_mode);

#define PERIODIC_SEND_DESIRED() Downlink({\
   int16_t des_roll = DegOfRad(desired_roll);\
   int16_t des_pitch = DegOfRad(desired_pitch);\
   DOWNLINK_SEND_DESIRED(&desired_roll, &desired_pitch, &desired_x, &desired_y, &nav_altitude, &v_ctl_climb_setpoint);\
})

#define PERIODIC_SEND_NAVIGATION_REF()  DOWNLINK_SEND_NAVIGATION_REF(&nav_utm_east0, &nav_utm_north0, &nav_utm_zone0);


#define DownlinkSendWp(i) { \
  float x = nav_utm_east0 +  waypoints[i].x; \
  float y = nav_utm_north0 + waypoints[i].y; \
  DOWNLINK_SEND_WP_MOVED(&i, &x, &y, &(waypoints[i].a)); \
}


#define PERIODIC_SEND_WP_MOVED() { \
  static uint8_t i; \
  i++; if (i > nb_waypoint) i = 0; \
  DownlinkSendWp(i); \
}

#ifdef RADIO_CONTROL_SETTINGS
#define PERIODIC_SEND_SETTINGS() if (!RcSettingsOff()) DOWNLINK_SEND_SETTINGS(&slider_1_val, &slider_2_val);
#else
#define PERIODIC_SEND_SETTINGS() {}
#endif

#ifdef INFRARED
#define PERIODIC_SEND_IR_SENSORS() DOWNLINK_SEND_IR_SENSORS(&ir_pitch, &ir_roll, &ir_top);

#define PERIODIC_SEND_RAD_OF_IR() Downlink({ int16_t rad = DeciDegOfRad(estimator_rad); DOWNLINK_SEND_RAD_OF_IR(&ir_roll, &rad, &estimator_rad_of_ir);})
#define PERIODIC_SEND_CALIB_START() if (!estimator_flight_time && calib_status == WAITING_CALIB_CONTRAST) { DOWNLINK_SEND_CALIB_START(); }
#define PERIODIC_SEND_CALIB_CONTRAST() if (!estimator_flight_time && calib_status == CALIB_DONE) { DOWNLINK_SEND_CALIB_CONTRAST(&ir_contrast); }
#else
#define PERIODIC_SEND_IR_SENSORS()
#define PERIODIC_SEND_RAD_OF_IR() {}
#define PERIODIC_SEND_CALIB_START() {}
#define PERIODIC_SEND_CALIB_CONTRAST() {}
#endif

#define PERIODIC_SEND_ADC() {}

#if defined(ADC_CHANNEL_GYRO_ROLL) && defined(ADC_CHANNEL_GYRO_PITCH) && defined(ADC_CHANNEL_GYRO_YAW)
#include "gyro.h"
#define PERIODIC_SEND_GYRO_RATES() DOWNLINK_SEND_GYRO_RATES(&roll_rate_adc, &pitch_rate_adc, &yaw_rate_adc, &estimator_p, &estimator_q, &estimator_r)
#elif !defined(ADC_CHANNEL_GYRO_YAW) && defined(ADC_CHANNEL_GYRO_PITCH) && defined(ADC_CHANNEL_GYRO_ROLL)
#include "gyro.h"
#define PERIODIC_SEND_GYRO_RATES() DOWNLINK_SEND_GYRO_RATES(&roll_rate_adc, &pitch_rate_adc, &pitch_rate_adc, &estimator_p, &estimator_q, &estimator_q)
#else
#define PERIODIC_SEND_GYRO_RATES() {}
#endif

#ifdef ACCEL
#include "accel.h"
#define PERIODIC_SEND_ACCEL_RATES() DOWNLINK_SEND_ACCEL_RATES(&accel_ax_adc, &accel_ay_adc, &accel_az_adc, &estimator_ax, &estimator_ay, &estimator_az, &estimator_axfil, &estimator_ayfil, &estimator_azfil)
#else
#define PERIODIC_SEND_ACCEL_RATES() {}
#endif

#if defined( KALMAN_ROLL_PITCH) && defined(ACCEL)
#define PERIODIC_SEND_KALMAN_ROLL_PITCH() DOWNLINK_SEND_KALMAN_ROLL_PITCH(&estimator_kalman_phi, &estimator_kalman_theta,&estimator_kalman_q_angle,&estimator_kalman_q_gyro,&estimator_kalman_r_angle)
#else
#define PERIODIC_SEND_KALMAN_ROLL_PITCH() {}
#endif
/*
#ifdef TRANSITION
#include "fw_h_ctl.h"
#define PERIODIC_SEND_GAINS() DOWNLINK_SEND_GAINS(&h_ctl_hi_throttle_roll_rate_pgain, &h_ctl_lo_throttle_roll_rate_pgain, &h_ctl_hi_throttle_pitch_rate_pgain, &h_ctl_lo_throttle_pitch_rate_pgain, &h_ctl_hi_throttle_yaw_rate_pgain, &h_ctl_lo_throttle_yaw_rate_pgain)
#else
#define PERIODIC_SEND_GAINS() {}
#endif
*/
#ifdef AGR_CLIMB
#define PERIODIC_SEND_CALIBRATION() DOWNLINK_SEND_CALIBRATION(&v_ctl_alt_sum_err, &v_ctl_auto_throttle_pgain, &h_ctl_course_pgain, &v_ctl_auto_throttle_submode)
#else
#define PERIODIC_SEND_CALIBRATION() DOWNLINK_SEND_CALIBRATION(&v_ctl_alt_sum_err, &v_ctl_auto_throttle_pgain, &h_ctl_course_pgain, &pprz_mode)
#endif

#define PERIODIC_SEND_CIRCLE() if (nav_in_circle) { DOWNLINK_SEND_CIRCLE(&nav_circle_x, &nav_circle_y, &nav_circle_radius); }

#define PERIODIC_SEND_SEGMENT() if (nav_in_segment) { DOWNLINK_SEND_SEGMENT(&nav_segment_x_1, &nav_segment_y_1, &nav_segment_x_2, &nav_segment_y_2); }

#ifdef IMU_ANALOG
#define PERIODIC_SEND_IMU() { int16_t dummy = 42; DOWNLINK_SEND_IMU(&(from_fbw.euler_dot[0]), &(from_fbw.euler_dot[1]), &(from_fbw.euler_dot[2]), &dummy, &dummy, &dummy); }
#else
#define PERIODIC_SEND_IMU() {}
#endif

#ifdef RANGE
#define PERIODIC_SEND_ESTIMATOR() DOWNLINK_SEND_ESTIMATOR(&estimator_z, &estimator_z_dot,&estimator_range,&estimator_range_dot,&range_hovering)
#else
#define PERIODIC_SEND_ESTIMATOR() DOWNLINK_SEND_ESTIMATOR(&estimator_z, &estimator_z_dot,&estimator_z_dot,&estimator_z_dot,&estimator_z)
#endif
#define SEND_NAVIGATION() Downlink({ int16_t pos_x = estimator_x; int16_t pos_y = estimator_y; int16_t d_course = DeciDegOfRad(h_ctl_course_pgain); DOWNLINK_SEND_NAVIGATION(&nav_block, &nav_stage, &pos_x, &pos_y, &d_course, &dist2_to_wp, &dist2_to_home);})

#ifdef CAM
#define SEND_CAM() Downlink({ int16_t x = target_x; int16_t y = target_y; int8_t phi = DegOfRad(phi_c); int8_t theta = DegOfRad(theta_c); DOWNLINK_SEND_CAM(&phi, &theta, &x, &y);})
#else
#define SEND_CAM() {}
#endif

#define PERIODIC_SEND_DL_VALUE() PeriodicSendDlValue() /** generated from the xml settings config in conf/settings */

#define PERIODIC_SEND_SURVEY() DOWNLINK_SEND_SURVEY(&survey_east, &survey_north, &survey_west, &survey_south)

#define PERIODIC_SEND_RANGEFINDER() DOWNLINK_SEND_RANGEFINDER(&rangemeter, &ctl_grz_z_dot, &ctl_grz_z_dot_sum_err, &ctl_grz_z_dot_setpoint, &ctl_grz_z_sum_err, &ctl_grz_z_setpoint, &flying)

#ifdef CTL_GRZ
#define PERIODIC_SEND_GRZ_MEASURE() DOWNLINK_SEND_GRZ_MEASURE(&roll_dot_pid.measure, &pitch_dot_pid.measure, &yaw_dot_pid.measure, &roll_pid.measure, &pitch_pid.measure, &yaw_pid.measure);
#define PERIODIC_SEND_GRZ_RATE_LOOP() DOWNLINK_SEND_GRZ_RATE_LOOP(&roll_dot_pid.measure, &roll_dot_pid.set_point, &pitch_dot_pid.measure, &pitch_dot_pid.set_point, &yaw_dot_pid.measure, &yaw_dot_pid.set_point);
#define PERIODIC_SEND_GRZ_ATTITUDE_LOOP() DOWNLINK_SEND_GRZ_ATTITUDE_LOOP(&roll_pid.measure, &roll_pid.set_point, &pitch_pid.measure, &pitch_pid.set_point, &yaw_pid.measure, &yaw_pid.set_point);

#define PERIODIC_SEND_SPEED_LOOP() DOWNLINK_SEND_SPEED_LOOP(&ve_pid.set_point, &ve_pid.measure, &vn_pid.set_point, &vn_pid.measure, &north_angle_set_point, &east_angle_set_point);

#endif

#endif /* AP_DOWNLINK_H */
