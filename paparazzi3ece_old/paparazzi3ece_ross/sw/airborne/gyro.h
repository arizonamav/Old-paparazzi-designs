/*
 * $Id: gyro.h,v 1.6 2006/10/19 06:55:07 poine Exp $
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

/** \file gyro.h
 * \brief Basic code for gyro acquisition on ADC channels
 *
*/

#ifndef GYRO_H
#define GYRO_H

#include <inttypes.h>



/** Raw (for debug), taking into accound neutral and temp compensation (if any) */
#ifdef ADC_CHANNEL_GYRO_ROLL
extern int16_t roll_rate_adc;
extern float gyro_roll_scale;
extern float gyro_roll_adc;
#endif
#ifdef ADC_CHANNEL_GYRO_PITCH
extern int16_t pitch_rate_adc;
extern float gyro_pitch_scale;
extern float gyro_pitch_adc;
#endif
#ifdef ADC_CHANNEL_GYRO_YAW
extern int16_t yaw_rate_adc;
extern float gyro_yaw_scale;
extern float gyro_yaw_adc;
#endif

/** Hardware dependent code */
#ifdef ADXRS150
extern float temp_comp;
#endif

#ifdef GYRO
void gyro_init( void );

/** Sets roll_rate, roll_rate_adc and pitch_rate (or temp_comp) */
void gyro_update( void );

#endif

#endif /* GYRO_H */
