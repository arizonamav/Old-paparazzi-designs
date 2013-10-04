/*  $Id: servos_4017.h,v 1.4 2006/06/28 20:52:14 poine Exp $
 *
 * (c) 2003-2005 Pascal Brisset, Antoine Drouin
 *
 * This file is part of paparazzi.
 *
 * paparazzi is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or extern uint16_t servo_widths[_4017_NB_CHANNELS];(at your option)
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

#ifndef SERVO_4017_H
#define SERVO_4017_H

#define SERVOS_TICS_OF_USEC(_us) SYS_TICS_OF_USEC(_us)
#define ChopServo(x,a,b) Chop(x, a, b)

#define _4017_NB_CHANNELS 10
extern uint16_t servo_widths[_4017_NB_CHANNELS];
#define Actuator(i) servo_widths[i]

#define ActuatorsCommit() {}

#endif /* SERVO_4017_H */

