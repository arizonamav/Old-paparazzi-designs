/* This file has been generated from /home/mav/Desktop/paparazzivn100/conf/settings/tuning_ver_i2cworking.xml */
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
    case 5: alt_kalman_enabled = _value; break;\
    case 6: estimator_flight_time = _value; break;\
    case 7: launch = _value; break;\
    case 8: kill_throttle = _value; break;\
    case 9: ir_roll_neutral = _value; break;\
    case 10: ir_pitch_neutral = _value; break;\
    case 11: ir_correction_left = _value; break;\
    case 12: ir_correction_right = _value; break;\
    case 13: ir_correction_up = _value; break;\
    case 14: ir_correction_down = _value; break;\
    case 15: ir_estim_mode = _value; break;\
    case 16: h_ctl_attitude_enabled = _value; break;\
    case 17: gyro_roll_adc = _value; break;\
    case 18: gyro_pitch_adc = _value; break;\
    case 19: gyro_yaw_adc = _value; break;\
    case 20: h_ctl_elevator_of_roll = _value; break;\
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
    case 32: v_ctl_auto_throttle_cruise_throttle_pgain = _value; break;\
  }\
}
#define PeriodicSendDlValue() { \
  static uint8_t i;\
  float var;\
  if (i >= 33) i = 0;;\
  switch (i) { \
    case 0: var = flight_altitude; break;\
    case 1: var = light_mode; break;\
    case 2: var = wind_east; break;\
    case 3: var = wind_north; break;\
    case 4: var = pprz_mode; break;\
    case 5: var = alt_kalman_enabled; break;\
    case 6: var = estimator_flight_time; break;\
    case 7: var = launch; break;\
    case 8: var = kill_throttle; break;\
    case 9: var = ir_roll_neutral; break;\
    case 10: var = ir_pitch_neutral; break;\
    case 11: var = ir_correction_left; break;\
    case 12: var = ir_correction_right; break;\
    case 13: var = ir_correction_up; break;\
    case 14: var = ir_correction_down; break;\
    case 15: var = ir_estim_mode; break;\
    case 16: var = h_ctl_attitude_enabled; break;\
    case 17: var = gyro_roll_adc; break;\
    case 18: var = gyro_pitch_adc; break;\
    case 19: var = gyro_yaw_adc; break;\
    case 20: var = h_ctl_elevator_of_roll; break;\
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
    case 32: var = v_ctl_auto_throttle_cruise_throttle_pgain; break;\
    default: var = 0.; break;\
  }\
  DOWNLINK_SEND_DL_VALUE(&i, &var);\
  i++;\
}

#endif // SETTINGS_H
