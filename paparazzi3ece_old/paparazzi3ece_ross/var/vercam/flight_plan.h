/* This file has been generated from /home/mav/Desktop/paparazzi3new/conf/flight_plans/indoors.xml */
/* Please DO NOT EDIT */

#ifndef FLIGHT_PLAN_H
#define FLIGHT_PLAN_H 

#include "std.h"
#define FLIGHT_PLAN_NAME "hovering indoors"
#define NAV_UTM_EAST0 358071
#define NAV_UTM_NORTH0 4822161
#define NAV_UTM_ZONE0 31
#define QFU 180.0
#define WP_dummy 0
#define WP_HOME 1
#define WAYPOINTS { \
 {42.0, 42.0, 702.0},\
 {753.9, -51.2, 702},\
};
#define NB_WAYPOINT 2
#define GROUND_ALT 700.
#define SECURITY_HEIGHT 0.02
#define SECURITY_ALT 700.02
#define MAX_DIST_FROM_HOME 1750.
#ifdef NAV_C

static inline void auto_nav(void) {
  switch (nav_block) {
  }
}
#endif // NAV_C

#endif // FLIGHT_PLAN_H
