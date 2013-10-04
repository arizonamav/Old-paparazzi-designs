/*
 * $Id: guide.c,v 1.5 2006/09/08 07:09:49 roman Exp $
 *  
 * Copyright (C) 2003  Pascal Brisset, Antoine Drouin
 * by Roman Krashanitsa 2006
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

/** \file guide.c
 *  \brief guidance functions for the aircraft.
 *
 */

#include <stdlib.h>
#include <math.h>

#include "autopilot.h"
#include "infrared.h"
#include "estimator.h"
#include "nav.h"
#include "pid.h"


bool airplane_controllable=true;

/** \brief Detects abnormal behavior: desired altitude is too low, aircraft is falling*/
void constraint(void)
{
	if (nav_altitide<SECURITY_ALT && nav_desired_gaz>=CLIMB_LEVEL_GAZ)
	/*emergency - altitude is too low: set roll to zero, set safe new desired altitude*/
	{
		nav_desired_roll=0.0f;
		nav_altitude=SECURITY_ALT+5.0f;
	} //nav_altitude
	else if (nav_altitide<SECURITY_ALT && nav_desired_gaz<CLIMB_LEVEL_GAZ)
	{
		/*do nothing - airplane is landing*/
	}
}

/** \brief Limits roll and pitch to the safe values for given velocity*/
/* since there is no air speed sensor, the limit values do not depend on speed*/
void controllability(void)
{
	if (desired_roll>AUTO1_MAX_ROLL)
		desired_roll=AUTO1_MAX_ROLL;
	else if (desired_roll<-AUTO1_MAX_ROLL)
		desired_roll=-AUTO1_MAX_ROLL)
	else /*leave as it is*/;

	if (desired_pitch>AUTO1_MAX_PITCH)
		desired_pitch=AUTO1_MAX_PITCH;
	else /*leave as it is*/;
	if (estimator_z<SECURITY_ALT && estimator_z_dot>3.0f)
	/*emergency - aircraft is falling: set roll to zero, try to land or gain height*/
	/*here nav_altitude>SECURITY_ALTITUDE*/
	{
		if (estimator_z-GROUND_ALT<10.0f) /* too low - try to land */
			{
				nav_desired_roll=0.0f;
				nav_altitude=GROUND_ALT;
				nav_desired_gaz=0.2f*ClIMB_LEVEL_GAZ;
			}
		else /*try to gain altitude*/
			{
				nav_desired_roll=0.0f;
			}
	} // estimator
}

void statistics(void)
{

/**from nav.c**/

/**from course_pid_run**/
  float course_err = estimator_hspeed_dir - desired_course;
/**from climb_pid_run**/
  float climb_err  = estimator_z_dot - desired_climb;
  climb_sum_err += err;
/**from altitude_pid_run**/
  altitude_error = estimator_z - desired_altitude;


/** from pid.c **/
  float roll_err =  estimator_phi - desired_roll;
#ifndef ATTITUDE_RATE_MODE
  rollrate_err = roll_rate - desired_roll_rate;
  rollrate_sum_err -= rollratesum_values[rollratesum_idx];
  rollratesum_values[rollratesum_idx] = err;
  rollrate_sum_err += err;
  rollratesum_idx++;
  if (rollratesum_idx >= ROLLRATESUM_NB_SAMPLES) rollratesum_idx = 0;

  /* D term calculations */
  static float last_roll_rate;
  float roll_diff_err = roll_rate - last_roll_rate;
  last_roll_rate = roll_rate;
#endif

  /** Pitch pi */
  if (pitch_of_roll <0.)
    pitch_of_roll = 0.;
  err = -(estimator_theta - desired_pitch - pitch_of_roll*fabs(estimator_phi));

#ifdef PITCH_IGAIN
  pitch_sum_err -= pitchsum_values[pitchsum_idx];
  pitchsum_values[pitchsum_idx] = err;
  pitch_sum_err += pitchsum_values[pitchsum_idx];
  pitchsum_idx++;
  if (pitchsum_idx >= PITCHSUM_NB_SAMPLES) pitchsum_idx = 0;
#endif

  pprz_t diff_gaz = desired_gaz - last_gaz;








}





