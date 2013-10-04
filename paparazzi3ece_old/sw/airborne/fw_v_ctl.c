/*
 * $Id: fw_v_ctl.c,v 1.5 2006/11/14 21:26:00 hecto Exp $
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
 *  \file v_ctl_ctl
 *  \brief Vertical control for fixed wing vehicles.
 *
 */

#include "autopilot.h"
#include "fw_v_ctl.h"
#include "estimator.h"
#include "nav.h"
#include "airframe.h"


#if defined(RANGE) && defined(RANGE_ALT)
#warning "Using range finder for altitude estimation"
#endif

#ifndef CONTROL_RATE
#define CONTROL_RATE 20
#endif


/* mode */
uint8_t v_ctl_mode;

/* outer loop */
float v_ctl_altitude_setpoint;
float v_ctl_altitude_pre_climb;
float v_ctl_altitude_pgain;
float v_ctl_altitude_error;
float v_ctl_alt_sum_err;
/* inner loop */
float v_ctl_climb_setpoint;
uint8_t v_ctl_climb_mode;
uint8_t v_ctl_auto_throttle_submode;

/* "auto throttle" inner loop parameters */
float v_ctl_auto_throttle_cruise_throttle;
float v_ctl_auto_throttle_cruise_throttle_pgain;
float v_ctl_auto_throttle_nominal_cruise_throttle;
#ifdef AUTO2_MANUAL_HOVERING 
float v_ctl_auto_throttle_climb_throttle_increment_plus;
float v_ctl_auto_throttle_climb_throttle_increment_minus;
float v_ctl_auto_throttle_pgain_plus;
float v_ctl_auto_throttle_pgain_minus;
float v_ctl_auto_throttle_igain_plus;
float v_ctl_auto_throttle_igain_minus;
/*Created to reduce reaction of hovering range sensor to obstacles (tables, chairs, windows etc)*/
#ifdef HOVERING_OBSTACLE_AVOIDANCE
float v_ctl_auto_throttle_cruise_throttle_pgain2;
float v_ctl_altitude_pgain2;
float v_ctl_auto_throttle_climb_throttle_increment_plus2;
float v_ctl_auto_throttle_climb_throttle_increment_minus2;
float v_ctl_auto_throttle_pgain_plus2;
float v_ctl_auto_throttle_pgain_minus2;
float v_ctl_auto_throttle_igain_plus2;
float v_ctl_auto_throttle_igain_minus2;
#endif
/***/
#endif
float v_ctl_auto_throttle_climb_throttle_increment;
float v_ctl_auto_throttle_pgain;

float v_ctl_auto_throttle_igain;
//float v_ctl_auto_throttle_sum_err;
#define V_CTL_AUTO_THROTTLE_MAX_SUM_ERR 150
float v_ctl_auto_throttle_pitch_of_vz_pgain;

/* "auto pitch" inner loop parameters */
float v_ctl_auto_pitch_pgain;
float v_ctl_auto_pitch_igain;
float v_ctl_auto_pitch_sum_err;
#define V_CTL_AUTO_PITCH_MAX_SUM_ERR 100

float v_ctl_throttle_slew_;
pprz_t v_ctl_throttle_setpoint;
pprz_t v_ctl_throttle_slewed;

float desc_throttle;
float climb_throttle;

inline static void v_ctl_climb_auto_throttle_loop( void );
inline static void v_ctl_climb_auto_pitch_loop( void );

#ifndef V_CTL_AUTO_THROTTLE_CRUISE_THROTTLE_PGAIN
#define V_CTL_AUTO_THROTTLE_CRUISE_THROTTLE_PGAIN 0
#endif

void v_ctl_init( void ) {
  /*voltage drop compensation*/
#if defined(V_CTL_VDROP2THROTTLE)
  //drop2throt_coeff=V_CTL_VDROP2THROTTLE;
#else
  vdrop2throt_coeff=369;
#endif
  /* mode */
  v_ctl_mode = V_CTL_MODE_MANUAL;

  /* outer loop */
  v_ctl_altitude_setpoint = 0.;
  v_ctl_altitude_pre_climb = 0.;
  v_ctl_altitude_pgain = V_CTL_ALTITUDE_PGAIN;
  v_ctl_altitude_error = 0.;
  v_ctl_alt_sum_err = 0.;

  /* inner loops */
  v_ctl_climb_setpoint = 0.;
  v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
#ifdef AGR_CLIMB
  v_ctl_auto_throttle_submode = V_CTL_AUTO_THROTTLE_STANDARD;
  climb_throttle=AGR_CLIMB_THROTTLE;
  desc_throttle=AGR_DESCENT_THROTTLE;
#endif

  /* "auto throttle" inner loop parameters */
  v_ctl_auto_throttle_nominal_cruise_throttle = V_CTL_AUTO_THROTTLE_NOMINAL_CRUISE_THROTTLE;
  v_ctl_auto_throttle_cruise_throttle_pgain=V_CTL_AUTO_THROTTLE_CRUISE_THROTTLE_PGAIN;
  v_ctl_auto_throttle_cruise_throttle = v_ctl_auto_throttle_nominal_cruise_throttle;
#ifdef AUTO2_MANUAL_HOVERING 
  v_ctl_auto_throttle_climb_throttle_increment_plus = V_CTL_AUTO_THROTTLE_CLIMB_THROTTLE_INCREMENT_PLUS;
  v_ctl_auto_throttle_climb_throttle_increment_minus = V_CTL_AUTO_THROTTLE_CLIMB_THROTTLE_INCREMENT_MINUS;
  v_ctl_auto_throttle_pgain_plus = V_CTL_AUTO_THROTTLE_PGAIN_PLUS;
  v_ctl_auto_throttle_pgain_minus = V_CTL_AUTO_THROTTLE_PGAIN_MINUS;
  v_ctl_auto_throttle_igain_plus=V_CTL_AUTO_THROTTLE_IGAIN_PLUS;
  v_ctl_auto_throttle_igain_minus=V_CTL_AUTO_THROTTLE_IGAIN_MINUS;
  #ifdef HOVERING_OBSTACLE_AVOIDANCE
    v_ctl_auto_throttle_cruise_throttle_pgain2=V_CTL_AUTO_THROTTLE_CRUISE_THROTTLE_PGAIN2;
    v_ctl_altitude_pgain2 = V_CTL_ALTITUDE_PGAIN2;
    v_ctl_auto_throttle_climb_throttle_increment_plus2 = V_CTL_AUTO_THROTTLE_CLIMB_THROTTLE_INCREMENT_PLUS2;
    v_ctl_auto_throttle_climb_throttle_increment_minus2 = V_CTL_AUTO_THROTTLE_CLIMB_THROTTLE_INCREMENT_MINUS2;
    v_ctl_auto_throttle_pgain_plus2 = V_CTL_AUTO_THROTTLE_PGAIN_PLUS2;
    v_ctl_auto_throttle_pgain_minus2 = V_CTL_AUTO_THROTTLE_PGAIN_MINUS2;
    v_ctl_auto_throttle_igain_plus2=V_CTL_AUTO_THROTTLE_IGAIN_PLUS2;
    v_ctl_auto_throttle_igain_minus2=V_CTL_AUTO_THROTTLE_IGAIN_MINUS2;
  #endif
#else
  v_ctl_auto_throttle_climb_throttle_increment = V_CTL_AUTO_THROTTLE_CLIMB_THROTTLE_INCREMENT;
  v_ctl_auto_throttle_pgain = V_CTL_AUTO_THROTTLE_PGAIN;
#endif
  
  v_ctl_auto_throttle_igain = V_CTL_AUTO_THROTTLE_IGAIN;
  v_ctl_auto_throttle_pitch_of_vz_pgain = V_CTL_AUTO_THROTTLE_PITCH_OF_VZ_PGAIN; 

  /* "auto pitch" inner loop parameters */
  v_ctl_auto_pitch_pgain = V_CTL_AUTO_PITCH_PGAIN;
  v_ctl_auto_pitch_igain = V_CTL_AUTO_PITCH_IGAIN;
  v_ctl_auto_pitch_sum_err = 0.;

  v_ctl_throttle_slew_=V_CTL_THROTTLE_SLEW;
  v_ctl_throttle_setpoint = 0;
  v_ctl_throttle_slewed = 0;
}

#ifndef V_CTL_ALT_ERR_SUM_NB_SAMPLES
#define V_CTL_ALT_ERR_SUM_NB_SAMPLES 20
#endif

/** 
 * outer loop
 * \brief Computes v_ctl_climb_setpoint and sets v_ctl_auto_throttle_submode 
 */
void v_ctl_altitude_loop( void ) {
  v_ctl_altitude_error = v_ctl_altitude_setpoint-estimator_z; //v_ctl_altitude_pgain>0 
	#ifdef HOVERING_OBSTACLE_AVOIDANCE
	if (v_ctl_altitude_error>0.3){
		v_ctl_climb_setpoint = v_ctl_altitude_pgain2 * v_ctl_altitude_error+ v_ctl_altitude_pre_climb;}
	else{
		v_ctl_climb_setpoint = v_ctl_altitude_pgain * v_ctl_altitude_error+ v_ctl_altitude_pre_climb;}
	#else
	 v_ctl_climb_setpoint = v_ctl_altitude_pgain * v_ctl_altitude_error + v_ctl_altitude_pre_climb;
	#endif
  BoundAbs(v_ctl_climb_setpoint, V_CTL_ALTITUDE_MAX_CLIMB);

  /* I term calculation */
  static uint8_t alt_err_sum_idx = 0;
  static float alt_err_sum_values[V_CTL_ALT_ERR_SUM_NB_SAMPLES];

  v_ctl_alt_sum_err -= alt_err_sum_values[alt_err_sum_idx];
  alt_err_sum_values[alt_err_sum_idx] = v_ctl_altitude_error/CONTROL_RATE;
  v_ctl_alt_sum_err += alt_err_sum_values[alt_err_sum_idx];
  alt_err_sum_idx++;
  if (alt_err_sum_idx >= V_CTL_ALT_ERR_SUM_NB_SAMPLES)
  { 
	alt_err_sum_idx = 0;
 	#ifdef HOVERING_OBSTACLE_AVOIDANCE
	if (v_ctl_altitude_error>0.3){
			v_ctl_auto_throttle_cruise_throttle += v_ctl_auto_throttle_cruise_throttle_pgain2*v_ctl_alt_sum_err;}
	else{
		v_ctl_auto_throttle_cruise_throttle += v_ctl_auto_throttle_cruise_throttle_pgain*v_ctl_alt_sum_err;}
	#else
	v_ctl_auto_throttle_cruise_throttle += v_ctl_auto_throttle_cruise_throttle_pgain*v_ctl_alt_sum_err;
	#endif
  }


#ifdef AGR_CLIMB
  if ( v_ctl_climb_mode == V_CTL_CLIMB_MODE_AUTO_THROTTLE) {
    float dist = fabs(v_ctl_altitude_error);
    if (dist < AGR_BLEND_END) {
      v_ctl_auto_throttle_submode = V_CTL_AUTO_THROTTLE_STANDARD;
    }
    else if (dist > AGR_BLEND_START) {
      v_ctl_auto_throttle_submode = V_CTL_AUTO_THROTTLE_AGRESSIVE;
    }
    else {
      v_ctl_auto_throttle_submode = V_CTL_AUTO_THROTTLE_BLENDED;
    }
  }
#endif
}

void v_ctl_climb_loop ( void ) {
  switch (v_ctl_climb_mode) {
  case V_CTL_CLIMB_MODE_AUTO_THROTTLE:
    v_ctl_climb_auto_throttle_loop();
    break;
  case V_CTL_CLIMB_MODE_AUTO_PITCH:
    v_ctl_climb_auto_pitch_loop();
    break;
  }
}

/** 
 * auto throttle inner loop
 * \brief 
 */
inline static void v_ctl_climb_auto_throttle_loop(void) {
  float f_throttle = 0;
  float err  = v_ctl_climb_setpoint-estimator_z_dot;

#ifdef AUTO2_MANUAL_HOVERING 
#ifdef HOVERING_OBSTACLE_AVOIDANCE
  if (v_ctl_altitude_error>0.3){
    if (v_ctl_climb_setpoint>0) v_ctl_auto_throttle_climb_throttle_increment=v_ctl_auto_throttle_climb_throttle_increment_plus2;
    else v_ctl_auto_throttle_climb_throttle_increment=v_ctl_auto_throttle_climb_throttle_increment_minus2;
    if (err<0) v_ctl_auto_throttle_pgain=v_ctl_auto_throttle_pgain_plus2;
    else v_ctl_auto_throttle_pgain=v_ctl_auto_throttle_pgain_minus2;
    if (v_ctl_alt_sum_err<0) v_ctl_auto_throttle_igain=v_ctl_auto_throttle_igain_plus2;
    else v_ctl_auto_throttle_igain=v_ctl_auto_throttle_igain_minus2;
    }
  else{
    if (v_ctl_climb_setpoint>0) v_ctl_auto_throttle_climb_throttle_increment=v_ctl_auto_throttle_climb_throttle_increment_plus;
    else v_ctl_auto_throttle_climb_throttle_increment=v_ctl_auto_throttle_climb_throttle_increment_minus;
    if (err<0) v_ctl_auto_throttle_pgain=v_ctl_auto_throttle_pgain_plus;
    else v_ctl_auto_throttle_pgain=v_ctl_auto_throttle_pgain_minus;
    if (v_ctl_alt_sum_err<0) v_ctl_auto_throttle_igain=v_ctl_auto_throttle_igain_plus;
    else v_ctl_auto_throttle_igain=v_ctl_auto_throttle_igain_minus;
  }
#else
  if (v_ctl_climb_setpoint>0) v_ctl_auto_throttle_climb_throttle_increment=v_ctl_auto_throttle_climb_throttle_increment_plus;
  else v_ctl_auto_throttle_climb_throttle_increment=v_ctl_auto_throttle_climb_throttle_increment_minus;
  if (err<0) v_ctl_auto_throttle_pgain=v_ctl_auto_throttle_pgain_plus;
  else v_ctl_auto_throttle_pgain=v_ctl_auto_throttle_pgain_minus;
  if (v_ctl_alt_sum_err<0) v_ctl_auto_throttle_igain=v_ctl_auto_throttle_igain_plus;
  else v_ctl_auto_throttle_igain=v_ctl_auto_throttle_igain_minus;
#endif
#endif

//v_ctl_auto_throttle_climb_throttle_increment>0
//v_ctl_auto_throttle_pgain>0
  float controlled_throttle = 
    v_ctl_auto_throttle_cruise_throttle + 
    v_ctl_auto_throttle_climb_throttle_increment * v_ctl_climb_setpoint 
    + v_ctl_auto_throttle_pgain *err
    + v_ctl_auto_throttle_igain * v_ctl_alt_sum_err;




  /* pitch pre-command */
  float v_ctl_pitch_of_vz = v_ctl_climb_setpoint * v_ctl_auto_throttle_pitch_of_vz_pgain;

#if defined AGR_CLIMB
  switch (v_ctl_auto_throttle_submode) {
  case V_CTL_AUTO_THROTTLE_AGRESSIVE:
    if (v_ctl_climb_setpoint > 0) { /* Climbing */
      f_throttle =  climb_throttle;
      nav_pitch = AGR_CLIMB_PITCH;
    } 
    else { /* Going down */
      f_throttle =  desc_throttle;
      nav_pitch = AGR_DESCENT_PITCH;
    }
    break;
    
  case V_CTL_AUTO_THROTTLE_BLENDED: {
    float ratio = (fabs(v_ctl_altitude_error) - AGR_BLEND_END) 
      / (AGR_BLEND_START - AGR_BLEND_END);
    f_throttle = (1-ratio) * controlled_throttle;
    nav_pitch = (1-ratio) * v_ctl_pitch_of_vz;
    //v_ctl_auto_throttle_sum_err += (1-ratio) * err;
    if (v_ctl_altitude_error < 0) {
      f_throttle +=  ratio * climb_throttle;
      nav_pitch += ratio * AGR_CLIMB_PITCH;
    } else {
      f_throttle += ratio * desc_throttle;
      nav_pitch += ratio * AGR_DESCENT_PITCH;
    }
    break;
  }
    
  case V_CTL_AUTO_THROTTLE_STANDARD:
#endif
    f_throttle = controlled_throttle;

  nav_pitch += v_ctl_pitch_of_vz;
#if defined AGR_CLIMB
    break;
  } /* switch submode */
#endif
  v_ctl_throttle_setpoint = TRIM_UPPRZ(f_throttle * MAX_PPRZ);
}


/** 
 * auto pitch inner loop
 * \brief computes a nav_pitch from a climb_setpoint given a fixed throttle
 */
inline static void v_ctl_climb_auto_pitch_loop(void) {
  float err  = v_ctl_climb_setpoint-estimator_z_dot;
  v_ctl_throttle_setpoint = nav_throttle_setpoint;
  v_ctl_auto_pitch_sum_err += err;
  BoundAbs(v_ctl_auto_pitch_sum_err, V_CTL_AUTO_PITCH_MAX_SUM_ERR);
  nav_pitch = v_ctl_auto_pitch_pgain * 
    (err + v_ctl_auto_pitch_igain * v_ctl_auto_pitch_sum_err);
  Bound(nav_pitch, V_CTL_AUTO_PITCH_MIN_PITCH, V_CTL_AUTO_PITCH_MAX_PITCH);
}

#ifndef V_CTL_THROTTLE_SLEW
#define V_CTL_THROTTLE_SLEW 1.
#endif
void v_ctl_throttle_slew( void ) {
  pprz_t diff_throttle = v_ctl_throttle_setpoint - v_ctl_throttle_slewed;
  BoundAbs(diff_throttle, TRIM_PPRZ(v_ctl_throttle_slew_*MAX_PPRZ));
  v_ctl_throttle_slewed += diff_throttle;
}
