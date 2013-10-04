/* This file has been generated from /home/paparazzi/paparazzi3new/conf/settings/tuning_ver_range.xml */
/* Please DO NOT EDIT */

#ifndef SETTINGS_H
#define SETTINGS_H 

#define RCSettings(mode_changed) { \
}


#define DlSetting(_idx, _value) { \
  switch (_idx) { \
    case 0: flight_altitude = _value; break;\
    case 1: light_mode = _value; break;\
    case 2: wind_east = _value; break;\
    case 3: wind_north = _value; break;\
    case 4: pprz_mode = _value; break;\
    case 5: estimator_flight_time = _value; break;\
    case 6: launch = _value; break;\
    case 7: kill_throttle = _value; break;\
    case 8: gyro_roll_adc = _value; break;\
    case 9: gyro_pitch_adc = _value; break;\
    case 10: gyro_yaw_adc = _value; break;\
    case 11: range_scale = _value; break;\
    case 12: range_neutral = _value; break;\
    case 13: h_ctl_elevator_of_roll = _value; break;\
    case 14: h_ctl_roll_rate_setpoint_pgain = _value; break;\
    case 15: h_ctl_hi_throttle_roll_rate_pgain = _value; break;\
    case 16: h_ctl_lo_throttle_roll_rate_pgain = _value; break;\
    case 17: h_ctl_pitch_rate_setpoint_pgain = _value; break;\
    case 18: h_ctl_hi_throttle_pitch_rate_pgain = _value; break;\
    case 19: h_ctl_lo_throttle_pitch_rate_pgain = _value; break;\
    case 20: h_ctl_yaw_rate_setpoint_pgain = _value; break;\
    case 21: h_ctl_hi_throttle_yaw_rate_pgain = _value; break;\
    case 22: h_ctl_lo_throttle_yaw_rate_pgain = _value; break;\
    case 23: v_ctl_altitude_pgain = _value; break;\
    case 24: v_ctl_auto_throttle_cruise_throttle = _value; break;\
    case 25: v_ctl_auto_throttle_cruise_throttle_pgain = _value; break;\
    case 26: v_ctl_auto_throttle_pgain = _value; break;\
    case 27: v_ctl_auto_throttle_igain = _value; break;\
    case 28: v_ctl_auto_throttle_climb_throttle_increment = _value; break;\
    case 29: v_ctl_throttle_slew_ = _value; break;\
    case 30: climb_throttle = _value; break;\
    case 31: desc_throttle = _value; break;\
    case 32: v_ctl_auto_pitch_pgain = _value; break;\
    case 33: v_ctl_auto_pitch_igain = _value; break;\
    case 34: h_ctl_course_pgain = _value; break;\
    case 35: h_ctl_course_pre_bank_correction = _value; break;\
    case 36: nav_glide_pitch_trim = _value; break;\
  }\
}
#define PeriodicSendDlValue() { \
  static uint8_t i;\
  float var;\
  if (i >= 37) i = 0;;\
  switch (i) { \
    case 0: var = flight_altitude; break;\
    case 1: var = light_mode; break;\
    case 2: var = wind_east; break;\
    case 3: var = wind_north; break;\
    case 4: var = pprz_mode; break;\
    case 5: var = estimator_flight_time; break;\
    case 6: var = launch; break;\
    case 7: var = kill_throttle; break;\
    case 8: var = gyro_roll_adc; break;\
    case 9: var = gyro_pitch_adc; break;\
    case 10: var = gyro_yaw_adc; break;\
    case 11: var = range_scale; break;\
    case 12: var = range_neutral; break;\
    case 13: var = h_ctl_elevator_of_roll; break;\
    case 14: var = h_ctl_roll_rate_setpoint_pgain; break;\
    case 15: var = h_ctl_hi_throttle_roll_rate_pgain; break;\
    case 16: var = h_ctl_lo_throttle_roll_rate_pgain; break;\
    case 17: var = h_ctl_pitch_rate_setpoint_pgain; break;\
    case 18: var = h_ctl_hi_throttle_pitch_rate_pgain; break;\
    case 19: var = h_ctl_lo_throttle_pitch_rate_pgain; break;\
    case 20: var = h_ctl_yaw_rate_setpoint_pgain; break;\
    case 21: var = h_ctl_hi_throttle_yaw_rate_pgain; break;\
    case 22: var = h_ctl_lo_throttle_yaw_rate_pgain; break;\
    case 23: var = v_ctl_altitude_pgain; break;\
    case 24: var = v_ctl_auto_throttle_cruise_throttle; break;\
    case 25: var = v_ctl_auto_throttle_cruise_throttle_pgain; break;\
    case 26: var = v_ctl_auto_throttle_pgain; break;\
    case 27: var = v_ctl_auto_throttle_igain; break;\
    case 28: var = v_ctl_auto_throttle_climb_throttle_increment; break;\
    case 29: var = v_ctl_throttle_slew_; break;\
    case 30: var = climb_throttle; break;\
    case 31: var = desc_throttle; break;\
    case 32: var = v_ctl_auto_pitch_pgain; break;\
    case 33: var = v_ctl_auto_pitch_igain; break;\
    case 34: var = h_ctl_course_pgain; break;\
    case 35: var = h_ctl_course_pre_bank_correction; break;\
    case 36: var = nav_glide_pitch_trim; break;\
    default: var = 0.; break;\
  }\
  DOWNLINK_SEND_DL_VALUE(&i, &var);\
  i++;\
}

#endif // SETTINGS_H
