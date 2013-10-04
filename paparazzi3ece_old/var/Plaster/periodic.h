/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/messages.xml and /home/dragonfly/paparazzi_new/test/paparazzi3/conf/telemetry/default.xml */
/* Please DO NOT EDIT */


/* Macros for Ap process */
#define TELEMETRY_MODE_Ap_default 0
#define TELEMETRY_MODE_Ap_debug 1
#define PeriodicSendAp() {  /* 60Hz */ \
  if (telemetry_mode_Ap == TELEMETRY_MODE_Ap_default) {\
    static uint8_t i30; i30++; if (i30>=30) i30=0;\
    static uint8_t i60; i60++; if (i60>=60) i60=0;\
    static uint8_t i120; i120++; if (i120>=120) i120=0;\
    static uint16_t i300; i300++; if (i300>=300) i300=0;\
    static uint16_t i540; i540++; if (i540>=540) i540=0;\
    if (i30 == 0) {\
      PERIODIC_SEND_ATTITUDE();\
    } \
    else if (i30 == 6) {\
      PERIODIC_SEND_GYRO_RATES();\
    } \
    else if (i30 == 12) {\
      PERIODIC_SEND_ESTIMATOR();\
    } \
    if (i60 == 18) {\
      PERIODIC_SEND_CALIB_START();\
    } \
    else if (i60 == 24) {\
      PERIODIC_SEND_SETTINGS();\
    } \
    else if (i60 == 30) {\
      PERIODIC_SEND_DL_VALUE();\
    } \
    else if (i60 == 36) {\
      PERIODIC_SEND_WP_MOVED();\
    } \
    else if (i60 == 42) {\
      PERIODIC_SEND_IR_SENSORS();\
    } \
    if (i120 == 48) {\
      PERIODIC_SEND_BAT();\
    } \
    else if (i120 == 54) {\
      PERIODIC_SEND_CALIBRATION();\
    } \
    else if (i120 == 60) {\
      PERIODIC_SEND_DESIRED();\
    } \
    else if (i120 == 66) {\
      PERIODIC_SEND_CIRCLE();\
    } \
    else if (i120 == 72) {\
      PERIODIC_SEND_SEGMENT();\
    } \
    else if (i120 == 78) {\
      PERIODIC_SEND_SURVEY();\
    } \
    if (i300 == 84) {\
      PERIODIC_SEND_CALIB_CONTRAST();\
    } \
    else if (i300 == 90) {\
      PERIODIC_SEND_ADC();\
    } \
    else if (i300 == 96) {\
      PERIODIC_SEND_PPRZ_MODE();\
    } \
    else if (i300 == 102) {\
      PERIODIC_SEND_DEBUG_MCU_LINK();\
    } \
    if (i540 == 108) {\
      PERIODIC_SEND_NAVIGATION_REF();\
    } \
  }\
  if (telemetry_mode_Ap == TELEMETRY_MODE_Ap_debug) {\
    static uint8_t i30; i30++; if (i30>=30) i30=0;\
    if (i30 == 0) {\
      PERIODIC_SEND_CALIB_START();\
    } \
    else if (i30 == 6) {\
      PERIODIC_SEND_ATTITUDE();\
    } \
  }\
}

/* Macros for Fbw process */
#define TELEMETRY_MODE_Fbw_default 0
#define TELEMETRY_MODE_Fbw_debug 1
#define PeriodicSendFbw() {  /* 60Hz */ \
  if (telemetry_mode_Fbw == TELEMETRY_MODE_Fbw_default) {\
    static uint8_t i60; i60++; if (i60>=60) i60=0;\
    static uint16_t i300; i300++; if (i300>=300) i300=0;\
    if (i60 == 0) {\
      PERIODIC_SEND_COMMANDS();\
    } \
    else if (i60 == 6) {\
      PERIODIC_SEND_FBW_STATUS();\
    } \
    if (i300 == 12) {\
      PERIODIC_SEND_ACTUATORS();\
    } \
  }\
  if (telemetry_mode_Fbw == TELEMETRY_MODE_Fbw_debug) {\
    static uint8_t i30; i30++; if (i30>=30) i30=0;\
    static uint8_t i60; i60++; if (i60>=60) i60=0;\
    static uint16_t i300; i300++; if (i300>=300) i300=0;\
    if (i30 == 0) {\
      PERIODIC_SEND_PPM();\
    } \
    else if (i30 == 6) {\
      PERIODIC_SEND_RC();\
    } \
    else if (i30 == 12) {\
      PERIODIC_SEND_COMMANDS();\
    } \
    if (i60 == 18) {\
      PERIODIC_SEND_FBW_STATUS();\
    } \
    if (i300 == 24) {\
      PERIODIC_SEND_ACTUATORS();\
    } \
  }\
}
