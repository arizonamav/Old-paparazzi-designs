/*
 * $Id: range.h
 *  
 * Copyright (C) 2006  Pascal Brisset, Antoine Drouin
 * Copyright (C) 2007 Roman Krashanitsa
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

/** \file range.h
 * \brief Basic code for ultrasonic range finder LV-MaxSonar-EZ1 acquisition on ADC channels
 *
*/

#ifndef RANGE_H
#define RANGE_H

#include <inttypes.h>


/** Hardware dependent code */


#if defined RANGE
extern float range_scale;
extern float range_neutral;
extern float range;
extern float range_ave;
extern float range_hovering;
extern int16_t range_adc;

void range_init( void );
void range_update( void );
#endif

#endif /* ACCEL_H */
