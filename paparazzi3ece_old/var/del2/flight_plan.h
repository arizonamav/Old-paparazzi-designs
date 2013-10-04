/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/flight_plans/himmel_landing_new.xml */
/* Please DO NOT EDIT */

#ifndef FLIGHT_PLAN_H
#define FLIGHT_PLAN_H 

#include "std.h"
#define FLIGHT_PLAN_NAME "himmel 2"
#define NAV_UTM_EAST0 506366
#define NAV_UTM_NORTH0 3566262
#define NAV_UTM_ZONE0 12
#define QFU 180.0
#define WP_dummy 0
#define WP_HOME 1
#define WP_4 2
#define WAYPOINTS { \
 {42.0, 42.0, 850},\
 {-94.5, 17.3, 850.},\
 {92.6, 8.0, 850.},\
};
#define NB_WAYPOINT 3
#define GROUND_ALT 750.
#define SECURITY_HEIGHT 60.
#define SECURITY_ALT 810.
#define MAX_DIST_FROM_HOME 500.
static inline bool_t InsideAirexpo(float _x, float _y) { \
  if (_y <= 1246044.1) {
    if (_y <= 1245708.4) {
      if (_y <= 1245682.7) {
        return FALSE;
      } else {
        float dy = _y - 1245708.4;
        return (-147033.6+dy*-0.8 <= _x && _x <= -146648.5+dy*14.179372);
      }
    } else {
      if (_y <= 1245884.2) {
        float dy = _y - 1245884.2;
        return (-147171.7+dy*-0.8 <= _x && _x <= -146555.8+dy*0.527198);
      } else {
        float dy = _y - 1246044.1;
        return (-147297.2+dy*-0.8 <= _x && _x <= -146698.4+dy*-0.891444);
      }
    }
  } else {
    if (_y <= 1246212.5) {
      if (_y <= 1246209.0) {
        float dy = _y - 1246209.0;
        return (-147212.8+dy*0.5 <= _x && _x <= -146845.4+dy*-0.891444);
      } else {
        float dy = _y - 1246212.5;
        return (-146848.5+dy*103.9 <= _x && _x <= -146848.5+dy*-0.891444);
      }
    } else {
      return FALSE;
    }
  }
}
static inline bool_t InsideSurvey(float _x, float _y) { \
  if (_y <= 1246028.8) {
    if (_y <= 1245926.8) {
      if (_y <= 1245851.8) {
        return FALSE;
      } else {
        float dy = _y - 1245926.8;
        return (-146958.5+dy*-1.9 <= _x && _x <= -146775.9+dy*0.560423);
      }
    } else {
      float dy = _y - 1246028.8;
      return (-147149.5+dy*-1.9 <= _x && _x <= -146974.7+dy*-1.948115);
    }
  } else {
    if (_y <= 1246097.8) {
      float dy = _y - 1246097.8;
      return (-147109.0+dy*0.6 <= _x && _x <= -147109.0+dy*-1.948115);
    } else {
      return FALSE;
    }
  }
}
static inline bool_t InsideLatrape(float _x, float _y) { \
  if (_y <= 1222549.3) {
    if (_y <= 1221748.3) {
      if (_y <= 1221739.3) {
        return FALSE;
      } else {
        float dy = _y - 1221748.3;
        return (-144456.3+dy*-0.0 <= _x && _x <= -141570.2+dy*319.661896);
      }
    } else {
      float dy = _y - 1222549.3;
      return (-144468.4+dy*-0.0 <= _x && _x <= -141657.3+dy*-0.108670);
    }
  } else {
    if (_y <= 1222735.3) {
      float dy = _y - 1222735.3;
      return (-144471.2+dy*-0.0 <= _x && _x <= -144471.2+dy*-15.129903);
    } else {
      return FALSE;
    }
  }
}
#ifdef NAV_C

static inline void auto_nav(void) {
  switch (nav_block) {
    Block(0) // init
    if ((nav_block!=3) && RcEvent1()) { GotoBlock(3) }
    if ((nav_block!=1) && RcEvent2()) { GotoBlock(1) }
    switch(nav_stage) {
      Label(while_1)
      Stage(0)
        if (! (!(launch))) Goto(endwhile_2) else NextStage();
        Stage(1)
          Goto(while_1)
        Label(endwhile_2)
      Stage(2)
        if ((estimator_z>SECURITY_ALT)) NextStage() else {
          lateral_mode = LATERAL_MODE_ROLL;
          h_ctl_roll_setpoint = RadOfDeg(0.000000);
          nav_pitch = 0.300000;
          v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
          vertical_mode = VERTICAL_MODE_AUTO_GAZ;
          nav_desired_gaz = 9600.000000;
          CamFix();
        }
        return;
      Stage(3)
        GotoBlock(1)
      Stage(4)
        NextBlock()
    }

    Block(1) // one
    if ((nav_block!=0) && RcEvent1()) { GotoBlock(0) }
    if ((nav_block!=2) && RcEvent2()) { GotoBlock(2) }
    switch(nav_stage) {
      Label(while_3)
      Stage(0)
        if (! (TRUE)) Goto(endwhile_4) else NextStage();
        Stage(1)
          if (approaching(2,1)) NextStageFrom(2) else {
            fly_to(2);
            nav_pitch = 0.000000;
            v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
            vertical_mode = VERTICAL_MODE_AUTO_ALT;
            nav_altitude = (GROUND_ALT+80);
            v_ctl_altitude_pre_climb = 0.;
            CamFix();
          }
          return;
        Stage(2)
          if (approaching(1,1)) NextStageFrom(1) else {
            fly_to(1);
            nav_pitch = 0.000000;
            v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
            vertical_mode = VERTICAL_MODE_AUTO_ALT;
            nav_altitude = (GROUND_ALT+80);
            v_ctl_altitude_pre_climb = 0.;
            CamFix();
          }
          return;
        Stage(3)
          Goto(while_3)
        Label(endwhile_4)
      Stage(4)
        NextBlock()
    }

    Block(2) // two1
    if ((nav_block!=1) && RcEvent1()) { GotoBlock(1) }
    if ((nav_block!=3) && RcEvent2()) { GotoBlock(3) }
    switch(nav_stage) {
      Stage(0)
        if (approaching(2,CARROT)) NextStageFrom(2) else {
          fly_to(2);
          nav_pitch = 0.000000;
          v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
          vertical_mode = VERTICAL_MODE_AUTO_ALT;
          nav_altitude = (GROUND_ALT+80);
          v_ctl_altitude_pre_climb = 0.;
          CamFix();
        }
        return;
      Stage(1)
        if (approaching(1,CARROT)) NextStageFrom(1) else {
          fly_to(1);
          nav_pitch = 0.000000;
          v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
          vertical_mode = VERTICAL_MODE_AUTO_GAZ;
          nav_desired_gaz = 1920.000000;
          CamFix();
        }
        return;
      Stage(2)
        NextBlock()
    }

    Block(3) // two
    if ((nav_block!=2) && RcEvent2()) { GotoBlock(2) }
    if ((nav_block!=0) && RcEvent1()) { GotoBlock(0) }
    switch(nav_stage) {
      Stage(0)
        if (approaching(2,CARROT)) NextStageFrom(2) else {
          fly_to(2);
          nav_pitch = 0.000000;
          v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
          vertical_mode = VERTICAL_MODE_AUTO_ALT;
          nav_altitude = (GROUND_ALT+60);
          v_ctl_altitude_pre_climb = 0.;
          CamFix();
        }
        return;
      Stage(1)
        if (approaching(1,CARROT)) NextStageFrom(1) else {
          fly_to(1);
          nav_pitch = 0.000000;
          v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
          vertical_mode = VERTICAL_MODE_AUTO_GAZ;
          nav_desired_gaz = 1920.000000;
          CamFix();
        }
        return;
      Stage(2)
        NextBlock()
    }

  }
}
#endif // NAV_C
#define IR_SQUARE_UTMX_MIN 657530.
#define IR_SQUARE_UTMY_MAX 5261130.
#define IR_CORRECTION_MAX_INDEX 2
#define NB_HEIGHTS 24
#define HEIGHTS { /* Degrees from default alt*/\
{ { 0, /* heading=0.00 */\
0, /* heading=0.26 */\
0, /* heading=0.52 */\
0, /* heading=0.79 */\
0, /* heading=1.05 */\
0, /* heading=1.31 */\
0, /* heading=1.57 */\
0, /* heading=1.83 */\
0, /* heading=2.09 */\
0, /* heading=2.36 */\
0, /* heading=2.62 */\
0, /* heading=2.88 */\
0, /* heading=3.14 */\
0, /* heading=3.40 */\
0, /* heading=3.67 */\
0, /* heading=3.93 */\
0, /* heading=4.19 */\
0, /* heading=4.45 */\
0, /* heading=4.71 */\
0, /* heading=4.97 */\
0, /* heading=5.24 */\
0, /* heading=5.50 */\
0, /* heading=5.76 */\
0, /* heading=6.02 */\
 }, \
{ 0, /* heading=0.00 */\
0, /* heading=0.26 */\
0, /* heading=0.52 */\
0, /* heading=0.79 */\
0, /* heading=1.05 */\
0, /* heading=1.31 */\
0, /* heading=1.57 */\
0, /* heading=1.83 */\
0, /* heading=2.09 */\
0, /* heading=2.36 */\
0, /* heading=2.62 */\
0, /* heading=2.88 */\
0, /* heading=3.14 */\
0, /* heading=3.40 */\
0, /* heading=3.67 */\
0, /* heading=3.93 */\
0, /* heading=4.19 */\
0, /* heading=4.45 */\
0, /* heading=4.71 */\
0, /* heading=4.97 */\
0, /* heading=5.24 */\
0, /* heading=5.50 */\
0, /* heading=5.76 */\
0, /* heading=6.02 */\
 }, \
{ 0, /* heading=0.00 */\
0, /* heading=0.26 */\
0, /* heading=0.52 */\
0, /* heading=0.79 */\
0, /* heading=1.05 */\
0, /* heading=1.31 */\
0, /* heading=1.57 */\
0, /* heading=1.83 */\
0, /* heading=2.09 */\
0, /* heading=2.36 */\
0, /* heading=2.62 */\
0, /* heading=2.88 */\
0, /* heading=3.14 */\
0, /* heading=3.40 */\
0, /* heading=3.67 */\
0, /* heading=3.93 */\
0, /* heading=4.19 */\
0, /* heading=4.45 */\
0, /* heading=4.71 */\
0, /* heading=4.97 */\
0, /* heading=5.24 */\
0, /* heading=5.50 */\
0, /* heading=5.76 */\
0, /* heading=6.02 */\
 }, \
}, \
{ { 0, /* heading=0.00 */\
0, /* heading=0.26 */\
0, /* heading=0.52 */\
0, /* heading=0.79 */\
0, /* heading=1.05 */\
0, /* heading=1.31 */\
0, /* heading=1.57 */\
0, /* heading=1.83 */\
0, /* heading=2.09 */\
0, /* heading=2.36 */\
0, /* heading=2.62 */\
0, /* heading=2.88 */\
0, /* heading=3.14 */\
0, /* heading=3.40 */\
0, /* heading=3.67 */\
0, /* heading=3.93 */\
0, /* heading=4.19 */\
0, /* heading=4.45 */\
0, /* heading=4.71 */\
0, /* heading=4.97 */\
0, /* heading=5.24 */\
0, /* heading=5.50 */\
0, /* heading=5.76 */\
0, /* heading=6.02 */\
 }, \
{ 0, /* heading=0.00 */\
0, /* heading=0.26 */\
0, /* heading=0.52 */\
0, /* heading=0.79 */\
0, /* heading=1.05 */\
0, /* heading=1.31 */\
0, /* heading=1.57 */\
0, /* heading=1.83 */\
0, /* heading=2.09 */\
0, /* heading=2.36 */\
0, /* heading=2.62 */\
0, /* heading=2.88 */\
0, /* heading=3.14 */\
0, /* heading=3.40 */\
0, /* heading=3.67 */\
0, /* heading=3.93 */\
0, /* heading=4.19 */\
0, /* heading=4.45 */\
0, /* heading=4.71 */\
0, /* heading=4.97 */\
0, /* heading=5.24 */\
0, /* heading=5.50 */\
0, /* heading=5.76 */\
0, /* heading=6.02 */\
 }, \
{ 0, /* heading=0.00 */\
0, /* heading=0.26 */\
0, /* heading=0.52 */\
0, /* heading=0.79 */\
0, /* heading=1.05 */\
0, /* heading=1.31 */\
0, /* heading=1.57 */\
0, /* heading=1.83 */\
0, /* heading=2.09 */\
0, /* heading=2.36 */\
0, /* heading=2.62 */\
0, /* heading=2.88 */\
0, /* heading=3.14 */\
0, /* heading=3.40 */\
0, /* heading=3.67 */\
0, /* heading=3.93 */\
0, /* heading=4.19 */\
0, /* heading=4.45 */\
0, /* heading=4.71 */\
0, /* heading=4.97 */\
0, /* heading=5.24 */\
0, /* heading=5.50 */\
0, /* heading=5.76 */\
0, /* heading=6.02 */\
 }, \
}, \
{ { 0, /* heading=0.00 */\
0, /* heading=0.26 */\
0, /* heading=0.52 */\
0, /* heading=0.79 */\
0, /* heading=1.05 */\
0, /* heading=1.31 */\
0, /* heading=1.57 */\
0, /* heading=1.83 */\
0, /* heading=2.09 */\
0, /* heading=2.36 */\
0, /* heading=2.62 */\
0, /* heading=2.88 */\
0, /* heading=3.14 */\
0, /* heading=3.40 */\
0, /* heading=3.67 */\
0, /* heading=3.93 */\
0, /* heading=4.19 */\
0, /* heading=4.45 */\
0, /* heading=4.71 */\
0, /* heading=4.97 */\
0, /* heading=5.24 */\
0, /* heading=5.50 */\
0, /* heading=5.76 */\
0, /* heading=6.02 */\
 }, \
{ 0, /* heading=0.00 */\
0, /* heading=0.26 */\
0, /* heading=0.52 */\
0, /* heading=0.79 */\
0, /* heading=1.05 */\
0, /* heading=1.31 */\
0, /* heading=1.57 */\
0, /* heading=1.83 */\
0, /* heading=2.09 */\
0, /* heading=2.36 */\
0, /* heading=2.62 */\
0, /* heading=2.88 */\
0, /* heading=3.14 */\
0, /* heading=3.40 */\
0, /* heading=3.67 */\
0, /* heading=3.93 */\
0, /* heading=4.19 */\
0, /* heading=4.45 */\
0, /* heading=4.71 */\
0, /* heading=4.97 */\
0, /* heading=5.24 */\
0, /* heading=5.50 */\
0, /* heading=5.76 */\
0, /* heading=6.02 */\
 }, \
{ 0, /* heading=0.00 */\
0, /* heading=0.26 */\
0, /* heading=0.52 */\
0, /* heading=0.79 */\
0, /* heading=1.05 */\
0, /* heading=1.31 */\
0, /* heading=1.57 */\
0, /* heading=1.83 */\
0, /* heading=2.09 */\
0, /* heading=2.36 */\
0, /* heading=2.62 */\
0, /* heading=2.88 */\
0, /* heading=3.14 */\
0, /* heading=3.40 */\
0, /* heading=3.67 */\
0, /* heading=3.93 */\
0, /* heading=4.19 */\
0, /* heading=4.45 */\
0, /* heading=4.71 */\
0, /* heading=4.97 */\
0, /* heading=5.24 */\
0, /* heading=5.50 */\
0, /* heading=5.76 */\
0, /* heading=6.02 */\
 }, \
}, \
} 

#endif // FLIGHT_PLAN_H
