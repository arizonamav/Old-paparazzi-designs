/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/messages.xml and /home/dragonfly/paparazzi_new/test/paparazzi3/conf/telemetry/default.xml */
/* Please DO NOT EDIT */

/* Periodic messages are sent over 100 timeframes */

/* Macros for Ap process */
#define TELEMETRY_MODE_Ap_default 0
#define TELEMETRY_MODE_Ap_debug 1
#define PeriodicSendAp() {  /* 10Hz */ \
  if (telemetry_mode_Ap == TELEMETRY_MODE_Ap_default) {\
    static uint8_t i5; i5++; if (i5>=5) i5=0;\
    static uint8_t i10; i10++; if (i10>=10) i10=0;\
    static uint8_t i20; i20++; if (i20>=20) i20=0;\
    static uint8_t i50; i50++; if (i50>=50) i50=0;\
    static uint8_t i90; i90++; if (i90>=90) i90=0;\
    if (i5 == 0) {\
      PERIODIC_SEND_ATTITUDE();\
    }\
    if (i5 == 1) {\
      PERIODIC_SEND_ADC();\
    }\
    if (i5 == 2) {\
      PERIODIC_SEND_SETTINGS();\
    }\
    if (i5 == 3) {\
      PERIODIC_SEND_IMU();\
    }\
    if (i5 == 4) {\
      PERIODIC_SEND_WP_MOVED();\
    }\
    if (i10 == 5) {\
      PERIODIC_SEND_CALIB_START();\
    }\
    if (i10 == 6) {\
      PERIODIC_SEND_CALIB_CONTRAST();\
    }\
    if (i10 == 7) {\
      PERIODIC_SEND_DESIRED();\
    }\
    if (i10 == 8) {\
      PERIODIC_SEND_CIRCLE();\
    }\
    if (i10 == 9) {\
      PERIODIC_SEND_SEGMENT();\
    }\
    if (i10 == 0) {\
      PERIODIC_SEND_DL_VALUE();\
    }\
    if (i10 == 1) {\
      PERIODIC_SEND_RAD_OF_IR();\
    }\
    if (i10 == 2) {\
      PERIODIC_SEND_IR_SENSORS();\
    }\
    if (i10 == 3) {\
      PERIODIC_SEND_GYRO_RATES();\
    }\
    if (i20 == 4) {\
      PERIODIC_SEND_BAT();\
    }\
    if (i20 == 5) {\
      PERIODIC_SEND_CALIBRATION();\
    }\
    if (i20 == 6) {\
      PERIODIC_SEND_SURVEY();\
    }\
    if (i50 == 7) {\
      PERIODIC_SEND_PPRZ_MODE();\
    }\
    if (i50 == 8) {\
      PERIODIC_SEND_DEBUG_MCU_LINK();\
    }\
    if (i50 == 9) {\
      PERIODIC_SEND_DEBUG_MODEM();\
    }\
    if (i90 == 10) {\
      PERIODIC_SEND_NAVIGATION_REF();\
    }\
  }\
  if (telemetry_mode_Ap == TELEMETRY_MODE_Ap_debug) {\
    static uint8_t i5; i5++; if (i5>=5) i5=0;\
    if (i5 == 0) {\
      PERIODIC_SEND_CALIB_START();\
    }\
    if (i5 == 1) {\
      PERIODIC_SEND_ATTITUDE();\
    }\
  }\
}

/* Macros for Fbw process */
#define TELEMETRY_MODE_Fbw_default 0
#define TELEMETRY_MODE_Fbw_debug 1
#define PeriodicSendFbw() {  /* 10Hz */ \
  if (telemetry_mode_Fbw == TELEMETRY_MODE_Fbw_default) {\
    static uint8_t i10; i10++; if (i10>=10) i10=0;\
    static uint8_t i50; i50++; if (i50>=50) i50=0;\
    if (i10 == 0) {\
      PERIODIC_SEND_COMMANDS();\
    }\
    if (i10 == 1) {\
      PERIODIC_SEND_FBW_STATUS();\
    }\
    if (i50 == 2) {\
      PERIODIC_SEND_ACTUATORS();\
    }\
  }\
  if (telemetry_mode_Fbw == TELEMETRY_MODE_Fbw_debug) {\
    static uint8_t i5; i5++; if (i5>=5) i5=0;\
    static uint8_t i10; i10++; if (i10>=10) i10=0;\
    static uint8_t i50; i50++; if (i50>=50) i50=0;\
    if (i5 == 0) {\
      PERIODIC_SEND_PPM();\
    }\
    if (i5 == 1) {\
      PERIODIC_SEND_RC();\
    }\
    if (i5 == 2) {\
      PERIODIC_SEND_COMMANDS();\
    }\
    if (i10 == 3) {\
      PERIODIC_SEND_FBW_STATUS();\
    }\
    if (i50 == 4) {\
      PERIODIC_SEND_ACTUATORS();\
    }\
  }\
}
