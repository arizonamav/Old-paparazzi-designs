/*
 * $Id: gyro.c,v 1.6 2006/10/19 06:55:07 poine Exp $
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

/** \file gyro.c
 * \brief Basic code for gyro acquisition on ADC channels
 *
*/

#include CONFIG
#include "gyro.h"
#include "std.h"
#include "adc.h"
#include "airframe.h"
#include "estimator.h"

#ifdef ADC_CHANNEL_GYRO_ROLL
#warning "gyro roll adc channel is defined."
float gyro_roll_scale;
float gyro_roll_adc;
struct adc_buf buf_roll;
#endif

#define RadiansOfADC(_adc, scale) RadOfDeg((_adc * scale))

#ifdef ADC_CHANNEL_GYRO_PITCH
#warning "gyro pitch adc channel is defined."
static struct adc_buf buf_pitch;
float gyro_pitch_scale;
float gyro_pitch_adc;
#endif

#ifdef ADC_CHANNEL_GYRO_YAW
#warning "gyro yaw adc channel is defined."
static struct adc_buf buf_yaw;
float gyro_yaw_scale;
float gyro_yaw_adc;
#endif

int16_t roll_rate_adc;
int16_t pitch_rate_adc;
int16_t yaw_rate_adc;

//#if defined ADXRS150
//static struct adc_buf buf_temp;
////float temp_comp;
//#elif defined IDG300
////int16_t pitch_rate_adc;
//static struct adc_buf buf_pitch;
////float gyro_roll_scale;
////float gyro_pitch_scale;
////float gyro_roll_adc;
////float gyro_pitch_adc;
//#endif

void gyro_init( void) {

#if defined ADXRS150
  adc_buf_channel(ADC_CHANNEL_GYRO_TEMP, &buf_temp, ADC_CHANNEL_GYRO_NB_SAMPLES);
#endif
#ifdef ADC_CHANNEL_GYRO_ROLL
  adc_buf_channel(ADC_CHANNEL_GYRO_ROLL, &buf_roll, ADC_CHANNEL_GYRO_NB_SAMPLES);
  gyro_roll_scale=GYRO_ROLL_SCALE;
  gyro_roll_adc=GYRO_ADC_ROLL_NEUTRAL;
#endif
#ifdef ADC_CHANNEL_GYRO_PITCH
  adc_buf_channel(ADC_CHANNEL_GYRO_PITCH, &buf_pitch, ADC_CHANNEL_GYRO_NB_SAMPLES);
  gyro_pitch_scale=GYRO_PITCH_SCALE;
  gyro_pitch_adc=GYRO_ADC_PITCH_NEUTRAL;
#endif
#ifdef ADC_CHANNEL_GYRO_YAW
  adc_buf_channel(ADC_CHANNEL_GYRO_YAW, &buf_yaw, ADC_CHANNEL_GYRO_NB_SAMPLES);
  gyro_yaw_scale=GYRO_YAW_SCALE;
  gyro_yaw_adc=GYRO_ADC_YAW_NEUTRAL;
#endif
}



void gyro_update( void ) {
  float pitch_rate = 0.;
  float yaw_rate = 0.;
  float roll_rate = 0.;

#ifdef ADXRS150
  temp_comp = buf_temp.sum/buf_temp.av_nb_sample - GYRO_ADC_TEMP_NEUTRAL;
  roll_rate_adc += GYRO_ADC_TEMP_SLOPE * temp_comp;
#endif
#ifdef ADC_CHANNEL_GYRO_ROLL 
  roll_rate_adc = (buf_roll.sum/buf_roll.av_nb_sample) - gyro_roll_adc; 
  roll_rate = GYRO_ROLL_DIRECTION * RadiansOfADC(roll_rate_adc, gyro_roll_scale);
#endif
#ifdef ADC_CHANNEL_GYRO_PITCH 
  pitch_rate_adc = buf_pitch.sum/buf_pitch.av_nb_sample - gyro_pitch_adc;
  pitch_rate = GYRO_PITCH_DIRECTION * RadiansOfADC(pitch_rate_adc, gyro_pitch_scale);
#endif
#ifdef ADC_CHANNEL_GYRO_YAW 
  yaw_rate_adc = buf_yaw.sum/buf_yaw.av_nb_sample - gyro_yaw_adc;
  yaw_rate = GYRO_YAW_DIRECTION * RadiansOfADC(yaw_rate_adc, gyro_yaw_scale);
#endif
  EstimatorSetRate(roll_rate, pitch_rate, yaw_rate);
}
