/*
 * $Id: cam.h,v 1.3 2006/10/26 15:33:10 mmm Exp $
 *  
 * Copyright (C) 2005  Pascal Brisset, Antoine Drouin
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
/** \file cam.h
 *  \brief Pan/Tilt camera API
 *
 */

#ifndef CAM_H
#define CAM_H

#include <inttypes.h>


extern float phi_c, theta_c;
extern float target_x, target_y;

#define CamNull() { phi_c = 0; theta_c = 0; }
#define CamFix() {}

#define MAX_CAM_ROLL M_PI/4
#define MAX_CAM_PITCH M_PI/3

void cam_nadir(void);
void cam_target(void);
void cam_manual(void);
void cam_manual_target(void);
void cam_waypoint_target(uint8_t wp);
void cam_carrot(void);
void cam_ac_target( uint8_t ac_id );
#endif
