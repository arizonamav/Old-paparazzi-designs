/*
 * Paparazzi $Id: fw_h_ctl.c,v 1.6 2006/10/28 02:06:15 hecto Exp $
 *  
 * Copyright (C) 2006  Pascal Brisset, Antoine Drouin, Michel Gorraz
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

/** 
 *
 * fixed wing horizontal control
 *
 */

#include "std.h"
#include "led.h"
#include "fw_h_ctl.h"
#include "estimator.h"
#include "nav.h"
#include "airframe.h"
#include "fw_v_ctl.h"


//deternime if there are devices to provide estimated attitude of the aircraft

#if defined(INFRARED) || defined(ACCEL)


#else
#warning "There are no devices for attitude estimation defined. Using direct radio commands."
#endif

#if defined(GYRO)
#define RATE
#warning "Gyro is found, rate stabilisation is enabled."

#ifdef CTL_ROLL_RATE
#warning "roll rate loop is defined"
#define H_CTL_RATE_LOOP
#endif

#ifdef CTL_PITCH_RATE
#warning "pitch rate loop is defined"
#endif

#ifdef CTL_YAW_RATE
#warning "yaw rate loop is defined"
#endif

#ifdef H_CTL_RATE_LOOP
#warning "H_CTL_RATE_LOOP is defined"
#endif

#else
#warning "No devices for rate estimation defined. Rate stabilisation is disabled."
#endif

#if !defined(RATE)
#undef H_CTL_RATE_LOOP
#undef CTL_ROLL_RATE
#undef CTL_PITCH_RATE
#undef CTL_YAW_RATE
#endif

#ifdef H_CTL_RATE_LOOP
#warning "H_CTL_RATE_LOOP defined"
#endif

#ifdef INFRARED
#warning "INFRARED defined"
#endif

#ifdef RATE
#warning "RATE defined"
#endif

#ifdef ACCEL
#warning "ACCEL defined"
#endif

#ifdef ATTITUDE_ROLL
#warning "ATTITUDE_ROLL defined"
#endif

#ifdef ATTITUDE_PITCH
#warning "ATTITUDE_PITCH defined"
#endif

#ifdef LOITER_TRIM
#warning "LOITER_TRIM defined"
#endif

/* outer loop parameters */
float h_ctl_course_setpoint;
float h_ctl_course_pre_bank;
float h_ctl_course_pre_bank_correction;
float h_ctl_course_pgain;
float h_ctl_roll_max_setpoint;
float h_ctl_pitch_max_setpoint;
float h_ctl_pitch_min_setpoint;
float h_ctl_yaw_max_setpoint;

/* roll and pitch disabling */
bool_t h_ctl_disabled;

/* AUTO1 rate mode */
bool_t h_ctl_auto1_rate;


bool_t h_ctl_attitude_enabled=FALSE;
/* inner roll loop parameters */
float  h_ctl_roll_setpoint;
float  h_ctl_roll_pgain;
pprz_t h_ctl_aileron_setpoint;

/* inner pitch loop parameters */
float  h_ctl_pitch_setpoint;
#ifdef TRANSITION
float h_ctl_pitch_state_setpoint;
float h_ctl_mid_aoa_roll_rate_pgain;
float h_ctl_mid_aoa_pitch_rate_pgain;
float h_ctl_mid_aoa_yaw_rate_pgain;
float h_ctl_mid_aoa_elevator_of_roll;
float h_ctl_hi_aoa_roll_rate_pgain;
float h_ctl_hi_aoa_pitch_rate_pgain;
float h_ctl_hi_aoa_yaw_rate_pgain;
float h_ctl_hi_aoa_elevator_of_roll;
float h_ctl_lo_aoa_roll_rate_pgain;
float h_ctl_lo_aoa_pitch_rate_pgain;
float h_ctl_lo_aoa_yaw_rate_pgain;
float h_ctl_lo_aoa_elevator_of_roll;
#endif
float desired_pitch, desired_roll; /*This is done to send desired pitch and roll angles in degrees*/
float  h_ctl_pitch_pgain;
float  h_ctl_pitch_dgain;
pprz_t h_ctl_elevator_setpoint;

/* inner yaw loop parameters */
float  h_ctl_yaw_setpoint;
float  h_ctl_yaw_pgain;
float  h_ctl_yaw_dgain;
pprz_t h_ctl_rudder_setpoint;

/* inner loop pre-command */
float h_ctl_aileron_of_throttle;
float h_ctl_elevator_of_roll;

/* roll loop */
float h_ctl_roll_rate_setpoint;
float h_ctl_roll_rate_mode;
float h_ctl_roll_rate_setpoint_pgain;
float h_ctl_hi_throttle_roll_rate_pgain;
float h_ctl_lo_throttle_roll_rate_pgain;
float h_ctl_roll_rate_igain;
float h_ctl_roll_rate_dgain;

/* pitch loop */
float h_ctl_pitch_rate_setpoint;
float h_ctl_pitch_rate_mode;
float h_ctl_pitch_rate_setpoint_pgain;
float h_ctl_hi_throttle_pitch_rate_pgain;
float h_ctl_lo_throttle_pitch_rate_pgain;
float h_ctl_pitch_rate_igain;
float h_ctl_pitch_rate_dgain;

/* yaw loop */
float h_ctl_yaw_rate_setpoint;
float h_ctl_yaw_rate_mode;
float h_ctl_yaw_rate_setpoint_pgain;
float h_ctl_hi_throttle_yaw_rate_pgain;
float h_ctl_lo_throttle_yaw_rate_pgain;
float h_ctl_yaw_rate_igain;
float h_ctl_yaw_rate_dgain;

inline static void h_ctl_roll_loop( void );
inline static void h_ctl_pitch_loop( void );
#ifdef COMMAND_YAW
inline static void h_ctl_yaw_loop( void );
#endif

#if defined( H_CTL_RATE_LOOP ) || defined(CTL_ROLL_RATE)
static inline void h_ctl_roll_rate_loop( void );
#endif

#if defined(CTL_PITCH_RATE)
static inline void h_ctl_pitch_rate_loop( void );
#endif

#if defined(CTL_YAW_RATE)
static inline void h_ctl_yaw_rate_loop( void );
#endif

#ifndef H_CTL_COURSE_PRE_BANK_CORRECTION
#define H_CTL_COURSE_PRE_BANK_CORRECTION 1.
#endif


#ifdef LOITER_TRIM

float v_ctl_auto_throttle_loiter_trim = V_CTL_AUTO_THROTTLE_LOITER_TRIM;
float v_ctl_auto_throttle_dash_trim = V_CTL_AUTO_THROTTLE_DASH_TRIM;

inline static float loiter(void);

#endif



void h_ctl_init( void ) {

  h_ctl_course_setpoint = 0.;
  h_ctl_course_pre_bank = 0.;
  h_ctl_course_pre_bank_correction = H_CTL_COURSE_PRE_BANK_CORRECTION;
  h_ctl_course_pgain = H_CTL_COURSE_PGAIN;
  h_ctl_roll_max_setpoint = H_CTL_ROLL_MAX_SETPOINT;
  h_ctl_pitch_max_setpoint = H_CTL_PITCH_MAX_SETPOINT;
  h_ctl_pitch_min_setpoint = H_CTL_PITCH_MIN_SETPOINT;
  h_ctl_yaw_max_setpoint = H_CTL_YAW_MAX_SETPOINT;

  h_ctl_disabled = FALSE;

  h_ctl_roll_setpoint = 0.;
  h_ctl_roll_pgain = H_CTL_ROLL_PGAIN;
  h_ctl_aileron_setpoint = 0;
  h_ctl_aileron_of_throttle = H_CTL_AILERON_OF_THROTTLE;

  h_ctl_pitch_setpoint = 0.;
#ifdef TRANSITION
  h_ctl_pitch_state_setpoint=0;
#endif
  h_ctl_pitch_pgain = H_CTL_PITCH_PGAIN;
  h_ctl_pitch_dgain = H_CTL_PITCH_DGAIN;
  h_ctl_elevator_setpoint = 0;
  h_ctl_elevator_of_roll = H_CTL_ELEVATOR_OF_ROLL;
  h_ctl_yaw_setpoint = 0.;
  h_ctl_yaw_pgain = H_CTL_PITCH_PGAIN;
  h_ctl_rudder_setpoint = 0;


#if defined( H_CTL_RATE_LOOP ) || defined( CTL_ROLL_RATE)
  h_ctl_roll_rate_mode = H_CTL_ROLL_RATE_MODE_DEFAULT;
  h_ctl_roll_rate_setpoint_pgain = H_CTL_ROLL_RATE_SETPOINT_PGAIN;
  h_ctl_roll_rate_igain = H_CTL_ROLL_RATE_IGAIN;
  h_ctl_roll_rate_dgain = H_CTL_ROLL_RATE_DGAIN;
#endif
  h_ctl_hi_throttle_roll_rate_pgain = H_CTL_HI_THROTTLE_ROLL_RATE_PGAIN;
  h_ctl_lo_throttle_roll_rate_pgain = H_CTL_LO_THROTTLE_ROLL_RATE_PGAIN;
#if defined( CTL_PITCH_RATE)
  h_ctl_pitch_rate_mode = H_CTL_PITCH_RATE_MODE_DEFAULT;
  h_ctl_pitch_rate_setpoint_pgain = H_CTL_PITCH_RATE_SETPOINT_PGAIN;
  h_ctl_pitch_rate_igain = H_CTL_PITCH_RATE_IGAIN;
  h_ctl_pitch_rate_dgain = H_CTL_PITCH_RATE_DGAIN;
#endif
  h_ctl_hi_throttle_pitch_rate_pgain = H_CTL_HI_THROTTLE_PITCH_RATE_PGAIN;
  h_ctl_lo_throttle_pitch_rate_pgain = H_CTL_LO_THROTTLE_PITCH_RATE_PGAIN;
#if defined( CTL_YAW_RATE )
  h_ctl_yaw_rate_mode = H_CTL_YAW_RATE_MODE_DEFAULT;
  h_ctl_yaw_rate_setpoint_pgain = H_CTL_YAW_RATE_SETPOINT_PGAIN;
  h_ctl_yaw_rate_igain = H_CTL_YAW_RATE_IGAIN;
  h_ctl_yaw_rate_dgain = H_CTL_YAW_RATE_DGAIN;
  h_ctl_hi_throttle_yaw_rate_pgain = H_CTL_HI_THROTTLE_YAW_RATE_PGAIN;
  h_ctl_lo_throttle_yaw_rate_pgain = H_CTL_LO_THROTTLE_YAW_RATE_PGAIN;
#endif

#ifdef TRANSITION
h_ctl_mid_aoa_roll_rate_pgain=H_CTL_MID_AOA_ROLL_RATE_PGAIN;
h_ctl_mid_aoa_pitch_rate_pgain=H_CTL_MID_AOA_PITCH_RATE_PGAIN;
h_ctl_mid_aoa_yaw_rate_pgain=H_CTL_MID_AOA_YAW_RATE_PGAIN;
h_ctl_mid_aoa_elevator_of_roll=H_CTL_MID_AOA_ELEVATOR_OF_ROLL;
h_ctl_hi_aoa_roll_rate_pgain=H_CTL_HI_AOA_ROLL_RATE_PGAIN;
h_ctl_hi_aoa_pitch_rate_pgain=H_CTL_HI_AOA_PITCH_RATE_PGAIN;
h_ctl_hi_aoa_yaw_rate_pgain=H_CTL_HI_AOA_YAW_RATE_PGAIN;
h_ctl_hi_aoa_elevator_of_roll=H_CTL_HI_AOA_ELEVATOR_OF_ROLL;
h_ctl_lo_aoa_roll_rate_pgain=H_CTL_LO_AOA_ROLL_RATE_PGAIN;
h_ctl_lo_aoa_pitch_rate_pgain=H_CTL_LO_AOA_PITCH_RATE_PGAIN;
h_ctl_lo_aoa_yaw_rate_pgain=H_CTL_LO_AOA_YAW_RATE_PGAIN;
h_ctl_lo_aoa_elevator_of_roll=H_CTL_LO_AOA_ELEVATOR_OF_ROLL;
#endif


#if (defined( ATTITUDE_ROLL ) || defined (ATTITUDE_PITCH)) && (defined (AUTO2_MANUAL_HOVERING))
h_ctl_attitude_enabled=FALSE;
#else
#if !defined(AUTO2_MANUAL_HOVERING)
h_ctl_attitude_enabled=TRUE;
#else
h_ctl_attitude_enabled=FALSE; 
#endif
#endif


}

/** 
 * \brief 
 *
 */
void h_ctl_course_loop ( void ) {
  float err = estimator_hspeed_dir - h_ctl_course_setpoint;
  NormRadAngle(err);
  float speed_depend_nav = estimator_hspeed_mod/NOMINAL_AIRSPEED; 
  Bound(speed_depend_nav, 0.66, 1.5);
  float cmd = h_ctl_course_pgain * err;
#if defined  AGR_CLIMB
  if (v_ctl_auto_throttle_submode == V_CTL_AUTO_THROTTLE_AGRESSIVE) {
    float altitude_error = estimator_z - v_ctl_altitude_setpoint;
    cmd *= ((altitude_error < 0) ? AGR_CLIMB_NAV_RATIO : AGR_DESCENT_NAV_RATIO);
  }
#endif

#ifdef COMMAND_YAW
  h_ctl_yaw_setpoint = cmd;
  BoundAbs(h_ctl_yaw_setpoint, h_ctl_yaw_max_setpoint*speed_depend_nav);
  h_ctl_roll_setpoint = h_ctl_course_pre_bank_correction * h_ctl_course_pre_bank;
  BoundAbs(h_ctl_roll_setpoint, h_ctl_roll_max_setpoint*speed_depend_nav);
  
#else
  h_ctl_roll_setpoint = cmd + h_ctl_course_pre_bank_correction * h_ctl_course_pre_bank;
  BoundAbs(h_ctl_roll_setpoint, h_ctl_roll_max_setpoint*speed_depend_nav); ///v_ctl_auto_throttle_nominal_cruise_throttle*(v_ctl_throttle_setpoint*((float)MAX_PPRZ))
#endif
}

void h_ctl_attitude_loop ( void ) {
  if (!h_ctl_disabled) {
    h_ctl_roll_loop();
    h_ctl_pitch_loop();
#ifdef COMMAND_YAW
    h_ctl_yaw_loop();
#endif
  }
}

/** Computes h_ctl_aileron_setpoint from h_ctl_roll_setpoint */
inline static void h_ctl_roll_loop( void ) {

  float throttle_dep_pgain =
    Blend(h_ctl_hi_throttle_roll_rate_pgain, h_ctl_lo_throttle_roll_rate_pgain, v_ctl_throttle_setpoint/((float)MAX_PPRZ));

float err;
float cmd;
if (h_ctl_attitude_enabled)
{
  err = h_ctl_roll_setpoint-estimator_phi;
  cmd = throttle_dep_pgain * err;
}
else
{
  err = h_ctl_roll_setpoint;
  cmd = h_ctl_roll_setpoint/AUTO1_MAX_ROLL*MAX_PPRZ;
}


  h_ctl_aileron_setpoint = TRIM_PPRZ(cmd);


#if defined(H_CTL_RATE_LOOP) || defined(CTL_ROLL_RATE)
if (h_ctl_attitude_enabled) {
    h_ctl_roll_rate_setpoint = h_ctl_roll_rate_setpoint_pgain * err;
}
else {
    h_ctl_roll_rate_setpoint = h_ctl_roll_setpoint/AUTO1_MAX_ROLL*h_ctl_roll_rate_setpoint_pgain; //set by pilot, roll rate actually
}
    BoundAbs(h_ctl_roll_rate_setpoint, H_CTL_ROLL_RATE_MAX_SETPOINT);
    
    float saved_aileron_setpoint = h_ctl_aileron_setpoint;
    h_ctl_roll_rate_loop();
    h_ctl_aileron_setpoint = Blend(h_ctl_aileron_setpoint, saved_aileron_setpoint, h_ctl_roll_rate_mode) ;
#endif
}

#if defined( H_CTL_RATE_LOOP) || defined(CTL_ROLL_RATE)
static inline void h_ctl_roll_rate_loop() {
  float err = h_ctl_roll_rate_setpoint-estimator_p;
  
  /* I term calculation */
  static float roll_rate_sum_err = 0.;
  static uint8_t roll_rate_sum_idx = 0;
  static float roll_rate_sum_values[H_CTL_ROLL_RATE_SUM_NB_SAMPLES];
  
  roll_rate_sum_err -= roll_rate_sum_values[roll_rate_sum_idx];
  roll_rate_sum_values[roll_rate_sum_idx] = err;
  roll_rate_sum_err += err;
  roll_rate_sum_idx++;
  if (roll_rate_sum_idx >= H_CTL_ROLL_RATE_SUM_NB_SAMPLES) roll_rate_sum_idx = 0;
  
  /* D term calculations */
  static float last_err = 0;
  float d_err = err - last_err;
  last_err = err;
  
  float throttle_dep_pgain =
    Blend(h_ctl_hi_throttle_roll_rate_pgain, h_ctl_lo_throttle_roll_rate_pgain, v_ctl_throttle_setpoint/((float)MAX_PPRZ));
  //float cmd = throttle_dep_pgain * ( err + h_ctl_roll_rate_igain * roll_rate_sum_err / H_CTL_ROLL_RATE_SUM_NB_SAMPLES + h_ctl_roll_rate_dgain * d_err);
  float cmd = throttle_dep_pgain * ( err);
  h_ctl_aileron_setpoint = TRIM_PPRZ(cmd);
}
#endif /* H_CTL_RATE_LOOP */

inline static void h_ctl_pitch_loop( void ) {
  static float last_err;
  /* sanity check */
  if (h_ctl_elevator_of_roll <0.)
    h_ctl_elevator_of_roll = 0.;


float err;
float d_err;
float cmd;

  float throttle_dep_pgain =
    Blend(h_ctl_hi_throttle_pitch_rate_pgain, h_ctl_lo_throttle_pitch_rate_pgain, v_ctl_throttle_setpoint/((float)MAX_PPRZ));


if (h_ctl_attitude_enabled)
{
  
  #ifdef TRANSITION
    err = h_ctl_pitch_setpoint+h_ctl_pitch_state_setpoint-estimator_theta;
  #else
    err = h_ctl_pitch_setpoint-estimator_theta;
  #endif
  d_err = err - last_err;
  last_err = err;
  cmd = throttle_dep_pgain * (err + h_ctl_pitch_dgain * d_err)   
    + h_ctl_elevator_of_roll * fabs(estimator_phi);

#ifdef LOITER_TRIM
  cmd += loiter();
#endif

  h_ctl_elevator_setpoint = TRIM_PPRZ(cmd);
}
else {
  #ifdef TRANSITION
    err = h_ctl_pitch_setpoint+h_ctl_pitch_state_setpoint;
  #else
    err = h_ctl_pitch_setpoint;
  #endif

  cmd = h_ctl_pitch_setpoint/AUTO1_MAX_PITCH*MAX_PPRZ;
}
#ifdef TRANSITION
  desired_pitch=h_ctl_pitch_setpoint+h_ctl_pitch_state_setpoint;
#else
  desired_pitch=h_ctl_pitch_setpoint;
#endif
  desired_roll=h_ctl_roll_setpoint;

#if defined(CTL_PITCH_RATE)
if (h_ctl_attitude_enabled) {
    h_ctl_pitch_rate_setpoint = h_ctl_pitch_rate_setpoint_pgain * err;
}
else {// no attitude estimation, control in auto1

    h_ctl_pitch_rate_setpoint = h_ctl_pitch_setpoint/AUTO1_MAX_PITCH*h_ctl_pitch_rate_setpoint_pgain; //set by pilot, pitch rate actually
}
    BoundAbs(h_ctl_pitch_rate_setpoint, H_CTL_PITCH_RATE_MAX_SETPOINT);
    
    float saved_elevator_setpoint = h_ctl_elevator_setpoint;
    h_ctl_pitch_rate_loop();
    h_ctl_elevator_setpoint = Blend(h_ctl_elevator_setpoint, saved_elevator_setpoint, h_ctl_pitch_rate_mode) ;
#endif
}

#if defined(CTL_PITCH_RATE)
static inline void h_ctl_pitch_rate_loop() {
  float err = h_ctl_pitch_rate_setpoint-estimator_q;
  
  float throttle_dep_pgain =
    Blend(h_ctl_hi_throttle_pitch_rate_pgain, h_ctl_lo_throttle_pitch_rate_pgain, v_ctl_throttle_setpoint/((float)MAX_PPRZ));
  float cmd = throttle_dep_pgain * ( err );

  h_ctl_elevator_setpoint = TRIM_PPRZ(cmd);
}
#endif /* H_CTL_RATE_LOOP */

#ifdef COMMAND_YAW
inline static void h_ctl_yaw_loop( void ) {
  static float last_err;
  /* sanity check */

#if defined(ATTITUDE_YAW)
  float err = h_ctl_yaw_setpoint-estimator_psi;
  float cmd = h_ctl_yaw_pgain*err;

#else
  float err = h_ctl_yaw_setpoint;
  float cmd=err/AUTO1_MAX_YAW*MAX_PPRZ;


#endif


  h_ctl_rudder_setpoint = TRIM_PPRZ(cmd);

#if defined(CTL_YAW_RATE)
#if defined(ATTITUDE_YAW)
    h_ctl_yaw_rate_setpoint = h_ctl_yaw_rate_setpoint_pgain * err;
#else
    h_ctl_yaw_rate_setpoint = h_ctl_yaw_setpoint/AUTO1_MAX_YAW*h_ctl_yaw_rate_setpoint_pgain;
#endif
    BoundAbs(h_ctl_yaw_rate_setpoint, H_CTL_YAW_RATE_MAX_SETPOINT);
    
    float saved_rudder_setpoint = h_ctl_rudder_setpoint;
    h_ctl_yaw_rate_loop();
    h_ctl_rudder_setpoint = Blend(h_ctl_rudder_setpoint, saved_rudder_setpoint, h_ctl_yaw_rate_mode) ;
#endif



}

#if defined(CTL_YAW_RATE)
static inline void h_ctl_yaw_rate_loop() {
  float err = h_ctl_yaw_rate_setpoint-estimator_r;
  
  float throttle_dep_pgain =
    Blend(h_ctl_hi_throttle_yaw_rate_pgain, h_ctl_lo_throttle_yaw_rate_pgain, v_ctl_throttle_setpoint/((float)MAX_PPRZ));
  float cmd = throttle_dep_pgain * ( err);

  h_ctl_rudder_setpoint = TRIM_PPRZ(cmd);
}
#endif /* H_CTL_RATE_LOOP */

#endif /*COMMAND_YAW*/

#ifdef LOITER_TRIM

inline static float loiter(void) {
  static float last_elevator_trim;
  float elevator_trim;

  float throttle_dif = v_ctl_auto_throttle_cruise_throttle - v_ctl_auto_throttle_nominal_cruise_throttle;
  if (throttle_dif > 0) {
    float max_dif = Max(V_CTL_AUTO_THROTTLE_MAX_CRUISE_THROTTLE - v_ctl_auto_throttle_nominal_cruise_throttle, 0.1);
    elevator_trim = throttle_dif / max_dif * v_ctl_auto_throttle_dash_trim;
  } else {
    float max_dif = Max(v_ctl_auto_throttle_nominal_cruise_throttle - V_CTL_AUTO_THROTTLE_MIN_CRUISE_THROTTLE, 0.1);
    elevator_trim = - throttle_dif / max_dif * v_ctl_auto_throttle_loiter_trim;
  }

  float max_change = (v_ctl_auto_throttle_loiter_trim - v_ctl_auto_throttle_dash_trim) / 80.;
  Bound(elevator_trim, last_elevator_trim - max_change, last_elevator_trim + max_change);

  last_elevator_trim = elevator_trim;
  return elevator_trim;
}
#endif
