/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/flight_plans/muret_demo_1.xml */
/* Please DO NOT EDIT */

#ifndef FLIGHT_PLAN_H
#define FLIGHT_PLAN_H 

#include "std.h"
#define FLIGHT_PLAN_NAME "demo 1"
#define NAV_UTM_EAST0 360285
#define NAV_UTM_NORTH0 4813595
#define NAV_UTM_ZONE0 31
#define QFU 270.0
#define WP_dummy 0
#define WP_HOME 1
#define WP_road_start 2
#define WP_road_end 3
#define WAYPOINTS { \
 {42.0, 42.0, 250},\
 {0.0, 30.0, 250.},\
 {-337.0, 17.0, 250.},\
 {238.0, -30.0, 250.},\
 {529.0, -23.0, 250.},\
};
#define NB_WAYPOINT 5
#define GROUND_ALT 185.
#define SECURITY_HEIGHT 25.
#define SECURITY_ALT 210.
#define MAX_DIST_FROM_HOME 400.
static inline bool_t InsideAirexpo(float _x, float _y) { \
  if (_y <= -1289.1) {
    if (_y <= -1624.8) {
      if (_y <= -1650.6) {
        return FALSE;
      } else {
        float dy = _y - -1624.8;
        return (-952.2+dy*-0.8 <= _x && _x <= -567.2+dy*14.179372);
      }
    } else {
      if (_y <= -1449.0) {
        float dy = _y - -1449.0;
        return (-1090.3+dy*-0.8 <= _x && _x <= -474.5+dy*0.527198);
      } else {
        float dy = _y - -1289.1;
        return (-1215.9+dy*-0.8 <= _x && _x <= -617.0+dy*-0.891444);
      }
    }
  } else {
    if (_y <= -1120.7) {
      if (_y <= -1124.2) {
        float dy = _y - -1124.2;
        return (-1131.5+dy*0.5 <= _x && _x <= -764.0+dy*-0.891444);
      } else {
        float dy = _y - -1120.7;
        return (-767.1+dy*103.9 <= _x && _x <= -767.1+dy*-0.891444);
      }
    } else {
      return FALSE;
    }
  }
}
static inline bool_t InsideSurvey(float _x, float _y) { \
  if (_y <= -1304.4) {
    if (_y <= -1406.4) {
      if (_y <= -1481.4) {
        return FALSE;
      } else {
        float dy = _y - -1406.4;
        return (-877.1+dy*-1.9 <= _x && _x <= -694.6+dy*0.560423);
      }
    } else {
      float dy = _y - -1304.4;
      return (-1068.1+dy*-1.9 <= _x && _x <= -893.3+dy*-1.948115);
    }
  } else {
    if (_y <= -1235.5) {
      float dy = _y - -1235.5;
      return (-1027.6+dy*0.6 <= _x && _x <= -1027.6+dy*-1.948115);
    } else {
      return FALSE;
    }
  }
}
static inline bool_t InsideLatrape(float _x, float _y) { \
  if (_y <= -24783.9) {
    if (_y <= -25584.9) {
      if (_y <= -25593.9) {
        return FALSE;
      } else {
        float dy = _y - -25584.9;
        return (1625.0+dy*-0.0 <= _x && _x <= 4511.2+dy*319.661896);
      }
    } else {
      float dy = _y - -24783.9;
      return (1613.0+dy*-0.0 <= _x && _x <= 4424.1+dy*-0.108670);
    }
  } else {
    if (_y <= -24597.9) {
      float dy = _y - -24597.9;
      return (1610.2+dy*-0.0 <= _x && _x <= 1610.2+dy*-15.129903);
    } else {
      return FALSE;
    }
  }
}
#ifdef NAV_C

static inline void auto_nav(void) {
  switch (nav_block) {
    Block(0) // survey road 1
    switch(nav_stage) {
      Stage(0)
        if (approaching(2,CARROT)) NextStageFrom(2) else {
          fly_to(2);
          nav_pitch = 0.000000;
          v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
          vertical_mode = VERTICAL_MODE_AUTO_ALT;
          nav_altitude = waypoints[2].a;
          v_ctl_altitude_pre_climb = 0.;
          CamFix();
        }
        return;
      Stage(1)
        if (approaching(3,CARROT)) NextStageFrom(3) else {
          fly_to(3);
          nav_pitch = 0.000000;
          v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
          vertical_mode = VERTICAL_MODE_AUTO_ALT;
          nav_altitude = waypoints[3].a;
          v_ctl_altitude_pre_climb = 0.;
          CamFix();
        }
        return;
      Stage(2)
        NextBlock()
    }

    Block(1) // survey road 2
    switch(nav_stage) {
      Label(while_1)
      Stage(0)
        if (! (TRUE)) Goto(endwhile_2) else NextStage();
        Stage(1)
          if (approaching(2,CARROT)) NextStageFrom(2) else {
            route_to(3, 2);
            nav_pitch = 0.000000;
            v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
            vertical_mode = VERTICAL_MODE_AUTO_ALT;
            nav_altitude = waypoints[2].a;
            v_ctl_altitude_pre_climb = 0.;
            CamFix();
          }
          return;
        Stage(2)
          if (approaching(3,CARROT)) NextStageFrom(3) else {
            route_to(2, 3);
            nav_pitch = 0.000000;
            v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
            vertical_mode = VERTICAL_MODE_AUTO_ALT;
            nav_altitude = waypoints[3].a;
            v_ctl_altitude_pre_climb = 0.;
            CamFix();
          }
          return;
        Stage(3)
          Goto(while_1)
        Label(endwhile_2)
      Stage(4)
        NextBlock()
    }

    Block(2) // circle
    switch(nav_stage) {
      Stage(0)
        nav_pitch = 0.000000;
        v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
        vertical_mode = VERTICAL_MODE_AUTO_ALT;
        nav_altitude = (ground_alt+50);
        v_ctl_altitude_pre_climb = 0.;
        Circle(3, 75);
        CamFix();
        return;
      Stage(1)
        NextBlock()
    }

    Block(3) // go too far
    switch(nav_stage) {
      Stage(0)
        if (approaching(4,CARROT)) NextStageFrom(4) else {
          fly_to(4);
          nav_pitch = 0.000000;
          v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
          vertical_mode = VERTICAL_MODE_AUTO_ALT;
          nav_altitude = waypoints[4].a;
          v_ctl_altitude_pre_climb = 0.;
          CamFix();
        }
        return;
      Stage(1)
        nav_pitch = 0.000000;
        v_ctl_climb_mode = V_CTL_CLIMB_MODE_AUTO_THROTTLE;
        vertical_mode = VERTICAL_MODE_AUTO_ALT;
        nav_altitude = waypoints[4].a;
        v_ctl_altitude_pre_climb = 0.;
        Circle(4, 50);
        CamFix();
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
