/*
 * Paparazzi $Id: fw_h_ctl.h,v 1.5 2006/10/28 02:06:15 hecto Exp $
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

#ifndef FW_H_CTL_H
#define FW_H_CTL_H

#include <inttypes.h>
#include "std.h"
#include "paparazzi.h"

/* outer loop parameters */
extern float h_ctl_course_setpoint;
extern float h_ctl_course_pre_bank;
extern float h_ctl_course_pre_bank_correction;
extern float h_ctl_course_pgain;
extern float h_ctl_roll_max_setpoint;
extern float h_ctl_pitch_max_setpoint;
extern float h_ctl_pitch_min_setpoint;
extern float h_ctl_yaw_max_setpoint;

/* roll and pitch disabling */
extern bool_t h_ctl_disabled;

/* AUTO1 rate mode */
extern bool_t h_ctl_auto1_rate;
extern bool_t h_ctl_attitude_enabled;

/* inner roll loop parameters */
extern float  h_ctl_roll_setpoint;
extern float  h_ctl_roll_pgain;
extern pprz_t h_ctl_aileron_setpoint;

/* inner pitch loop parameters */
extern float  h_ctl_pitch_setpoint;
#ifdef TRANSITION
extern float h_ctl_pitch_state_setpoint;
extern float h_ctl_mid_aoa_roll_rate_pgain;
extern float h_ctl_mid_aoa_pitch_rate_pgain;
extern float h_ctl_mid_aoa_yaw_rate_pgain;
extern float h_ctl_mid_aoa_elevator_of_roll;
extern float h_ctl_hi_aoa_roll_rate_pgain;
extern float h_ctl_hi_aoa_pitch_rate_pgain;
extern float h_ctl_hi_aoa_yaw_rate_pgain;
extern float h_ctl_hi_aoa_elevator_of_roll;
extern float h_ctl_lo_aoa_roll_rate_pgain;
extern float h_ctl_lo_aoa_pitch_rate_pgain;
extern float h_ctl_lo_aoa_yaw_rate_pgain;
extern float h_ctl_lo_aoa_elevator_of_roll;
#endif
extern float desired_pitch, desired_roll;
extern float  h_ctl_pitch_pgain;
extern float  h_ctl_pitch_dgain;
extern pprz_t h_ctl_elevator_setpoint;

/* inner pitch loop parameters */
extern float  h_ctl_yaw_setpoint;
extern float  h_ctl_yaw_pgain;
extern float  h_ctl_yaw_dgain;
extern pprz_t h_ctl_rudder_setpoint;

/* inner loop pre-command */
extern float h_ctl_aileron_of_throttle;
extern float h_ctl_elevator_of_roll;

/* roll loop */
extern float h_ctl_roll_rate_setpoint;
extern float h_ctl_roll_rate_mode;
extern float h_ctl_roll_rate_setpoint_pgain;
extern float h_ctl_hi_throttle_roll_rate_pgain;
extern float h_ctl_lo_throttle_roll_rate_pgain;
extern float h_ctl_roll_rate_igain;
extern float h_ctl_roll_rate_dgain;

/* pitch loop */
extern float h_ctl_pitch_rate_setpoint;
extern float h_ctl_pitch_rate_mode;
extern float h_ctl_pitch_rate_setpoint_pgain;
extern float h_ctl_hi_throttle_pitch_rate_pgain;
extern float h_ctl_lo_throttle_pitch_rate_pgain;
extern float h_ctl_pitch_rate_igain;
extern float h_ctl_pitch_rate_dgain;
#ifdef TRANSITION
extern uint8_t transition_mode;
#endif

/* yaw loop */
extern float h_ctl_yaw_rate_setpoint;
extern float h_ctl_yaw_rate_mode;
extern float h_ctl_yaw_rate_setpoint_pgain;
extern float h_ctl_hi_throttle_yaw_rate_pgain;
extern float h_ctl_lo_throttle_yaw_rate_pgain;
extern float h_ctl_yaw_rate_igain;
extern float h_ctl_yaw_rate_dgain;



extern void h_ctl_init( void );
extern void h_ctl_course_loop ( void );
extern void h_ctl_attitude_loop ( void );

#endif /* FW_H_CTL_H */
