/* This file has been generated from /home/mav/Desktop/paparazzivn100/conf/radios/T9cap.xml */
/* Please DO NOT EDIT */

#ifndef RADIO_H
#define RADIO_H 

#define RADIO_NAME "T9cap"

#define RADIO_CTL_NB 8

#define RADIO_CTL_right_stick_horiz 0
#define RADIO_ROLL RADIO_CTL_right_stick_horiz
#define RADIO_CTL_right_stick_vert 1
#define RADIO_PITCH RADIO_CTL_right_stick_vert
#define RADIO_CTL_left_stick_vert 2
#define RADIO_THROTTLE RADIO_CTL_left_stick_vert
#define RADIO_CTL_left_stick_horiz 3
#define RADIO_YAW RADIO_CTL_left_stick_horiz
#define RADIO_CTL_switch_G 4
#define RADIO_CALIB RADIO_CTL_switch_G
#define RADIO_CTL_VRB 5
#define RADIO_CAM_PITCH RADIO_CTL_VRB
#define RADIO_CTL_VRC 6
#define RADIO_GAIN2 RADIO_CTL_VRC
#define RADIO_CTL_switch_C 7
#define RADIO_MODE RADIO_CTL_switch_C

#define PPM_DATA_MIN_LEN (900ul)
#define PPM_DATA_MAX_LEN (2100ul)
#define PPM_SYNC_MIN_LEN (5000ul)
#define PPM_SYNC_MAX_LEN (15000ul)

#define NormalizePpm() {\
  static uint8_t avg_cpt = 0; /* Counter for averaging */\
  int16_t tmp_radio;\
  tmp_radio = ppm_pulses[RADIO_ROLL] - SYS_TICS_OF_USEC(1525);\
  rc_values[RADIO_ROLL] = tmp_radio * (tmp_radio >=0 ? (MAX_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(1114-1525))) : (MIN_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(1939-1525))));\
  Bound(rc_values[RADIO_ROLL], MIN_PPRZ, MAX_PPRZ); \
\
  tmp_radio = ppm_pulses[RADIO_PITCH] - SYS_TICS_OF_USEC(1518);\
  rc_values[RADIO_PITCH] = tmp_radio * (tmp_radio >=0 ? (MAX_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(1937-1518))) : (MIN_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(1112-1518))));\
  Bound(rc_values[RADIO_PITCH], MIN_PPRZ, MAX_PPRZ); \
\
  tmp_radio = ppm_pulses[RADIO_THROTTLE] - SYS_TICS_OF_USEC(1940);\
  rc_values[RADIO_THROTTLE] = tmp_radio * (MAX_PPRZ / (float)(SIGNED_SYS_TICS_OF_USEC(1115-1940)));\
  Bound(rc_values[RADIO_THROTTLE], 0, MAX_PPRZ); \
\
  tmp_radio = ppm_pulses[RADIO_YAW] - SYS_TICS_OF_USEC(1498);\
  rc_values[RADIO_YAW] = tmp_radio * (tmp_radio >=0 ? (MAX_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(1115-1498))) : (MIN_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(1940-1498))));\
  Bound(rc_values[RADIO_YAW], MIN_PPRZ, MAX_PPRZ); \
\
  avg_rc_values[RADIO_CALIB] += ppm_pulses[RADIO_CALIB];\
  tmp_radio = ppm_pulses[RADIO_CAM_PITCH] - SYS_TICS_OF_USEC(1498);\
  rc_values[RADIO_CAM_PITCH] = tmp_radio * (tmp_radio >=0 ? (MAX_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(1115-1498))) : (MIN_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(1940-1498))));\
  Bound(rc_values[RADIO_CAM_PITCH], MIN_PPRZ, MAX_PPRZ); \
\
  avg_rc_values[RADIO_GAIN2] += ppm_pulses[RADIO_GAIN2];\
  avg_rc_values[RADIO_MODE] += ppm_pulses[RADIO_MODE];\
  avg_cpt++;\
  if (avg_cpt == RC_AVG_PERIOD) {\
    avg_cpt = 0;\
    tmp_radio = avg_rc_values[RADIO_CALIB] / RC_AVG_PERIOD -  SYS_TICS_OF_USEC(1525);\
    rc_values[RADIO_CALIB] = tmp_radio * (tmp_radio >=0 ? (MAX_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(969-1525))) : (MIN_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(2080-1525))));\
    avg_rc_values[RADIO_CALIB] = 0;\
    Bound(rc_values[RADIO_CALIB], MIN_PPRZ, MAX_PPRZ); \
\
    tmp_radio = avg_rc_values[RADIO_GAIN2] / RC_AVG_PERIOD -  SYS_TICS_OF_USEC(1518);\
    rc_values[RADIO_GAIN2] = tmp_radio * (tmp_radio >=0 ? (MAX_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(2077-1518))) : (MIN_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(970-1518))));\
    avg_rc_values[RADIO_GAIN2] = 0;\
    Bound(rc_values[RADIO_GAIN2], MIN_PPRZ, MAX_PPRZ); \
\
    tmp_radio = avg_rc_values[RADIO_MODE] / RC_AVG_PERIOD -  SYS_TICS_OF_USEC(1526);\
    rc_values[RADIO_MODE] = tmp_radio * (tmp_radio >=0 ? (MAX_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(966-1526))) : (MIN_PPRZ/(float)(SIGNED_SYS_TICS_OF_USEC(2079-1526))));\
    avg_rc_values[RADIO_MODE] = 0;\
    Bound(rc_values[RADIO_MODE], MIN_PPRZ, MAX_PPRZ); \
\
    rc_values_contains_avg_channels = TRUE;\
 }\
}

#endif // RADIO_H
