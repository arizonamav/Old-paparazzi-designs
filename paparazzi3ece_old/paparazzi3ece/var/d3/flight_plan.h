/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/flight_plans/ame.xml */
/* Please DO NOT EDIT */

#ifndef FLIGHT_PLAN_H
#define FLIGHT_PLAN_H 

#include "std.h"
#define FLIGHT_PLAN_NAME "ame"
#define NAV_UTM_EAST0 504527
#define NAV_UTM_NORTH0 3566654
#define NAV_UTM_ZONE0 12
#define QFU 180.0
#define WP_dummy 0
#define WP_HOME 1
#define WAYPOINTS { \
 {42.0, 42.0, 850},\
 {-94.5, 17.3, 850.},\
};
#define NB_WAYPOINT 2
#define GROUND_ALT 750.
#define SECURITY_HEIGHT 60.
#define SECURITY_ALT 810.
#define MAX_DIST_FROM_HOME 1500.
#ifdef NAV_C

static inline void auto_nav(void) {
  switch (nav_block) {
    Block(0) // init
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
        NextBlock()
    }

  }
}
#endif // NAV_C

#endif // FLIGHT_PLAN_H
