/* This file has been generated from /home/paparazzi/paparazzi3new/conf/flight_plans/imav09_pnav2.xml */
/* Please DO NOT EDIT */

#ifndef FLIGHT_PLAN_H
#define FLIGHT_PLAN_H 

#include "std.h"
#define FLIGHT_PLAN_NAME "Precise Navigation"
#define NAV_UTM_EAST0 558102
#define NAV_UTM_NORTH0 3395038
#define NAV_UTM_ZONE0 16
#define QFU 270.0
#define WP_dummy 0
#define WP_HOME 1
#define WP_1a 3
#define WP_2 4
#define WP_3 5
#define WP_3a 6
#define WP_4 7
#define WP_4a 8
#define WP_5 9
#define WP_6 10
#define WP_7 11
#define WP_6a 12
#define WP_6b 13
#define WP_T1 14
#define WP_T2 15
#define WP_T3 16
#define WP_NFZ7 17
#define WP_NFZ1 18
#define WP_NFZ2 19
#define WP_NFZ3 20
#define WP_NFZ4 21
#define WP_NFZ5 22
#define WP_NFZ6 23
#define WP_GCS 24
#define WAYPOINTS { \
 {42.0, 42.0, 119},\
 {-897.1, 298.3, 119},\
 {-124.5, 3.9, 119},\
 {-306.5, 64.7, 119},\
 {-258.4, 153.3, 119},\
 {-176.7, 315.9, 229.},\
 {-453.2, 409.0, 229.},\
 {-388.1, 524.3, 229.},\
 {-98.8, 723.7, 229.},\
 {49.4, 658.8, 229.},\
 {-7.8, 560.0, 229.},\
 {48.3, 529.1, 119},\
 {-281.5, 406.0, 180.},\
 {-97.2, 652.0, 140.},\
 {-17.2, 72.2, 119},\
 {-110.3, 135.6, 119},\
 {10.5, 173.9, 119},\
 {154.9, -8.7, 119},\
 {154.9, 600.0, 119},\
 {154.9, 500.0, 119},\
 {154.9, 400.0, 119},\
 {154.9, 300.0, 119},\
 {154.9, 200.0, 119},\
 {154.9, 100.0, 119},\
 {35.2, 27.7, 119},\
};
#define NB_WAYPOINT 25
#define GROUND_ALT 59.
#define SECURITY_HEIGHT 50.
#define SECURITY_ALT 109.
#define MAX_DIST_FROM_HOME 1100.
#ifdef NAV_C

static inline void auto_nav(void) {
  switch (nav_block) {
    Block(0) // init
    if ((nav_block!=4) && RcEvent1()) { GotoBlock(4) }
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
          NavVerticalAutoThrottleMode(0.100000);
          NavVerticalThrottleMode(4416);
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
          if (NavApproaching(14,1)) NextStageFrom(14) else {
            NavGotoWaypoint(14);
            NavVerticalAutoThrottleMode(0.000000);
            NavVerticalAltitudeMode(WaypointAlt(14), 0.);
            CamFix();
          }
          return;
        Stage(2)
          if (NavApproaching(15,1)) NextStageFrom(15) else {
            NavGotoWaypoint(15);
            NavVerticalAutoThrottleMode(0.000000);
            NavVerticalAltitudeMode(WaypointAlt(15), 0.);
            CamFix();
          }
          return;
        Stage(3)
          Goto(while_3)
        Label(endwhile_4)
      Stage(4)
        NextBlock()
    }

    Block(2) // 3wp loiter
    if ((nav_block!=0) && RcEvent1()) { GotoBlock(0) }
    if ((nav_block!=1) && RcEvent2()) { GotoBlock(1) }
    switch(nav_stage) {
      Label(while_5)
      Stage(0)
        if (! (TRUE)) Goto(endwhile_6) else NextStage();
        Stage(1)
          if (NavApproaching(14,1)) NextStageFrom(14) else {
            NavGotoWaypoint(14);
            NavVerticalAutoThrottleMode(0.000000);
            NavVerticalAltitudeMode(WaypointAlt(14), 0.);
            CamFix();
          }
          return;
        Stage(2)
          if (NavApproaching(15,1)) NextStageFrom(15) else {
            NavGotoWaypoint(15);
            NavVerticalAutoThrottleMode(0.000000);
            NavVerticalAltitudeMode(WaypointAlt(15), 0.);
            CamFix();
          }
          return;
        Stage(3)
          if (NavApproaching(16,1)) NextStageFrom(16) else {
            NavGotoWaypoint(16);
            NavVerticalAutoThrottleMode(0.000000);
            NavVerticalAltitudeMode(WaypointAlt(16), 0.);
            CamFix();
          }
          return;
        Stage(4)
          Goto(while_5)
        Label(endwhile_6)
      Stage(5)
        NextBlock()
    }

    Block(3) // circle
    if ((nav_block!=1) && RcEvent2()) { GotoBlock(1) }
    if ((nav_block!=4) && RcEvent1()) { GotoBlock(4) }
    switch(nav_stage) {
      Stage(0)
        NavVerticalAutoThrottleMode(0.000000);
        NavVerticalAltitudeMode((GROUND_ALT+8), 0.);
        NavCircleWaypoint(1, 10);
        CamFix();
        return;
      Stage(1)
        NextBlock()
    }

    Block(4) // landing
    if ((nav_block!=3) && RcEvent2()) { GotoBlock(3) }
    if ((nav_block!=0) && RcEvent1()) { GotoBlock(0) }
    switch(nav_stage) {
      Stage(0)
        if (NavApproaching(14,CARROT)) NextStageFrom(14) else {
          NavGotoWaypoint(14);
          NavVerticalAutoThrottleMode(0.000000);
          NavVerticalAltitudeMode((GROUND_ALT+2), 0.);
          CamFix();
        }
        return;
      Stage(1)
        if (NavApproaching(15,CARROT)) NextStageFrom(15) else {
          NavGotoWaypoint(15);
          NavVerticalAutoThrottleMode(0.000000);
          NavVerticalThrottleMode(1920);
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
