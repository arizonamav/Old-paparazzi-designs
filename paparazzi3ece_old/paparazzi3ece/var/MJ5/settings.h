/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/settings/basic.xml */
/* Please DO NOT EDIT */

#ifndef SETTINGS_H
#define SETTINGS_H 

#define RCSettings(mode_changed) { \
}
#define DlSetting(_idx, _value) { \
  switch (_idx) { \
    case 0: altitude_shift = _value; break;\
    case 1: pprz_mode = _value; break;\
    case 2: launch = _value; break;\
    case 3: kill_throttle = _value; break;\
  }\
}
#define PeriodicSendDlValue() { \
  static uint8_t i;\
  float var;\
  if (i >= 4) i = 0;;\
  switch (i) { \
    case 0: var = altitude_shift; break;\
    case 1: var = pprz_mode; break;\
    case 2: var = launch; break;\
    case 3: var = kill_throttle; break;\
    default: var = 0.; break;\
  }\
  DOWNLINK_SEND_DL_VALUE(&i, &var);\
  i++;\
}

#endif // SETTINGS_H
