/*
 * $Id: point.c,v 1.1 2006/10/27 13:40:24 mmm Exp $
 *  
 * Copyright (C) 2005  Arnold Schroeter
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
 
/** \file point.c 
 *  \brief Determines camera turn and tilt angles.
 *
 * project:        Depronazzi MAV
 * description:    Determines camera turn and tilt angles from 
 *                 plane's and object's positions and plane's
 *                 pitch and roll angles. Software might be optimized
 *                 by removing multiplications with 0, it is left this
 *                 way for better understandabilty and changeability.
 *
 * author:         Arnold Schroeter
 *
 * hardware:
 *
 * The camera control is made of normal servos. Usually servos have a
 * turn angle of about 90�. This is changed electrically so that they
 * can do a 180�. It is achieved by adding two serial resistors at both
 * sides of the potentiometer (P1), one for increasing the usable angle
 * (R1) and the other for moving the middle position to a useful angle
 * (R2). Therefore a servo with a 270� potentiometer is needed. Very
 * small and light servos have 180� potentiometers, these do not allow
 * a 180� degrees sweep. Cut the outer two connections between the
 * potentiometer and the board to insert the resistors. The values for
 * R1 and R2 should be found out by testing as there might be serial
 * resistors on the servo board that affect the values. Start with
 * about 1/2 the value of P1 for R1 and change R1 until you get a
 * little more than 180� sweep. Then insert and modify R2 to set
 * neutral back to the middle position of the potentiometer.
 *
 *
 *                     ^
 *                    /
 *              ----------
 *      *-------I   /    I-------*
 *      I       ----------       I
 *      I         /     P1       I
 *      I         I              I
 *      I         I              I
 *     ---        I             ---
 *     I I        I             I I
 *     I I        I             I I
 *     I I        I             I I
 *     --- R1     I             --- R2
 *      I         I              I
 *      I         I              I
 *
 *
 * The Paparazzi software makes planes circle clockwise so the default
 * view is to the right side of the plane. The pan servo neutral makes
 * the camera look to the right with 0� given, 90� is to the back and
 * -90� is to the front. The tilt servo neutral makes the camera look
 * down with 0� given, 90� is to the right and -90� is to the left (all
 * values are used in radian in the software). If the camera looks to
 * the right side of the plane, the picture is upright. It is upside
 * down when looking to the left. That is corrected with the MPEG
 * decoding software on the laptop by mirroring. The pan servo is fixed
 * in the plane and the tilt servo is moved by the pan servo and moves
 * the camera.
 *
 *
 * pan servo, tilt set to 90�, looking from top:
 *     
 *   plane front
 *     
 *       ^
 *       I
 *       I  45�
 *       I /
 *       I/
 *       I------- 0�
 *       I\
 *       I \
 *       I  -45�
 *       I
 *     
 *   plane back
 *     
 *     
 * tilt servo, pan set to 0�, looking from back:
 *     
 *     plane left --------------- plane right
 *                     / I \
 *                    /  I  \
 *                 -45�  I   45�
 *                       0�
 */
  
#include <math.h>
#include "point.h"

typedef struct {
         float fx;
         float fy;
         float fz;} VECTOR;
 
typedef struct {
         float fx1; float fx2; float fx3;
         float fy1; float fy2; float fy3;
         float fz1; float fz2; float fz3;} MATRIX;

void vSubtractVectors(VECTOR* svA, VECTOR svB, VECTOR svC);
void vMultiplyMatrixByVector(VECTOR* svA, MATRIX smB, VECTOR svC);

/*******************************************************************
; function name:   vSubtractVectors
; description:     subtracts two vectors a = b - c
; parameters:           
;*******************************************************************/
void vSubtractVectors(VECTOR* svA, VECTOR svB, VECTOR svC)
{
  svA->fx = svB.fx - svC.fx;
  svA->fy = svB.fy - svC.fy;
  svA->fz = svB.fz - svC.fz;
}

/*******************************************************************
; function name:   vMultiplyMatrixByVector
; description:     multiplies matrix by vector svA = smB * svC
; parameters:           
;*******************************************************************/
void vMultiplyMatrixByVector(VECTOR* svA, MATRIX smB, VECTOR svC)
{
  svA->fx = smB.fx1 * svC.fx  +  smB.fx2 * svC.fy  +  smB.fx3 * svC.fz;
  svA->fy = smB.fy1 * svC.fx  +  smB.fy2 * svC.fy  +  smB.fy3 * svC.fz;
  svA->fz = smB.fz1 * svC.fx  +  smB.fz2 * svC.fy  +  smB.fz3 * svC.fz;
}

/*******************************************************************
; function name:   vPoint
; description:     Transforms ground coordinate system into
;                  plane's coordinate system via three rotations
;                  and determines positions of camera servos. 
; parameters:      fPlaneNorth, fPlaneEast, fPlaneAltitude  plane's 
;                           position with respect to ground
;                           in m (actually the units do not matter as 
;                           long as they are the same as for the object's
;                           position)
;                  fTurnAngle  north=0; right= positive values in radians
;                  fPitchAngle level=0; nose up = positive values
;                  fRollAngle  level=0; right wing down = positive values
;                           plane's pitch and roll angles
;                           with respect to ground in radians
;                  fObjectNorth, fObjectEast, fAltitude object's 
;                           position with respect to ground
;                           in m (actually the units do not matter as 
;                           long as they are the same for the plane's
;                           position)
;                  turn, tilt turn and tilt angles for camera servos
;                           in radians
;*******************************************************************/
void vPoint(float fPlaneEast, float fPlaneNorth, float fPlaneAltitude,
            float fTurnAngle, float fPitchAngle, float fRollAngle,
            float fObjectEast, float fObjectNorth, float fAltitude,
            float *fTurn, float *fTilt)
{
  static VECTOR svPlanePosition, 
                svObjectPosition, 
                svObjectPositionForPlane, 
                svObjectPositionForPlane2;

  static MATRIX smRotation;

  svPlanePosition.fx = fPlaneNorth;
  svPlanePosition.fy = fPlaneEast;
  svPlanePosition.fz = fPlaneAltitude;

  svObjectPosition.fx = fObjectNorth;
  svObjectPosition.fy = fObjectEast;
  svObjectPosition.fz = fAltitude;

  /* distance between plane and object */
  vSubtractVectors(&svObjectPositionForPlane, svObjectPosition, svPlanePosition);

  /* turn */
  smRotation.fx1 = (float)(cos(fTurnAngle));
  smRotation.fx2 = (float)(sin(fTurnAngle));
  smRotation.fx3 = 0.;
  smRotation.fy1 = -smRotation.fx2;
  smRotation.fy2 = smRotation.fx1;
  smRotation.fy3 = 0.;
  smRotation.fz1 = 0.;
  smRotation.fz2 = 0.;
  smRotation.fz3 = 1.;

  vMultiplyMatrixByVector(&svObjectPositionForPlane2, smRotation, svObjectPositionForPlane);

  /* pitch */
  smRotation.fx1 = (float)(cos(fPitchAngle));
  smRotation.fx2 = 0.;
  smRotation.fx3 = (float)(sin(fPitchAngle));
  smRotation.fy1 = 0.;
  smRotation.fy2 = 1.;
  smRotation.fy3 = 0.;
  smRotation.fz1 = -smRotation.fx3;
  smRotation.fz2 = 0.;
  smRotation.fz3 = smRotation.fx1;

  vMultiplyMatrixByVector(&svObjectPositionForPlane, smRotation, svObjectPositionForPlane2);

  /* roll */
  smRotation.fx1 = 1.;
  smRotation.fx2 = 0.;
  smRotation.fx3 = 0.;
  smRotation.fy1 = 0.;
  smRotation.fy2 = (float)(cos(fRollAngle));
  smRotation.fy3 = (float)(-sin(fRollAngle));
  smRotation.fz1 = 0.;
  smRotation.fz2 = -smRotation.fy3;
  smRotation.fz3 = smRotation.fy2;

  vMultiplyMatrixByVector(&svObjectPositionForPlane2, smRotation, svObjectPositionForPlane);

  /* fTurn =   0  -> camera looks along the wing
             -90  -> camera looks in flight direction
              90  -> camera looks backwards
  */
  if (svObjectPositionForPlane2.fz == 0)
  {
    if (svObjectPositionForPlane2.fy >= 0)
    {
      *fTurn = -M_PI/2.;
    }
    else
    {
      *fTurn = M_PI/2.;
    }
  }
  else
  {
    *fTurn = -(float)(atan(svObjectPositionForPlane2.fy / svObjectPositionForPlane2.fz));
  }

  /* fTilt =   0  -> camera looks down
              90  -> camera looks into right hemisphere
             -90  -> camera looks into left hemispere
     actually the camera always looks more or less downwards, but never upwards
  */
  if ((svObjectPositionForPlane2.fy == 0) && (svObjectPositionForPlane2.fz == 0))
  {
    *fTilt = M_PI/2.;
  }
  else
  {
    *fTilt = (float)(atan( svObjectPositionForPlane2.fx /
                           sqrt(   svObjectPositionForPlane2.fy * svObjectPositionForPlane2.fy
                                 + svObjectPositionForPlane2.fz * svObjectPositionForPlane2.fz )
                         ));
  }

}
