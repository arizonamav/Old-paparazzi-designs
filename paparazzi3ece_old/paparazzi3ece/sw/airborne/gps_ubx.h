/*
 * Paparazzi autopilot $Id: gps_ubx.h,v 1.5 2006/11/14 21:26:00 hecto Exp $
 *  
 * Copyright (C) 2004-2006  Pascal Brisset, Antoine Drouin
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

/** \file gps_ubx.h
 * \brief UBX protocol specific code
 *
*/


#ifndef UBX_H
#define UBX_H

#define GPS_NB_CHANNELS 16

extern uint8_t ubx_id, ubx_class;
#define UBX_MAX_PAYLOAD 255
extern uint8_t ubx_msg_buf[UBX_MAX_PAYLOAD];

/** The function to be called when a characted friom the device is available */
extern void parse_ubx( uint8_t c );

#define GpsParse(_gps_buffer, _gps_buffer_size) { \
  uint8_t i; \
  for(i = 0; i < _gps_buffer_size; i++) { \
    parse_ubx(_gps_buffer[i]); \
  } \
}

#define GpsFixValid() (gps_mode == 3)

#endif /* UBX_H */
