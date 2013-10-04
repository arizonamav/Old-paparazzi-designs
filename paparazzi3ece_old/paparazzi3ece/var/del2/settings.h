/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/settings/tuning_rc.xml */
/* Please DO NOT EDIT */

#ifndef SETTINGS_H
#define SETTINGS_H 

#define RCSettings(mode_changed) { \
  if (pprz_mode == PPRZ_MODE_AUTO1) { \
    if (rc_settings_mode == RC_SETTINGS_MODE_UP) { \
      static float ir_pitch_neutral_init; \
      static int16_t slider1_init; \
      if (mode_changed) { \
        ir_pitch_neutral_init = ir_pitch_neutral; \
        slider1_init = RcChannel(RADIO_GAIN1); \
      } \
      ir_pitch_neutral = ParamValFloat(ir_pitch_neutral_init, 2.000000, RcChannel(RADIO_GAIN1), slider1_init); \
      slider_1_val = (float)ir_pitch_neutral; \
    } \
    if (rc_settings_mode == RC_SETTINGS_MODE_DOWN) { \
      static float ir_roll_neutral_init; \
      static int16_t slider1_init; \
      if (mode_changed) { \
        ir_roll_neutral_init = ir_roll_neutral; \
        slider1_init = RcChannel(RADIO_GAIN1); \
      } \
      ir_roll_neutral = ParamValFloat(ir_roll_neutral_init, -2.000000, RcChannel(RADIO_GAIN1), slider1_init); \
      slider_1_val = (float)ir_roll_neutral; \
    } \
  } \
  if (pprz_mode == PPRZ_MODE_AUTO2) { \
    if (rc_settings_mode == RC_SETTINGS_MODE_UP) { \
      static float h_ctl_course_pgain_init; \
      static int16_t slider1_init; \
      if (mode_changed) { \
        h_ctl_course_pgain_init = h_ctl_course_pgain; \
        slider1_init = RcChannel(RADIO_GAIN1); \
      } \
      h_ctl_course_pgain = ParamValFloat(h_ctl_course_pgain_init, 0.100000, RcChannel(RADIO_GAIN1), slider1_init); \
      slider_1_val = (float)h_ctl_course_pgain; \
    } \
    if (rc_settings_mode == RC_SETTINGS_MODE_DOWN) { \
      static float h_ctl_elevator_of_roll_init; \
      static int16_t slider1_init; \
      if (mode_changed) { \
        h_ctl_elevator_of_roll_init = h_ctl_elevator_of_roll; \
        slider1_init = RcChannel(RADIO_GAIN1); \
      } \
      h_ctl_elevator_of_roll = ParamValFloat(h_ctl_elevator_of_roll_init, 0.200000, RcChannel(RADIO_GAIN1), slider1_init); \
      slider_1_val = (float)h_ctl_elevator_of_roll; \
    } \
  } \
}
#define DlSetting(_idx, _value) { \
  switch (_idx) { \
  }\
}
#define PeriodicSendDlValue() { \
}

#endif // SETTINGS_H
