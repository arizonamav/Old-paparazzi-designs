/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/flight_plans/mav08.xml */
/* Please DO NOT EDIT */

#ifndef FLIGHT_PLAN_H
#define FLIGHT_PLAN_H 

#include "std.h"
#define FLIGHT_PLAN_NAME "MAV08"
#define NAV_UTM_EAST0 788907
#define NAV_UTM_NORTH0 3000447
#define NAV_UTM_ZONE0 43
#define QFU 270.0
#define WP_dummy 0
#define WP_HOME 1
#define WP_1 2
#define WP_2 3
#define WP_NF29 9
#define WP_NF28 10
#define WP_NF27 11
#define WP_NF26 12
#define WP_NF25 13
#define WP_NF24 14
#define WP_NF23 15
#define WP_NF22 16
#define WP_NF21 17
#define WP_NF20 18
#define WP_NF19 19
#define WP_NF18 20
#define WP_NF17 21
#define WP_NF16 22
#define WP_NF15 23
#define WP_NF14 24
#define WP_NF13 25
#define WP_NF12 26
#define WP_NF11 27
#define WP_NF10 28
#define WP_NF9 29
#define WP_NF8 30
#define WP_NF7 31
#define WP_NF5 32
#define WP_NF6 33
#define WP_NF4 34
#define WP_NF3 35
#define WP_NF2 36
#define WP_NF1 37
#define WP_A1 38
#define WP_B1 39
#define WP_C2 40
#define WP_C1 41
#define WP_D2 42
#define WP_D1 43
#define WP_E2 44
#define WP_E1 45
#define WP_B2 46
#define WP_C3 47
#define WP_D3 48
#define WP_E3 49
#define WP_F1 50
#define WP_F2 51
#define WAYPOINTS { \
 {42.0, 42.0, 215},\
 {389.5, 148.2, 215},\
 {349.0, -184.8, 215},\
 {483.2, -285.7, 215},\
 {204.8, 679.4, 215},\
 {100.0, 300.0, 215},\
 {333.6, -358.9, 215},\
 {366.6, -351.9, 215},\
 {322.8, -368.4, 215},\
 {496.0, 486.0, 215},\
 {616.9, 384.0, 215},\
 {819.8, 197.7, 215},\
 {906.5, 27.1, 215},\
 {869.4, -158.5, 215},\
 {755.0, -339.8, 215},\
 {629.6, -518.4, 215},\
 {506.8, -453.5, 215},\
 {241.9, -324.0, 215},\
 {71.8, -244.8, 215},\
 {-145.1, -49.6, 215},\
 {-76.3, 81.4, 215},\
 {13.2, 262.2, 215},\
 {100.0, 442.8, 215},\
 {280.3, 634.9, 215},\
 {276.8, 665.6, 215},\
 {259.8, 680.7, 215},\
 {243.1, 692.6, 215},\
 {234.7, 695.5, 215},\
 {198.8, 697.8, 215},\
 {179.6, 694.2, 215},\
 {174.3, 684.9, 215},\
 {180.1, 672.7, 215},\
 {165.5, 589.2, 215},\
 {144.5, 542.5, 215},\
 {183.5, 648.1, 215},\
 {186.6, 629.7, 215},\
 {364.7, 559.9, 215},\
 {292.0, 604.4, 215},\
 {267.7, -249.5, 215},\
 {108.7, -170.0, 215},\
 {162.4, 13.0, 215},\
 {-0.0, -0.0, 215},\
 {169.4, 185.7, 215},\
 {59.0, 189.2, 215},\
 {178.8, 373.8, 215},\
 {120.7, 381.0, 215},\
 {298.1, -131.7, 215},\
 {317.9, -35.8, 215},\
 {294.0, 160.9, 215},\
 {261.8, 360.3, 215},\
 {182.6, 564.9, 215},\
 {229.7, 553.6, 215},\
};
#define NB_WAYPOINT 52
#define GROUND_ALT 164.
#define SECURITY_HEIGHT 0.2
#define SECURITY_ALT 164.2
#define MAX_DIST_FROM_HOME 750.
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
        NavCircleWaypoint(1, 50);
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
          NavVerticalAltitudeMode((GROUND_ALT+2), 0.);
          CamFix();
        }
        return;
      Stage(1)
        if (NavApproaching(3,CARROT)) NextStageFrom(3) else {
          NavGotoWaypoint(3);
          NavVerticalAutoThrottleMode(0.000000);
          NavVerticalThrottleMode(960);
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
