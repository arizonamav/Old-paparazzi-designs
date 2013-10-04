/*
 * Paparazzi $Id: fw_v_ctl.h,v 1.5 2006/11/14 21:26:00 hecto Exp $
 *  
 * Copyright (C) 2006  Pascal Brisset, Antoine Drouin
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
 * fixed wing vertical control
 *
 */

#ifndef FW_V_CTL_H
#define FW_V_CTL_H

#include <inttypes.h>
#include "paparazzi.h"

/* Vertical mode */
#define V_CTL_MODE_MANUAL        0
#define V_CTL_MODE_AUTO_THROTTLE 1
#define V_CTL_MODE_AUTO_CLIMB    2
#define V_CTL_MODE_AUTO_ALT      3
#define V_CTL_MODE_NB            4
extern uint8_t v_ctl_mode;

/* outer loop */
extern float v_ctl_altitude_setpoint;
extern float v_ctl_altitude_pre_climb;
extern float v_ctl_altitude_pgain;
extern float v_ctl_alt_sum_err;
/* inner loop */
extern float v_ctl_climb_setpoint;
extern uint8_t v_ctl_climb_mode;
#define V_CTL_CLIMB_MODE_AUTO_THROTTLE 0 
#define V_CTL_CLIMB_MODE_AUTO_PITCH    1

#ifdef AGR_CLIMB
extern uint8_t v_ctl_auto_throttle_submode;
#define V_CTL_AUTO_THROTTLE_STANDARD  0
#define V_CTL_AUTO_THROTTLE_AGRESSIVE 1
#define V_CTL_AUTO_THROTTLE_BLENDED   2
#endif

/* "auto throttle" inner loop parameters */
extern float v_ctl_auto_throttle_nominal_cruise_throttle;
extern float v_ctl_auto_throttle_cruise_throttle_pgain;
extern float v_ctl_auto_throttle_cruise_throttle;
#ifdef AUTO2_MANUAL_HOVERING 
extern float v_ctl_auto_throttle_climb_throttle_increment_plus;
extern float v_ctl_auto_throttle_climb_throttle_increment_minus;
extern float v_ctl_auto_throttle_pgain_plus;
extern float v_ctl_auto_throttle_pgain_minus;
extern float v_ctl_auto_throttle_igain_plus;
extern float v_ctl_auto_throttle_igain_minus;
/*Created to reduce reaction of hovering range sensor to obstacles (tables, chairs, windows etc)*/
#ifdef HOVERING_OBSTACLE_AVOIDANCE 
extern float v_ctl_auto_throttle_cruise_throttle_pgain2;
extern float v_ctl_altitude_pgain2;
extern float v_ctl_auto_throttle_climb_throttle_increment_plus2;
extern float v_ctl_auto_throttle_climb_throttle_increment_minus2;
extern float v_ctl_auto_throttle_pgain_plus2;
extern float v_ctl_auto_throttle_pgain_minus2;
extern float v_ctl_auto_throttle_igain_plus2;
extern float v_ctl_auto_throttle_igain_minus2;
#endif
/*****/
#endif
extern float v_ctl_auto_throttle_climb_throttle_increment;
extern float v_ctl_auto_throttle_pgain;
extern float v_ctl_auto_throttle_igain;
extern float v_ctl_auto_throttle_pitch_of_vz_pgain;
extern float v_ctl_throttle_slew_;
#ifdef LOITER_TRIM
extern float v_ctl_auto_throttle_loiter_trim;
extern float v_ctl_auto_throttle_dash_trim;
#endif

/* "auto pitch" inner loop parameters */
extern float v_ctl_auto_pitch_pgain;
extern float v_ctl_auto_pitch_igain;
extern float v_ctl_auto_pitch_sum_err;

extern pprz_t v_ctl_throttle_setpoint;
extern pprz_t v_ctl_throttle_slewed;

extern float climb_throttle;
extern float desc_throttle;

extern void v_ctl_init( void );
extern void v_ctl_altitude_loop( void );
extern void v_ctl_climb_loop ( void );

/** Computes throttle_slewed from throttle_setpoint */
extern void v_ctl_throttle_slew( void );

#endif /* FW_V_CTL_H */
