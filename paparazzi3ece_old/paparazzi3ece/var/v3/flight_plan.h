/* This file has been generated from /home/paparazzi/paparazzi3new/conf/flight_plans/maxwell_vertigo.xml */
/* Please DO NOT EDIT */

#ifndef FLIGHT_PLAN_H
#define FLIGHT_PLAN_H 

#include "std.h"
#define FLIGHT_PLAN_NAME "maxwell for vertigo"
#define NAV_UTM_EAST0 497575
#define NAV_UTM_NORTH0 3565498
#define NAV_UTM_ZONE0 12
#define QFU 180.0
#define WP_dummy 0
#define WP_HOME 1
#define WP_1 2
#define WP_2 3
#define WAYPOINTS { \
 {42.0, 42.0, 770},\
 {11.7, 1.9, 770},\
 {47.7, 0.4, 770},\
 {-28.6, -2.4, 770},\
};
#define NB_WAYPOINT 4
#define GROUND_ALT 758.
#define SECURITY_HEIGHT 3.
#define SECURITY_ALT 761.
#define MAX_DIST_FROM_HOME 500.
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
          NavVerticalAutoThrottleMode(0.300000);
          NavVerticalThrottleMode(9600);
          CamFix();
        }
        return;
      Stage(3)
        GotoBlock(1)
      Stage(4)
        NextBlock()
    }

    Block(1) // 2wp loiter
    if ((nav_block!=0) && RcEvent1()) { GotoBlock(0) }
    if ((nav_block!=2) && RcEvent2()) { GotoBlock(2) }
    switch(nav_stage) {
      Label(while_3)
      Stage(0)
        if (! (TRUE)) Goto(endwhile_4) else NextStage();
        Stage(1)
          if (NavApproaching(2,1)) NextStageFrom(2) else {
            NavGotoWaypoint(2);
            NavVerticalAutoThrottleMode(0.000000);
            NavVerticalAltitudeMode(WaypointAlt(2), 0.);
            CamFix();
          }
          return;
        Stage(2)
          if (NavApproaching(3,1)) NextStageFrom(3) else {
            NavGotoWaypoint(3);
            NavVerticalAutoThrottleMode(0.000000);
            NavVerticalAltitudeMode(WaypointAlt(3), 0.);
            CamFix();
          }
          return;
        Stage(3)
          Goto(while_3)
        Label(endwhile_4)
      Stage(4)
        NextBlock()
    }

    Block(2) // circle
    if ((nav_block!=1) && RcEvent2()) { GotoBlock(1) }
    if ((nav_block!=3) && RcEvent1()) { GotoBlock(3) }
    switch(nav_stage) {
      Stage(0)
        NavVerticalAutoThrottleMode(0.000000);
        NavVerticalAltitudeMode(WaypointAlt(1), 0.);
        NavCircleWaypoint(1, 40);
        CamFix();
        return;
      Stage(1)
        NextBlock()
    }

    Block(3) // landing
    if ((nav_block!=2) && RcEvent2()) { GotoBlock(2) }
    if ((nav_block!=0) && RcEvent1()) { GotoBlock(0) }
    switch(nav_stage) {
      Stage(0)
        if (NavApproaching(2,CARROT)) NextStageFrom(2) else {
          NavGotoWaypoint(2);
          NavVerticalAutoThrottleMode(0.000000);
          NavVerticalAltitudeMode((GROUND_ALT+8), 0.);
          CamFix();
        }
        return;
      Stage(1)
        if (NavApproaching(3,CARROT)) NextStageFrom(3) else {
          NavGotoWaypoint(3);
          NavVerticalAutoThrottleMode(0.000000);
          NavVerticalThrottleMode(2880);
          CamFix();
        }
        return;
      Stage(2)
        NextBlock()
    }

  }
}
#endif // NAV_C

#endif // FLIGHT_PLAN_H
