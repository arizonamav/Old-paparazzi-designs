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

/** \file range.c
 * \brief Basic code for ultrasonic range finder LV-MaxSonar-EZ1 acquisition on ADC channels
 *
*/

#include CONFIG
#include "range.h"
#include "std.h"
#include "adc.h"
#include "airframe.h"
#include "estimator.h"

float range;
float range_dot;
float range_scale;
float range_neutral;

#define SAMPLES 15
#define MEAN_VALUE_NB_SAMPLES 4

int16_t range_adc;
static struct adc_buf buf_range;
//float buf_range_dot[SAMPLES];
float buf_range_tmp[SAMPLES];
float buf_range_tmp1[MEAN_VALUE_NB_SAMPLES];
float range_ave;
float check;
float range_hovering;
int16_t pos,pos1;
//float sum_range_dot;
int16_t p_2, p_1, p0, p1, p2;


float c31[]={-0.0060, -0.0056, -0.0052, -0.0048, -0.0044, -0.0040, -0.0036, -0.0032, -0.0028, -0.0024, -0.0020, -0.0016, -0.0012, -0.0008, -0.0004,
             0.f, 0.0004, 0.0008, 0.0012, 0.0016, 0.0020, 0.0024, 0.0028, 0.0032, 0.0036, 0.0040, 0.0044, 0.0048, 0.0052, 0.0056, 0.0060};

float c15[]={-0.0250, -0.0214, -0.0179, -0.0143, -0.0107, -0.0071, -0.0036, 0.0f, 0.0036, 0.0071, 0.0107, 0.0143, 0.0179, 0.0214, 0.0250};


void range_init( void) {
  adc_buf_channel(ADC_CHANNEL_RANGE, &buf_range, ADC_CHANNEL_RANGE_NB_SAMPLES);
  range_scale=RANGE_SCALE;
  range_neutral=RANGE_NEUTRAL;
  for (pos=0; pos<SAMPLES; pos++) buf_range_tmp[pos]=0;
  pos=0; pos1=0;
  range_ave=0.f;
  range_hovering=0.f;
}

void range_update( void ) {

  int16_t j=0;
  int16_t strt=pos-SAMPLES;
  if (strt<0) strt=SAMPLES+strt; 
  

  range_adc = (buf_range.sum/buf_range.av_nb_sample) - range_neutral; 
  check=range_scale*range_adc;
  if (check<300){
  range = range_scale*range_adc;
  }
  range_ave-=buf_range_tmp1[pos1]/MEAN_VALUE_NB_SAMPLES;
  buf_range_tmp1[pos1]=range;
  range_ave+=buf_range_tmp1[pos1]/MEAN_VALUE_NB_SAMPLES;
  pos1++;
  if (pos1>=MEAN_VALUE_NB_SAMPLES) 
  {
	pos1=0;
        
  }

  if (fabs(range-range_ave)<20) 
  {
        range_hovering-=buf_range_tmp[pos]/SAMPLES;
        range_hovering+=range/SAMPLES;
	buf_range_tmp[pos]=range;
	pos++;
  	if (pos>=SAMPLES) pos=0;
  }
  else range=buf_range_tmp[pos];


  range_dot=0.f;
  while (strt+j<SAMPLES)
  {
    range_dot+=c15[j]*buf_range_tmp[strt+j];
    j++;
  }
  while (j<SAMPLES)
  {
    range_dot+=c15[j]*buf_range_tmp[strt+j-SAMPLES];
    j++;
  }
  range_dot*=20.f;


//  range_dot=(range-estimator_range)*20; 
//  if (range_dot>10.) range_dot=10.;
//  else if (range_dot<-10.) range_dot=-10.;
//  sum_range_dot-=buf_range_dot[pos]; 
//  buf_range_dot[pos]=range_dot; 
//  sum_range_dot+=buf_range_dot[pos]; 
//  pos++;
//  if (pos>=SAMPLES) pos=0;
//   range_dot=sum_range_dot/SAMPLES;
//  EstimatorSetRange(range,(range-estimator_range)*20); //CONTROL_RATE==20
  EstimatorSetRange(range,range_dot);
}
