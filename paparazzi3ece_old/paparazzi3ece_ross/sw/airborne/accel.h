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

/** \file accel.h
 * \brief Basic code for accelerator acquisition on ADC channels
 *
*/

#ifndef ACCEL_H
#define ACCEL_H

#include <inttypes.h>

/** Raw (for debug), taking into accound neutral and temp compensation (if any) */

/** Hardware dependent code */

float accel_ax_scale;
float accel_ay_scale;
float accel_az_scale;
float accel_ax_neutral;
float accel_ay_neutral;
float accel_az_neutral;

#if defined ADXL330
extern float accel_ax;
extern float accel_ay;
extern float accel_az;
extern int16_t accel_ax_adc;
extern int16_t accel_ay_adc;
extern int16_t accel_az_adc;

void accel_init( void );
void accel_update( void );
#endif

#endif /* ACCEL_H */
