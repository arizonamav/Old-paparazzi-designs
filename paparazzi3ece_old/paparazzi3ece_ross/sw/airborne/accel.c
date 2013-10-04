/*
 * $Id: accel.c,v 1.6 2006/10/19 06:55:07 poine Exp $
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

/** \file accel.c
 * \brief Basic code for accelerometer acquisition on ADC channels
 *
*/

#include CONFIG
#include "accel.h"
#include "std.h"
#include "adc.h"
#include "airframe.h"
#include "estimator.h"

#define RadiansOfADC(_adc, scale) RadOfDeg((_adc * scale))

#define g 9.82

float accel_ax;
float accel_ay;
float accel_az;

#if defined ADXL330
int16_t accel_ax_adc;
int16_t accel_ay_adc;
int16_t accel_az_adc;
static struct adc_buf buf_accel_ax;
static struct adc_buf buf_accel_ay;
static struct adc_buf buf_accel_az;
//float accel_ax_scale;
//float accel_ay_scale;
//float accel_az_scale;
//float accel_ax_neutral;
//float accel_ay_neutral;
//float accel_az_neutral;
#endif

void accel_init( void) {
#if defined ADXL330
  adc_buf_channel(ADC_CHANNEL_ACCEL_AX, &buf_accel_ax, ADC_CHANNEL_ACCEL_NB_SAMPLES);
  adc_buf_channel(ADC_CHANNEL_ACCEL_AY, &buf_accel_ay, ADC_CHANNEL_ACCEL_NB_SAMPLES);
  adc_buf_channel(ADC_CHANNEL_ACCEL_AZ, &buf_accel_az, ADC_CHANNEL_ACCEL_NB_SAMPLES);
  accel_ax_scale=ACCEL_AX_SCALE;
  accel_ay_scale=ACCEL_AY_SCALE;
  accel_az_scale=ACCEL_AZ_SCALE;
  accel_ax_neutral=ACCEL_AX_NEUTRAL;
  accel_ay_neutral=ACCEL_AY_NEUTRAL;
  accel_az_neutral=ACCEL_AZ_NEUTRAL;
#endif
}

void accel_update( void ) {
float ax=0.f;
float ay=0.f;
float az=0.f;
#ifdef ADXL330
  accel_ax_adc = (buf_accel_ax.sum/buf_accel_ax.av_nb_sample) - accel_ax_neutral; 
  ax = accel_ax_scale*accel_ax_adc;
  accel_ay_adc = (buf_accel_ay.sum/buf_accel_ay.av_nb_sample) - accel_ay_neutral; 
  ay = accel_ay_scale*accel_ay_adc;
  accel_az_adc = (buf_accel_az.sum/buf_accel_az.av_nb_sample) - accel_az_neutral; 
  az = accel_az_scale*accel_az_adc;
#endif
  EstimatorSetAccel(ax, ay, az);
}
-
