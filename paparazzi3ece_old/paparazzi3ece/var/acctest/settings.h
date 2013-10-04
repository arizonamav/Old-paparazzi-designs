/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/settings/tuning_kalman.xml */
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
    case 8: gyro_roll_scale = _value; break;\
    case 9: gyro_pitch_scale = _value; break;\
    case 10: gyro_roll_adc = _value; break;\
    case 11: gyro_pitch_adc = _value; break;\
    case 12: accel_ax_scale = _value; break;\
    case 13: accel_ay_scale = _value; break;\
    case 14: accel_az_scale = _value; break;\
    case 15: accel_ax_neutral = _value; break;\
    case 16: accel_ay_neutral = _value; break;\
    case 17: accel_az_neutral = _value; break;\
    case 18: estimator_kalman_q_angle = _value; break;\
    case 19: estimator_kalman_q_gyro = _value; break;\
    case 20: estimator_kalman_r_angle = _value; break;\
    case 21: h_ctl_roll_rate_setpoint_pgain = _value; break;\
    case 22: h_ctl_hi_throttle_roll_rate_pgain = _value; break;\
    case 23: h_ctl_lo_throttle_roll_rate_pgain = _value; break;\
    case 24: h_ctl_pitch_rate_setpoint_pgain = _value; break;\
    case 25: h_ctl_hi_throttle_pitch_rate_pgain = _value; break;\
    case 26: h_ctl_lo_throttle_pitch_rate_pgain = _value; break;\
    case 27: h_ctl_yaw_rate_setpoint_pgain = _value; break;\
    case 28: h_ctl_hi_throttle_yaw_rate_pgain = _value; break;\
    case 29: h_ctl_lo_throttle_yaw_rate_pgain = _value; break;\
    case 30: v_ctl_altitude_pgain = _value; break;\
    case 31: v_ctl_auto_throttle_cruise_throttle = _value; break;\
    case 32: v_ctl_auto_throttle_pgain = _value; break;\
    case 33: v_ctl_auto_throttle_igain = _value; break;\
    case 34: v_ctl_auto_throttle_climb_throttle_increment = _value; break;\
    case 35: vdrop2throt_coeff = _value; break;\
    case 36: v_ctl_throttle_slew_ = _value; break;\
    case 37: v_ctl_auto_pitch_pgain = _value; break;\
    case 38: v_ctl_auto_pitch_igain = _value; break;\
    case 39: h_ctl_course_pgain = _value; break;\
    case 40: h_ctl_course_pre_bank_correction = _value; break;\
    case 41: nav_glide_pitch_trim = _value; break;\
  }\
}
#define PeriodicSendDlValue() { \
  static uint8_t i;\
  float var;\
  if (i >= 42) i = 0;;\
  switch (i) { \
    case 0: var = flight_altitude; break;\
    case 1: var = light_mode; break;\
    case 2: var = wind_east; break;\
    case 3: var = wind_north; break;\
    case 4: var = pprz_mode; break;\
    case 5: var = estimator_flight_time; break;\
    case 6: var = launch; break;\
    case 7: var = kill_throttle; break;\
    case 8: var = gyro_roll_scale; break;\
    case 9: var = gyro_pitch_scale; break;\
    case 10: var = gyro_roll_adc; break;\
    case 11: var = gyro_pitch_adc; break;\
    case 12: var = accel_ax_scale; break;\
    case 13: var = accel_ay_scale; break;\
    case 14: var = accel_az_scale; break;\
    case 15: var = accel_ax_neutral; break;\
    case 16: var = accel_ay_neutral; break;\
    case 17: var = accel_az_neutral; break;\
    case 18: var = estimator_kalman_q_angle; break;\
    case 19: var = estimator_kalman_q_gyro; break;\
    case 20: var = estimator_kalman_r_angle; break;\
    case 21: var = h_ctl_roll_rate_setpoint_pgain; break;\
    case 22: var = h_ctl_hi_throttle_roll_rate_pgain; break;\
    case 23: var = h_ctl_lo_throttle_roll_rate_pgain; break;\
    case 24: var = h_ctl_pitch_rate_setpoint_pgain; break;\
    case 25: var = h_ctl_hi_throttle_pitch_rate_pgain; break;\
    case 26: var = h_ctl_lo_throttle_pitch_rate_pgain; break;\
    case 27: var = h_ctl_yaw_rate_setpoint_pgain; break;\
    case 28: var = h_ctl_hi_throttle_yaw_rate_pgain; break;\
    case 29: var = h_ctl_lo_throttle_yaw_rate_pgain; break;\
    case 30: var = v_ctl_altitude_pgain; break;\
    case 31: var = v_ctl_auto_throttle_cruise_throttle; break;\
    case 32: var = v_ctl_auto_throttle_pgain; break;\
    case 33: var = v_ctl_auto_throttle_igain; break;\
    case 34: var = v_ctl_auto_throttle_climb_throttle_increment; break;\
    case 35: var = vdrop2throt_coeff; break;\
    case 36: var = v_ctl_throttle_slew_; break;\
    case 37: var = v_ctl_auto_pitch_pgain; break;\
    case 38: var = v_ctl_auto_pitch_igain; break;\
    case 39: var = h_ctl_course_pgain; break;\
    case 40: var = h_ctl_course_pre_bank_correction; break;\
    case 41: var = nav_glide_pitch_trim; break;\
    default: var = 0.; break;\
  }\
  DOWNLINK_SEND_DL_VALUE(&i, &var);\
  i++;\
}

#endif // SETTINGS_H
