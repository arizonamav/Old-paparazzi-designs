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
#ifdef NAV_C

static inline void auto_nav(void) {
  switch (nav_block) {
    Block(0) // survey road 1
    switch(nav_stage) {
      Stage(0)
        if (NavApproaching(2,CARROT)) NextStageFrom(2) else {
          NavGotoWaypoint(2);
          NavVerticalAutoThrottleMode(0.000000);
          NavVerticalAltitudeMode(WaypointAlt(2), 0.);
          CamFix();
        }
        return;
      Stage(1)
        if (NavApproaching(3,CARROT)) NextStageFrom(3) else {
          NavGotoWaypoint(3);
          NavVerticalAutoThrottleMode(0.000000);
          NavVerticalAltitudeMode(WaypointAlt(3), 0.);
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
          if (NavApproaching(2,CARROT)) NextStageFrom(2) else {
            NavSegment(3, 2);
            NavVerticalAutoThrottleMode(0.000000);
            NavVerticalAltitudeMode(WaypointAlt(2), 0.);
            CamFix();
          }
          return;
        Stage(2)
          if (NavApproaching(3,CARROT)) NextStageFrom(3) else {
            NavSegment(2, 3);
            NavVerticalAutoThrottleMode(0.000000);
            NavVerticalAltitudeMode(WaypointAlt(3), 0.);
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
        NavVerticalAutoThrottleMode(0.000000);
        NavVerticalAltitudeMode((ground_alt+50), 0.);
        NavCircleWaypoint(3, 75);
        CamFix();
        return;
      Stage(1)
        NextBlock()
    }

    Block(3) // go too far
    switch(nav_stage) {
      Stage(0)
        if (NavApproaching(4,CARROT)) NextStageFrom(4) else {
          NavGotoWaypoint(4);
          NavVerticalAutoThrottleMode(0.000000);
          NavVerticalAltitudeMode(WaypointAlt(4), 0.);
          CamFix();
        }
        return;
      Stage(1)
        NavVerticalAutoThrottleMode(0.000000);
        NavVerticalAltitudeMode(WaypointAlt(4), 0.);
        NavCircleWaypoint(4, 50);
        CamFix();
        return;
      Stage(2)
        NextBlock()
    }

  }
}
#endif // NAV_C

#endif // FLIGHT_PLAN_H
