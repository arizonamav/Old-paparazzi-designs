/* Automatically generated from /home/mav/Desktop/paparazzivn100/conf/messages.xml */
/* Please DO NOT EDIT */
/* Macros to send and receive messages of class telemetry */
#ifdef DOWNLINK
#define DL_BOOT 1
#define DL_CALIB_START 2
#define DL_CALIB_CONTRAST 3
#define DL_TAKEOFF 4
#define DL_RAD_OF_IR 5
#define DL_ATTITUDE 6
#define DL_IR_SENSORS 7
#define DL_GPS 8
#define DL_NAVIGATION_REF 9
#define DL_NAVIGATION 10
#define DL_PPRZ_MODE 11
#define DL_BAT 12
#define DL_DEBUG_MCU_LINK 13
#define DL_CALIBRATION 14
#define DL_SETTINGS 15
#define DL_DESIRED 16
#define DL_ENOSE_STATUS 17
#define DL_VN100_STATUS 19
#define DL_CAM 20
#define DL_CIRCLE 21
#define DL_SEGMENT 22
#define DL_DOWNLINK_STATUS 23
#define DL_MODEM_STATUS 24
#define DL_SVINFO 25
#define DL_SURVEY 27
#define DL_WC_RSSI 28
#define DL_RANGEFINDER 29
#define DL_DEBUG_MODEM 30
#define DL_DL_VALUE 31
#define DL_MARK 32
#define DL_DEBUG1 33
#define DL_DEBUG2 34
#define DL_WP_MOVED 35
#define DL_GYRO_RATES 36
#define DL_GRZ_MEASURE 37
#define DL_GRZ_RATE_LOOP 38
#define DL_GRZ_ATTITUDE_LOOP 39
#define DL_SPEED_LOOP 40
#define DL_ALT_KALMAN 41
#define DL_ESTIMATOR 42
#define DL_PPM 100
#define DL_RC 101
#define DL_COMMANDS 102
#define DL_FBW_STATUS 103
#define DL_ADC 104
#define DL_ACTUATORS 105
#define DL_DEBUG16 106
#define DL_IMU_GYRO 200
#define DL_IMU_MAG 201
#define DL_IMU_ACCEL 202
#define DL_AHRS_STATE 203
#define DL_AHRS_COV 204
#define DL_TIME 206
#define DL_AHRS_OVERRUN 207
#define DL_ANTENNA_DEBUG 220
#define DL_ANTENNA_STATUS 221
#define DL_MOTOR_BENCH_STATUS 230
#define DL_SERVO 209
#define DL_IR_DEBUG 210
#define DL_ACCEL_RATES 212
#define DL_KALMAN_ROLL_PITCH 213
#define DL_MSG_telemetry_NB 61

#define MSG_telemetry_LENGTHS {0,(2+0+2),(2+0),(2+0+2),(2+0+2),(2+0+2+2+4),(2+0+2+2+2),(2+0+2+2+2),(2+0+1+4+4+2+4+2+2+4+1+1),(2+0+4+4+1),(2+0+1+1+2+2+2+4+4),(2+0+1+1+1+1+1+1+1),(2+0+2+1+2+1+2+2+2),(2+0+1+1+1),(2+0+4+4+4+1),(2+0+4+4),(2+0+4+4+4+4+4+4),(2+0+2+2+2+4+4+4+1),0,(2+0+4+4+4),(2+0+1+1+2+2),(2+0+2+2+2),(2+0+2+2+2+2),(2+0+4+4+4+4+4+4),(2+0+1+4+1+4+4+4),(2+0+1+1+1+1+1+1+2),0,(2+0+4+4+4+4),(2+0+1),(2+0+2+4+4+4+4+4+1),(2+0+1),(2+0+1+4),(2+0+1+4+4),(2+0+1+1+nb_foo*1),(2+0+1+nb_foo*1),(2+0+1+4+4+4),(2+0+2+2+2+4+4+4),(2+0+4+4+4+4+4+4),(2+0+4+4+4+4+4+4),(2+0+4+4+4+4+4+4),(2+0+4+4+4+4+4+4),(2+0+4+4+4+4),(2+0+4+4+4+4+4),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,(2+0+1+nb_values*2),(2+0+1+nb_values*2),(2+0+1+nb_values*2),(2+0+1+1+1),(2+0+1+1+nb_values*2),(2+0+1+nb_values*2),(2+0+2),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,(2+0+4+4+4),(2+0+2+2+2),(2+0+4+4+4),(2+0+4+4+4+4+4+4+4),(2+0+4+4),0,(2+0+4),(2+0),0,(2+0+2+2+2),(2+0+2+2+2+2),0,(2+0+2+2+2+4+4+4+4+4+4),(2+0+4+4+4+4+4),0,0,0,0,0,0,(2+0+4+4+4+4+4+4+4+1+1),(2+0+4+4+1+1),0,0,0,0,0,0,0,0,(2+0+4+2+2+1),}

#define DOWNLINK_SEND_BOOT(version){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2))) {\
	  DownlinkStartMessage("BOOT", DL_BOOT, 0+2) \
	  DownlinkPutUint16ByAddr((version)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_CALIB_START(){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0))) {\
	  DownlinkStartMessage("CALIB_START", DL_CALIB_START, 0) \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_CALIB_CONTRAST(adc){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2))) {\
	  DownlinkStartMessage("CALIB_CONTRAST", DL_CALIB_CONTRAST, 0+2) \
	  DownlinkPutInt16ByAddr((adc)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_TAKEOFF(cpu_time){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2))) {\
	  DownlinkStartMessage("TAKEOFF", DL_TAKEOFF, 0+2) \
	  DownlinkPutUint16ByAddr((cpu_time)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_RAD_OF_IR(ir, rad, rad_of_ir){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+4))) {\
	  DownlinkStartMessage("RAD_OF_IR", DL_RAD_OF_IR, 0+2+2+4) \
	  DownlinkPutInt16ByAddr((ir)); \
	  DownlinkPutInt16ByAddr((rad)); \
	  DownlinkPutFloatByAddr((rad_of_ir)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_ATTITUDE(phi, psi, theta){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+2))) {\
	  DownlinkStartMessage("ATTITUDE", DL_ATTITUDE, 0+2+2+2) \
	  DownlinkPutInt16ByAddr((phi)); \
	  DownlinkPutInt16ByAddr((psi)); \
	  DownlinkPutInt16ByAddr((theta)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_IR_SENSORS(longitudinal, lateral, vertical){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+2))) {\
	  DownlinkStartMessage("IR_SENSORS", DL_IR_SENSORS, 0+2+2+2) \
	  DownlinkPutInt16ByAddr((longitudinal)); \
	  DownlinkPutInt16ByAddr((lateral)); \
	  DownlinkPutInt16ByAddr((vertical)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_GPS(mode, utm_east, utm_north, course, alt, speed, climb, itow, utm_zone, gps_nb_err){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+4+4+2+4+2+2+4+1+1))) {\
	  DownlinkStartMessage("GPS", DL_GPS, 0+1+4+4+2+4+2+2+4+1+1) \
	  DownlinkPutUint8ByAddr((mode)); \
	  DownlinkPutInt32ByAddr((utm_east)); \
	  DownlinkPutInt32ByAddr((utm_north)); \
	  DownlinkPutInt16ByAddr((course)); \
	  DownlinkPutInt32ByAddr((alt)); \
	  DownlinkPutUint16ByAddr((speed)); \
	  DownlinkPutInt16ByAddr((climb)); \
	  DownlinkPutUint32ByAddr((itow)); \
	  DownlinkPutUint8ByAddr((utm_zone)); \
	  DownlinkPutUint8ByAddr((gps_nb_err)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_NAVIGATION_REF(utm_east, utm_north, utm_zone){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+1))) {\
	  DownlinkStartMessage("NAVIGATION_REF", DL_NAVIGATION_REF, 0+4+4+1) \
	  DownlinkPutInt32ByAddr((utm_east)); \
	  DownlinkPutInt32ByAddr((utm_north)); \
	  DownlinkPutUint8ByAddr((utm_zone)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_NAVIGATION(cur_block, cur_stage, pos_x, pos_y, desired_course, dist2_wp, dist2_home){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+2+2+2+4+4))) {\
	  DownlinkStartMessage("NAVIGATION", DL_NAVIGATION, 0+1+1+2+2+2+4+4) \
	  DownlinkPutUint8ByAddr((cur_block)); \
	  DownlinkPutUint8ByAddr((cur_stage)); \
	  DownlinkPutInt16ByAddr((pos_x)); \
	  DownlinkPutInt16ByAddr((pos_y)); \
	  DownlinkPutInt16ByAddr((desired_course)); \
	  DownlinkPutFloatByAddr((dist2_wp)); \
	  DownlinkPutFloatByAddr((dist2_home)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_PPRZ_MODE(ap_mode, ap_gaz, ap_lateral, ap_horizontal, if_calib_mode, mcu1_status, lls_calib){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+1+1+1+1+1))) {\
	  DownlinkStartMessage("PPRZ_MODE", DL_PPRZ_MODE, 0+1+1+1+1+1+1+1) \
	  DownlinkPutUint8ByAddr((ap_mode)); \
	  DownlinkPutUint8ByAddr((ap_gaz)); \
	  DownlinkPutUint8ByAddr((ap_lateral)); \
	  DownlinkPutUint8ByAddr((ap_horizontal)); \
	  DownlinkPutUint8ByAddr((if_calib_mode)); \
	  DownlinkPutUint8ByAddr((mcu1_status)); \
	  DownlinkPutUint8ByAddr((lls_calib)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_BAT(throttle, voltage, flight_time, kill_auto_throttle, block_time, stage_time, energy){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+1+2+1+2+2+2))) {\
	  DownlinkStartMessage("BAT", DL_BAT, 0+2+1+2+1+2+2+2) \
	  DownlinkPutInt16ByAddr((throttle)); \
	  DownlinkPutUint8ByAddr((voltage)); \
	  DownlinkPutUint16ByAddr((flight_time)); \
	  DownlinkPutUint8ByAddr((kill_auto_throttle)); \
	  DownlinkPutUint16ByAddr((block_time)); \
	  DownlinkPutUint16ByAddr((stage_time)); \
	  DownlinkPutUint16ByAddr((energy)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_DEBUG_MCU_LINK(i2c_nb_err, i2c_mcu1_nb_err, ppm_rate){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+1))) {\
	  DownlinkStartMessage("DEBUG_MCU_LINK", DL_DEBUG_MCU_LINK, 0+1+1+1) \
	  DownlinkPutUint8ByAddr((i2c_nb_err)); \
	  DownlinkPutUint8ByAddr((i2c_mcu1_nb_err)); \
	  DownlinkPutUint8ByAddr((ppm_rate)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_CALIBRATION(climb_sum_err, climb_pgain, course_pgain, climb_gaz_submode){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+1))) {\
	  DownlinkStartMessage("CALIBRATION", DL_CALIBRATION, 0+4+4+4+1) \
	  DownlinkPutFloatByAddr((climb_sum_err)); \
	  DownlinkPutFloatByAddr((climb_pgain)); \
	  DownlinkPutFloatByAddr((course_pgain)); \
	  DownlinkPutUint8ByAddr((climb_gaz_submode)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_SETTINGS(slider_1_val, slider_2_val){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4))) {\
	  DownlinkStartMessage("SETTINGS", DL_SETTINGS, 0+4+4) \
	  DownlinkPutFloatByAddr((slider_1_val)); \
	  DownlinkPutFloatByAddr((slider_2_val)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_DESIRED(roll, pitch, desired_x, desired_y, desired_altitude, desired_climb){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4+4+4))) {\
	  DownlinkStartMessage("DESIRED", DL_DESIRED, 0+4+4+4+4+4+4) \
	  DownlinkPutFloatByAddr((roll)); \
	  DownlinkPutFloatByAddr((pitch)); \
	  DownlinkPutFloatByAddr((desired_x)); \
	  DownlinkPutFloatByAddr((desired_y)); \
	  DownlinkPutFloatByAddr((desired_altitude)); \
	  DownlinkPutFloatByAddr((desired_climb)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_ENOSE_STATUS(Sensor1, Sensor2, Sensor3, FCG1, FCG2, FCG3, Heat_Setting){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+2+4+4+4+1))) {\
	  DownlinkStartMessage("ENOSE_STATUS", DL_ENOSE_STATUS, 0+2+2+2+4+4+4+1) \
	  DownlinkPutUint16ByAddr((Sensor1)); \
	  DownlinkPutUint16ByAddr((Sensor2)); \
	  DownlinkPutUint16ByAddr((Sensor3)); \
	  DownlinkPutFloatByAddr((FCG1)); \
	  DownlinkPutFloatByAddr((FCG2)); \
	  DownlinkPutFloatByAddr((FCG3)); \
	  DownlinkPutUint8ByAddr((Heat_Setting)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_VN100_STATUS(Roll, Pitch, Yaw){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4))) {\
	  DownlinkStartMessage("VN100_STATUS", DL_VN100_STATUS, 0+4+4+4) \
	  DownlinkPutFloatByAddr((Roll)); \
	  DownlinkPutFloatByAddr((Pitch)); \
	  DownlinkPutFloatByAddr((Yaw)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_CAM(phi, theta, target_x, target_y){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+2+2))) {\
	  DownlinkStartMessage("CAM", DL_CAM, 0+1+1+2+2) \
	  DownlinkPutInt8ByAddr((phi)); \
	  DownlinkPutInt8ByAddr((theta)); \
	  DownlinkPutInt16ByAddr((target_x)); \
	  DownlinkPutInt16ByAddr((target_y)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_CIRCLE(center_east, center_north, radius){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+2))) {\
	  DownlinkStartMessage("CIRCLE", DL_CIRCLE, 0+2+2+2) \
	  DownlinkPutInt16ByAddr((center_east)); \
	  DownlinkPutInt16ByAddr((center_north)); \
	  DownlinkPutInt16ByAddr((radius)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_SEGMENT(segment_east_1, segment_north_1, segment_east_2, segment_north_2){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+2+2))) {\
	  DownlinkStartMessage("SEGMENT", DL_SEGMENT, 0+2+2+2+2) \
	  DownlinkPutInt16ByAddr((segment_east_1)); \
	  DownlinkPutInt16ByAddr((segment_north_1)); \
	  DownlinkPutInt16ByAddr((segment_east_2)); \
	  DownlinkPutInt16ByAddr((segment_north_2)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_DOWNLINK_STATUS(run_time, rx_bytes, rx_msgs, rx_err, rx_bytes_rate, rx_msgs_rate){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4+4+4))) {\
	  DownlinkStartMessage("DOWNLINK_STATUS", DL_DOWNLINK_STATUS, 0+4+4+4+4+4+4) \
	  DownlinkPutUint32ByAddr((run_time)); \
	  DownlinkPutUint32ByAddr((rx_bytes)); \
	  DownlinkPutUint32ByAddr((rx_msgs)); \
	  DownlinkPutUint32ByAddr((rx_err)); \
	  DownlinkPutFloatByAddr((rx_bytes_rate)); \
	  DownlinkPutFloatByAddr((rx_msgs_rate)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_MODEM_STATUS(detected, valim, cd, nb_byte, nb_msg, nb_err){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+4+1+4+4+4))) {\
	  DownlinkStartMessage("MODEM_STATUS", DL_MODEM_STATUS, 0+1+4+1+4+4+4) \
	  DownlinkPutUint8ByAddr((detected)); \
	  DownlinkPutFloatByAddr((valim)); \
	  DownlinkPutUint8ByAddr((cd)); \
	  DownlinkPutUint32ByAddr((nb_byte)); \
	  DownlinkPutUint32ByAddr((nb_msg)); \
	  DownlinkPutUint32ByAddr((nb_err)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_SVINFO(chn, SVID, Flags, QI, CNO, Elev, Azim){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+1+1+1+1+2))) {\
	  DownlinkStartMessage("SVINFO", DL_SVINFO, 0+1+1+1+1+1+1+2) \
	  DownlinkPutUint8ByAddr((chn)); \
	  DownlinkPutUint8ByAddr((SVID)); \
	  DownlinkPutUint8ByAddr((Flags)); \
	  DownlinkPutInt8ByAddr((QI)); \
	  DownlinkPutUint8ByAddr((CNO)); \
	  DownlinkPutInt8ByAddr((Elev)); \
	  DownlinkPutInt16ByAddr((Azim)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_SURVEY(east, north, west, south){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4))) {\
	  DownlinkStartMessage("SURVEY", DL_SURVEY, 0+4+4+4+4) \
	  DownlinkPutFloatByAddr((east)); \
	  DownlinkPutFloatByAddr((north)); \
	  DownlinkPutFloatByAddr((west)); \
	  DownlinkPutFloatByAddr((south)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_WC_RSSI(raw_level){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1))) {\
	  DownlinkStartMessage("WC_RSSI", DL_WC_RSSI, 0+1) \
	  DownlinkPutUint8ByAddr((raw_level)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_RANGEFINDER(range, z_dot, z_dot_sum_err, z_dot_setpoint, z_sum_err, z_setpoint, flying){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+4+4+4+4+4+1))) {\
	  DownlinkStartMessage("RANGEFINDER", DL_RANGEFINDER, 0+2+4+4+4+4+4+1) \
	  DownlinkPutUint16ByAddr((range)); \
	  DownlinkPutFloatByAddr((z_dot)); \
	  DownlinkPutFloatByAddr((z_dot_sum_err)); \
	  DownlinkPutFloatByAddr((z_dot_setpoint)); \
	  DownlinkPutFloatByAddr((z_sum_err)); \
	  DownlinkPutFloatByAddr((z_setpoint)); \
	  DownlinkPutUint8ByAddr((flying)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_DEBUG_MODEM(modem_nb_err){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1))) {\
	  DownlinkStartMessage("DEBUG_MODEM", DL_DEBUG_MODEM, 0+1) \
	  DownlinkPutUint8ByAddr((modem_nb_err)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_DL_VALUE(index, value){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+4))) {\
	  DownlinkStartMessage("DL_VALUE", DL_DL_VALUE, 0+1+4) \
	  DownlinkPutUint8ByAddr((index)); \
	  DownlinkPutFloatByAddr((value)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_MARK(ac_id, lat, long){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+4+4))) {\
	  DownlinkStartMessage("MARK", DL_MARK, 0+1+4+4) \
	  DownlinkPutUint8ByAddr((ac_id)); \
	  DownlinkPutFloatByAddr((lat)); \
	  DownlinkPutFloatByAddr((long)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_DEBUG1(xxx, nb_foo, foo){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+nb_foo*1))) {\
	  DownlinkStartMessage("DEBUG1", DL_DEBUG1, 0+1+1+nb_foo*1) \
	  DownlinkPutUint8ByAddr((xxx)); \
	  DownlinkPutUint8Array(nb_foo, foo); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_DEBUG2(nb_foo, foo){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+nb_foo*1))) {\
	  DownlinkStartMessage("DEBUG2", DL_DEBUG2, 0+1+nb_foo*1) \
	  DownlinkPutUint8Array(nb_foo, foo); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_WP_MOVED(wp_id, utm_east, utm_north, alt){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+4+4+4))) {\
	  DownlinkStartMessage("WP_MOVED", DL_WP_MOVED, 0+1+4+4+4) \
	  DownlinkPutUint8ByAddr((wp_id)); \
	  DownlinkPutFloatByAddr((utm_east)); \
	  DownlinkPutFloatByAddr((utm_north)); \
	  DownlinkPutFloatByAddr((alt)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_GYRO_RATES(roll_adc, pitch_adc, yaw_adc, roll, pitch, yaw){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+2+4+4+4))) {\
	  DownlinkStartMessage("GYRO_RATES", DL_GYRO_RATES, 0+2+2+2+4+4+4) \
	  DownlinkPutInt16ByAddr((roll_adc)); \
	  DownlinkPutInt16ByAddr((pitch_adc)); \
	  DownlinkPutInt16ByAddr((yaw_adc)); \
	  DownlinkPutFloatByAddr((roll)); \
	  DownlinkPutFloatByAddr((pitch)); \
	  DownlinkPutFloatByAddr((yaw)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_GRZ_MEASURE(roll_dot, pitch_dot, yaw_dot, roll, pitch, yaw){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4+4+4))) {\
	  DownlinkStartMessage("GRZ_MEASURE", DL_GRZ_MEASURE, 0+4+4+4+4+4+4) \
	  DownlinkPutFloatByAddr((roll_dot)); \
	  DownlinkPutFloatByAddr((pitch_dot)); \
	  DownlinkPutFloatByAddr((yaw_dot)); \
	  DownlinkPutFloatByAddr((roll)); \
	  DownlinkPutFloatByAddr((pitch)); \
	  DownlinkPutFloatByAddr((yaw)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_GRZ_RATE_LOOP(roll_dot_meas, roll_dot_sp, pitch_dot_meas, pitch_dot_sp, yaw_dot_meas, yaw_dot_sp){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4+4+4))) {\
	  DownlinkStartMessage("GRZ_RATE_LOOP", DL_GRZ_RATE_LOOP, 0+4+4+4+4+4+4) \
	  DownlinkPutFloatByAddr((roll_dot_meas)); \
	  DownlinkPutFloatByAddr((roll_dot_sp)); \
	  DownlinkPutFloatByAddr((pitch_dot_meas)); \
	  DownlinkPutFloatByAddr((pitch_dot_sp)); \
	  DownlinkPutFloatByAddr((yaw_dot_meas)); \
	  DownlinkPutFloatByAddr((yaw_dot_sp)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_GRZ_ATTITUDE_LOOP(roll_meas, roll_sp, pitch_meas, pitch_sp, yaw_meas, yaw_sp){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4+4+4))) {\
	  DownlinkStartMessage("GRZ_ATTITUDE_LOOP", DL_GRZ_ATTITUDE_LOOP, 0+4+4+4+4+4+4) \
	  DownlinkPutFloatByAddr((roll_meas)); \
	  DownlinkPutFloatByAddr((roll_sp)); \
	  DownlinkPutFloatByAddr((pitch_meas)); \
	  DownlinkPutFloatByAddr((pitch_sp)); \
	  DownlinkPutFloatByAddr((yaw_meas)); \
	  DownlinkPutFloatByAddr((yaw_sp)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_SPEED_LOOP(ve_set_point, ve, vn_set_point, vn, north_sp, east_sp){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4+4+4))) {\
	  DownlinkStartMessage("SPEED_LOOP", DL_SPEED_LOOP, 0+4+4+4+4+4+4) \
	  DownlinkPutFloatByAddr((ve_set_point)); \
	  DownlinkPutFloatByAddr((ve)); \
	  DownlinkPutFloatByAddr((vn_set_point)); \
	  DownlinkPutFloatByAddr((vn)); \
	  DownlinkPutFloatByAddr((north_sp)); \
	  DownlinkPutFloatByAddr((east_sp)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_ALT_KALMAN(p00, p01, p10, p11){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4))) {\
	  DownlinkStartMessage("ALT_KALMAN", DL_ALT_KALMAN, 0+4+4+4+4) \
	  DownlinkPutFloatByAddr((p00)); \
	  DownlinkPutFloatByAddr((p01)); \
	  DownlinkPutFloatByAddr((p10)); \
	  DownlinkPutFloatByAddr((p11)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_ESTIMATOR(z, z_dot, range, range_dot, range_ave){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4+4))) {\
	  DownlinkStartMessage("ESTIMATOR", DL_ESTIMATOR, 0+4+4+4+4+4) \
	  DownlinkPutFloatByAddr((z)); \
	  DownlinkPutFloatByAddr((z_dot)); \
	  DownlinkPutFloatByAddr((range)); \
	  DownlinkPutFloatByAddr((range_dot)); \
	  DownlinkPutFloatByAddr((range_ave)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_PPM(nb_values, values){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+nb_values*2))) {\
	  DownlinkStartMessage("PPM", DL_PPM, 0+1+nb_values*2) \
	  DownlinkPutUint16Array(nb_values, values); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_RC(nb_values, values){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+nb_values*2))) {\
	  DownlinkStartMessage("RC", DL_RC, 0+1+nb_values*2) \
	  DownlinkPutInt16Array(nb_values, values); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_COMMANDS(nb_values, values){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+nb_values*2))) {\
	  DownlinkStartMessage("COMMANDS", DL_COMMANDS, 0+1+nb_values*2) \
	  DownlinkPutInt16Array(nb_values, values); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_FBW_STATUS(rc_status, mode, vsupply){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+1))) {\
	  DownlinkStartMessage("FBW_STATUS", DL_FBW_STATUS, 0+1+1+1) \
	  DownlinkPutUint8ByAddr((rc_status)); \
	  DownlinkPutUint8ByAddr((mode)); \
	  DownlinkPutUint8ByAddr((vsupply)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_ADC(mcu, nb_values, values){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+1+nb_values*2))) {\
	  DownlinkStartMessage("ADC", DL_ADC, 0+1+1+nb_values*2) \
	  DownlinkPutUint8ByAddr((mcu)); \
	  DownlinkPutUint16Array(nb_values, values); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_ACTUATORS(nb_values, values){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+1+nb_values*2))) {\
	  DownlinkStartMessage("ACTUATORS", DL_ACTUATORS, 0+1+nb_values*2) \
	  DownlinkPutUint16Array(nb_values, values); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_DEBUG16(xxx){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2))) {\
	  DownlinkStartMessage("DEBUG16", DL_DEBUG16, 0+2) \
	  DownlinkPutUint16ByAddr((xxx)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_IMU_GYRO(gx, gy, gz){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4))) {\
	  DownlinkStartMessage("IMU_GYRO", DL_IMU_GYRO, 0+4+4+4) \
	  DownlinkPutFloatByAddr((gx)); \
	  DownlinkPutFloatByAddr((gy)); \
	  DownlinkPutFloatByAddr((gz)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_IMU_MAG(ax, ay, az){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+2))) {\
	  DownlinkStartMessage("IMU_MAG", DL_IMU_MAG, 0+2+2+2) \
	  DownlinkPutInt16ByAddr((ax)); \
	  DownlinkPutInt16ByAddr((ay)); \
	  DownlinkPutInt16ByAddr((az)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_IMU_ACCEL(ax, ay, az){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4))) {\
	  DownlinkStartMessage("IMU_ACCEL", DL_IMU_ACCEL, 0+4+4+4) \
	  DownlinkPutFloatByAddr((ax)); \
	  DownlinkPutFloatByAddr((ay)); \
	  DownlinkPutFloatByAddr((az)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_AHRS_STATE(q0, q1, q2, q3, bx, by, bz){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4+4+4+4))) {\
	  DownlinkStartMessage("AHRS_STATE", DL_AHRS_STATE, 0+4+4+4+4+4+4+4) \
	  DownlinkPutFloatByAddr((q0)); \
	  DownlinkPutFloatByAddr((q1)); \
	  DownlinkPutFloatByAddr((q2)); \
	  DownlinkPutFloatByAddr((q3)); \
	  DownlinkPutFloatByAddr((bx)); \
	  DownlinkPutFloatByAddr((by)); \
	  DownlinkPutFloatByAddr((bz)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_AHRS_COV(p00, p11){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4))) {\
	  DownlinkStartMessage("AHRS_COV", DL_AHRS_COV, 0+4+4) \
	  DownlinkPutFloatByAddr((p00)); \
	  DownlinkPutFloatByAddr((p11)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_TIME(t){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4))) {\
	  DownlinkStartMessage("TIME", DL_TIME, 0+4) \
	  DownlinkPutUint32ByAddr((t)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_AHRS_OVERRUN(){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0))) {\
	  DownlinkStartMessage("AHRS_OVERRUN", DL_AHRS_OVERRUN, 0) \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_ANTENNA_DEBUG(mag_xraw, mag_yraw, mag_xcal, mag_ycal, mag_heading, mag_magnitude, mag_temp, mag_distor, mag_cal_status){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4+4+4+4+1+1))) {\
	  DownlinkStartMessage("ANTENNA_DEBUG", DL_ANTENNA_DEBUG, 0+4+4+4+4+4+4+4+1+1) \
	  DownlinkPutInt32ByAddr((mag_xraw)); \
	  DownlinkPutInt32ByAddr((mag_yraw)); \
	  DownlinkPutFloatByAddr((mag_xcal)); \
	  DownlinkPutFloatByAddr((mag_ycal)); \
	  DownlinkPutFloatByAddr((mag_heading)); \
	  DownlinkPutFloatByAddr((mag_magnitude)); \
	  DownlinkPutFloatByAddr((mag_temp)); \
	  DownlinkPutUint8ByAddr((mag_distor)); \
	  DownlinkPutUint8ByAddr((mag_cal_status)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_ANTENNA_STATUS(azim_sp, elev_sp, id_sp, mode){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+1+1))) {\
	  DownlinkStartMessage("ANTENNA_STATUS", DL_ANTENNA_STATUS, 0+4+4+1+1) \
	  DownlinkPutFloatByAddr((azim_sp)); \
	  DownlinkPutFloatByAddr((elev_sp)); \
	  DownlinkPutUint8ByAddr((id_sp)); \
	  DownlinkPutUint8ByAddr((mode)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_MOTOR_BENCH_STATUS(time_ticks, time_s, throttle, mode){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+2+2+1))) {\
	  DownlinkStartMessage("MOTOR_BENCH_STATUS", DL_MOTOR_BENCH_STATUS, 0+4+2+2+1) \
	  DownlinkPutUint32ByAddr((time_ticks)); \
	  DownlinkPutUint16ByAddr((time_s)); \
	  DownlinkPutUint16ByAddr((throttle)); \
	  DownlinkPutUint8ByAddr((mode)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_SERVO(elev, ailer, thrust){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+2))) {\
	  DownlinkStartMessage("SERVO", DL_SERVO, 0+2+2+2) \
	  DownlinkPutInt16ByAddr((elev)); \
	  DownlinkPutInt16ByAddr((ailer)); \
	  DownlinkPutInt16ByAddr((thrust)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_IR_DEBUG(ir1, ir2, ir3, ir4){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+2+2))) {\
	  DownlinkStartMessage("IR_DEBUG", DL_IR_DEBUG, 0+2+2+2+2) \
	  DownlinkPutInt16ByAddr((ir1)); \
	  DownlinkPutInt16ByAddr((ir2)); \
	  DownlinkPutInt16ByAddr((ir3)); \
	  DownlinkPutInt16ByAddr((ir4)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_ACCEL_RATES(ax_adc, ay_adc, az_adc, ax, ay, az, axfil, ayfil, azfil){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+2+2+2+4+4+4+4+4+4))) {\
	  DownlinkStartMessage("ACCEL_RATES", DL_ACCEL_RATES, 0+2+2+2+4+4+4+4+4+4) \
	  DownlinkPutInt16ByAddr((ax_adc)); \
	  DownlinkPutInt16ByAddr((ay_adc)); \
	  DownlinkPutInt16ByAddr((az_adc)); \
	  DownlinkPutFloatByAddr((ax)); \
	  DownlinkPutFloatByAddr((ay)); \
	  DownlinkPutFloatByAddr((az)); \
	  DownlinkPutFloatByAddr((axfil)); \
	  DownlinkPutFloatByAddr((ayfil)); \
	  DownlinkPutFloatByAddr((azfil)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define DOWNLINK_SEND_KALMAN_ROLL_PITCH(roll, pitch, KALMAN_Q_ANGLE, KALMAN_Q_GYRO, KALMAN_R_ANGLE){ \
	if (DownlinkCheckFreeSpace(DownlinkSizeOf(0+4+4+4+4+4))) {\
	  DownlinkStartMessage("KALMAN_ROLL_PITCH", DL_KALMAN_ROLL_PITCH, 0+4+4+4+4+4) \
	  DownlinkPutFloatByAddr((roll)); \
	  DownlinkPutFloatByAddr((pitch)); \
	  DownlinkPutFloatByAddr((KALMAN_Q_ANGLE)); \
	  DownlinkPutFloatByAddr((KALMAN_Q_GYRO)); \
	  DownlinkPutFloatByAddr((KALMAN_R_ANGLE)); \
	  DownlinkEndMessage() \
	} else \
	  DonwlinkOverrun(); \
}

#define MESSAGES_MD5SUM "\156\054\322\261\004\165\012\226\302\337\367\012\204\262\150\222"
#else // DOWNLINK
#define DOWNLINK_SEND_BOOT(version) {}
#define DOWNLINK_SEND_CALIB_START() {}
#define DOWNLINK_SEND_CALIB_CONTRAST(adc) {}
#define DOWNLINK_SEND_TAKEOFF(cpu_time) {}
#define DOWNLINK_SEND_RAD_OF_IR(ir, rad, rad_of_ir) {}
#define DOWNLINK_SEND_ATTITUDE(phi, psi, theta) {}
#define DOWNLINK_SEND_IR_SENSORS(longitudinal, lateral, vertical) {}
#define DOWNLINK_SEND_GPS(mode, utm_east, utm_north, course, alt, speed, climb, itow, utm_zone, gps_nb_err) {}
#define DOWNLINK_SEND_NAVIGATION_REF(utm_east, utm_north, utm_zone) {}
#define DOWNLINK_SEND_NAVIGATION(cur_block, cur_stage, pos_x, pos_y, desired_course, dist2_wp, dist2_home) {}
#define DOWNLINK_SEND_PPRZ_MODE(ap_mode, ap_gaz, ap_lateral, ap_horizontal, if_calib_mode, mcu1_status, lls_calib) {}
#define DOWNLINK_SEND_BAT(throttle, voltage, flight_time, kill_auto_throttle, block_time, stage_time, energy) {}
#define DOWNLINK_SEND_DEBUG_MCU_LINK(i2c_nb_err, i2c_mcu1_nb_err, ppm_rate) {}
#define DOWNLINK_SEND_CALIBRATION(climb_sum_err, climb_pgain, course_pgain, climb_gaz_submode) {}
#define DOWNLINK_SEND_SETTINGS(slider_1_val, slider_2_val) {}
#define DOWNLINK_SEND_DESIRED(roll, pitch, desired_x, desired_y, desired_altitude, desired_climb) {}
#define DOWNLINK_SEND_ENOSE_STATUS(Sensor1, Sensor2, Sensor3, FCG1, FCG2, FCG3, Heat_Setting) {}
#define DOWNLINK_SEND_VN100_STATUS(Roll, Pitch, Yaw) {}
#define DOWNLINK_SEND_CAM(phi, theta, target_x, target_y) {}
#define DOWNLINK_SEND_CIRCLE(center_east, center_north, radius) {}
#define DOWNLINK_SEND_SEGMENT(segment_east_1, segment_north_1, segment_east_2, segment_north_2) {}
#define DOWNLINK_SEND_DOWNLINK_STATUS(run_time, rx_bytes, rx_msgs, rx_err, rx_bytes_rate, rx_msgs_rate) {}
#define DOWNLINK_SEND_MODEM_STATUS(detected, valim, cd, nb_byte, nb_msg, nb_err) {}
#define DOWNLINK_SEND_SVINFO(chn, SVID, Flags, QI, CNO, Elev, Azim) {}
#define DOWNLINK_SEND_SURVEY(east, north, west, south) {}
#define DOWNLINK_SEND_WC_RSSI(raw_level) {}
#define DOWNLINK_SEND_RANGEFINDER(range, z_dot, z_dot_sum_err, z_dot_setpoint, z_sum_err, z_setpoint, flying) {}
#define DOWNLINK_SEND_DEBUG_MODEM(modem_nb_err) {}
#define DOWNLINK_SEND_DL_VALUE(index, value) {}
#define DOWNLINK_SEND_MARK(ac_id, lat, long) {}
#define DOWNLINK_SEND_DEBUG1(xxx, nb_foo, foo) {}
#define DOWNLINK_SEND_DEBUG2(nb_foo, foo) {}
#define DOWNLINK_SEND_WP_MOVED(wp_id, utm_east, utm_north, alt) {}
#define DOWNLINK_SEND_GYRO_RATES(roll_adc, pitch_adc, yaw_adc, roll, pitch, yaw) {}
#define DOWNLINK_SEND_GRZ_MEASURE(roll_dot, pitch_dot, yaw_dot, roll, pitch, yaw) {}
#define DOWNLINK_SEND_GRZ_RATE_LOOP(roll_dot_meas, roll_dot_sp, pitch_dot_meas, pitch_dot_sp, yaw_dot_meas, yaw_dot_sp) {}
#define DOWNLINK_SEND_GRZ_ATTITUDE_LOOP(roll_meas, roll_sp, pitch_meas, pitch_sp, yaw_meas, yaw_sp) {}
#define DOWNLINK_SEND_SPEED_LOOP(ve_set_point, ve, vn_set_point, vn, north_sp, east_sp) {}
#define DOWNLINK_SEND_ALT_KALMAN(p00, p01, p10, p11) {}
#define DOWNLINK_SEND_ESTIMATOR(z, z_dot, range, range_dot, range_ave) {}
#define DOWNLINK_SEND_PPM(nb_values, values) {}
#define DOWNLINK_SEND_RC(nb_values, values) {}
#define DOWNLINK_SEND_COMMANDS(nb_values, values) {}
#define DOWNLINK_SEND_FBW_STATUS(rc_status, mode, vsupply) {}
#define DOWNLINK_SEND_ADC(mcu, nb_values, values) {}
#define DOWNLINK_SEND_ACTUATORS(nb_values, values) {}
#define DOWNLINK_SEND_DEBUG16(xxx) {}
#define DOWNLINK_SEND_IMU_GYRO(gx, gy, gz) {}
#define DOWNLINK_SEND_IMU_MAG(ax, ay, az) {}
#define DOWNLINK_SEND_IMU_ACCEL(ax, ay, az) {}
#define DOWNLINK_SEND_AHRS_STATE(q0, q1, q2, q3, bx, by, bz) {}
#define DOWNLINK_SEND_AHRS_COV(p00, p11) {}
#define DOWNLINK_SEND_TIME(t) {}
#define DOWNLINK_SEND_AHRS_OVERRUN() {}
#define DOWNLINK_SEND_ANTENNA_DEBUG(mag_xraw, mag_yraw, mag_xcal, mag_ycal, mag_heading, mag_magnitude, mag_temp, mag_distor, mag_cal_status) {}
#define DOWNLINK_SEND_ANTENNA_STATUS(azim_sp, elev_sp, id_sp, mode) {}
#define DOWNLINK_SEND_MOTOR_BENCH_STATUS(time_ticks, time_s, throttle, mode) {}
#define DOWNLINK_SEND_SERVO(elev, ailer, thrust) {}
#define DOWNLINK_SEND_IR_DEBUG(ir1, ir2, ir3, ir4) {}
#define DOWNLINK_SEND_ACCEL_RATES(ax_adc, ay_adc, az_adc, ax, ay, az, axfil, ayfil, azfil) {}
#define DOWNLINK_SEND_KALMAN_ROLL_PITCH(roll, pitch, KALMAN_Q_ANGLE, KALMAN_Q_GYRO, KALMAN_R_ANGLE) {}
#endif // DOWNLINK

#define DL_BOOT_version(_payload) (*(uint16_t*)(_payload+2))


#define DL_CALIB_CONTRAST_adc(_payload) (*(int16_t*)(_payload+2))

#define DL_TAKEOFF_cpu_time(_payload) (*(uint16_t*)(_payload+2))

#define DL_RAD_OF_IR_ir(_payload) (*(int16_t*)(_payload+2))
#define DL_RAD_OF_IR_rad(_payload) (*(int16_t*)(_payload+4))
#define DL_RAD_OF_IR_rad_of_ir(_payload) (*(float*)(_payload+6))

#define DL_ATTITUDE_phi(_payload) (*(int16_t*)(_payload+2))
#define DL_ATTITUDE_psi(_payload) (*(int16_t*)(_payload+4))
#define DL_ATTITUDE_theta(_payload) (*(int16_t*)(_payload+6))

#define DL_IR_SENSORS_longitudinal(_payload) (*(int16_t*)(_payload+2))
#define DL_IR_SENSORS_lateral(_payload) (*(int16_t*)(_payload+4))
#define DL_IR_SENSORS_vertical(_payload) (*(int16_t*)(_payload+6))

#define DL_GPS_mode(_payload) (*(uint8_t*)(_payload+2))
#define DL_GPS_utm_east(_payload) (*(int32_t*)(_payload+3))
#define DL_GPS_utm_north(_payload) (*(int32_t*)(_payload+7))
#define DL_GPS_course(_payload) (*(int16_t*)(_payload+11))
#define DL_GPS_alt(_payload) (*(int32_t*)(_payload+13))
#define DL_GPS_speed(_payload) (*(uint16_t*)(_payload+17))
#define DL_GPS_climb(_payload) (*(int16_t*)(_payload+19))
#define DL_GPS_itow(_payload) (*(uint32_t*)(_payload+21))
#define DL_GPS_utm_zone(_payload) (*(uint8_t*)(_payload+25))
#define DL_GPS_gps_nb_err(_payload) (*(uint8_t*)(_payload+26))

#define DL_NAVIGATION_REF_utm_east(_payload) (*(int32_t*)(_payload+2))
#define DL_NAVIGATION_REF_utm_north(_payload) (*(int32_t*)(_payload+6))
#define DL_NAVIGATION_REF_utm_zone(_payload) (*(uint8_t*)(_payload+10))

#define DL_NAVIGATION_cur_block(_payload) (*(uint8_t*)(_payload+2))
#define DL_NAVIGATION_cur_stage(_payload) (*(uint8_t*)(_payload+3))
#define DL_NAVIGATION_pos_x(_payload) (*(int16_t*)(_payload+4))
#define DL_NAVIGATION_pos_y(_payload) (*(int16_t*)(_payload+6))
#define DL_NAVIGATION_desired_course(_payload) (*(int16_t*)(_payload+8))
#define DL_NAVIGATION_dist2_wp(_payload) (*(float*)(_payload+10))
#define DL_NAVIGATION_dist2_home(_payload) (*(float*)(_payload+14))

#define DL_PPRZ_MODE_ap_mode(_payload) (*(uint8_t*)(_payload+2))
#define DL_PPRZ_MODE_ap_gaz(_payload) (*(uint8_t*)(_payload+3))
#define DL_PPRZ_MODE_ap_lateral(_payload) (*(uint8_t*)(_payload+4))
#define DL_PPRZ_MODE_ap_horizontal(_payload) (*(uint8_t*)(_payload+5))
#define DL_PPRZ_MODE_if_calib_mode(_payload) (*(uint8_t*)(_payload+6))
#define DL_PPRZ_MODE_mcu1_status(_payload) (*(uint8_t*)(_payload+7))
#define DL_PPRZ_MODE_lls_calib(_payload) (*(uint8_t*)(_payload+8))

#define DL_BAT_throttle(_payload) (*(int16_t*)(_payload+2))
#define DL_BAT_voltage(_payload) (*(uint8_t*)(_payload+4))
#define DL_BAT_flight_time(_payload) (*(uint16_t*)(_payload+5))
#define DL_BAT_kill_auto_throttle(_payload) (*(uint8_t*)(_payload+7))
#define DL_BAT_block_time(_payload) (*(uint16_t*)(_payload+8))
#define DL_BAT_stage_time(_payload) (*(uint16_t*)(_payload+10))
#define DL_BAT_energy(_payload) (*(uint16_t*)(_payload+12))

#define DL_DEBUG_MCU_LINK_i2c_nb_err(_payload) (*(uint8_t*)(_payload+2))
#define DL_DEBUG_MCU_LINK_i2c_mcu1_nb_err(_payload) (*(uint8_t*)(_payload+3))
#define DL_DEBUG_MCU_LINK_ppm_rate(_payload) (*(uint8_t*)(_payload+4))

#define DL_CALIBRATION_climb_sum_err(_payload) (*(float*)(_payload+2))
#define DL_CALIBRATION_climb_pgain(_payload) (*(float*)(_payload+6))
#define DL_CALIBRATION_course_pgain(_payload) (*(float*)(_payload+10))
#define DL_CALIBRATION_climb_gaz_submode(_payload) (*(uint8_t*)(_payload+14))

#define DL_SETTINGS_slider_1_val(_payload) (*(float*)(_payload+2))
#define DL_SETTINGS_slider_2_val(_payload) (*(float*)(_payload+6))

#define DL_DESIRED_roll(_payload) (*(float*)(_payload+2))
#define DL_DESIRED_pitch(_payload) (*(float*)(_payload+6))
#define DL_DESIRED_desired_x(_payload) (*(float*)(_payload+10))
#define DL_DESIRED_desired_y(_payload) (*(float*)(_payload+14))
#define DL_DESIRED_desired_altitude(_payload) (*(float*)(_payload+18))
#define DL_DESIRED_desired_climb(_payload) (*(float*)(_payload+22))

#define DL_ENOSE_STATUS_Sensor1(_payload) (*(uint16_t*)(_payload+2))
#define DL_ENOSE_STATUS_Sensor2(_payload) (*(uint16_t*)(_payload+4))
#define DL_ENOSE_STATUS_Sensor3(_payload) (*(uint16_t*)(_payload+6))
#define DL_ENOSE_STATUS_FCG1(_payload) (*(float*)(_payload+8))
#define DL_ENOSE_STATUS_FCG2(_payload) (*(float*)(_payload+12))
#define DL_ENOSE_STATUS_FCG3(_payload) (*(float*)(_payload+16))
#define DL_ENOSE_STATUS_Heat_Setting(_payload) (*(uint8_t*)(_payload+20))

#define DL_VN100_STATUS_Roll(_payload) (*(float*)(_payload+2))
#define DL_VN100_STATUS_Pitch(_payload) (*(float*)(_payload+6))
#define DL_VN100_STATUS_Yaw(_payload) (*(float*)(_payload+10))

#define DL_CAM_phi(_payload) (*(int8_t*)(_payload+2))
#define DL_CAM_theta(_payload) (*(int8_t*)(_payload+3))
#define DL_CAM_target_x(_payload) (*(int16_t*)(_payload+4))
#define DL_CAM_target_y(_payload) (*(int16_t*)(_payload+6))

#define DL_CIRCLE_center_east(_payload) (*(int16_t*)(_payload+2))
#define DL_CIRCLE_center_north(_payload) (*(int16_t*)(_payload+4))
#define DL_CIRCLE_radius(_payload) (*(int16_t*)(_payload+6))

#define DL_SEGMENT_segment_east_1(_payload) (*(int16_t*)(_payload+2))
#define DL_SEGMENT_segment_north_1(_payload) (*(int16_t*)(_payload+4))
#define DL_SEGMENT_segment_east_2(_payload) (*(int16_t*)(_payload+6))
#define DL_SEGMENT_segment_north_2(_payload) (*(int16_t*)(_payload+8))

#define DL_DOWNLINK_STATUS_run_time(_payload) (*(uint32_t*)(_payload+2))
#define DL_DOWNLINK_STATUS_rx_bytes(_payload) (*(uint32_t*)(_payload+6))
#define DL_DOWNLINK_STATUS_rx_msgs(_payload) (*(uint32_t*)(_payload+10))
#define DL_DOWNLINK_STATUS_rx_err(_payload) (*(uint32_t*)(_payload+14))
#define DL_DOWNLINK_STATUS_rx_bytes_rate(_payload) (*(float*)(_payload+18))
#define DL_DOWNLINK_STATUS_rx_msgs_rate(_payload) (*(float*)(_payload+22))

#define DL_MODEM_STATUS_detected(_payload) (*(uint8_t*)(_payload+2))
#define DL_MODEM_STATUS_valim(_payload) (*(float*)(_payload+3))
#define DL_MODEM_STATUS_cd(_payload) (*(uint8_t*)(_payload+7))
#define DL_MODEM_STATUS_nb_byte(_payload) (*(uint32_t*)(_payload+8))
#define DL_MODEM_STATUS_nb_msg(_payload) (*(uint32_t*)(_payload+12))
#define DL_MODEM_STATUS_nb_err(_payload) (*(uint32_t*)(_payload+16))

#define DL_SVINFO_chn(_payload) (*(uint8_t*)(_payload+2))
#define DL_SVINFO_SVID(_payload) (*(uint8_t*)(_payload+3))
#define DL_SVINFO_Flags(_payload) (*(uint8_t*)(_payload+4))
#define DL_SVINFO_QI(_payload) (*(int8_t*)(_payload+5))
#define DL_SVINFO_CNO(_payload) (*(uint8_t*)(_payload+6))
#define DL_SVINFO_Elev(_payload) (*(int8_t*)(_payload+7))
#define DL_SVINFO_Azim(_payload) (*(int16_t*)(_payload+8))

#define DL_SURVEY_east(_payload) (*(float*)(_payload+2))
#define DL_SURVEY_north(_payload) (*(float*)(_payload+6))
#define DL_SURVEY_west(_payload) (*(float*)(_payload+10))
#define DL_SURVEY_south(_payload) (*(float*)(_payload+14))

#define DL_WC_RSSI_raw_level(_payload) (*(uint8_t*)(_payload+2))

#define DL_RANGEFINDER_range(_payload) (*(uint16_t*)(_payload+2))
#define DL_RANGEFINDER_z_dot(_payload) (*(float*)(_payload+4))
#define DL_RANGEFINDER_z_dot_sum_err(_payload) (*(float*)(_payload+8))
#define DL_RANGEFINDER_z_dot_setpoint(_payload) (*(float*)(_payload+12))
#define DL_RANGEFINDER_z_sum_err(_payload) (*(float*)(_payload+16))
#define DL_RANGEFINDER_z_setpoint(_payload) (*(float*)(_payload+20))
#define DL_RANGEFINDER_flying(_payload) (*(uint8_t*)(_payload+24))

#define DL_DEBUG_MODEM_modem_nb_err(_payload) (*(uint8_t*)(_payload+2))

#define DL_DL_VALUE_index(_payload) (*(uint8_t*)(_payload+2))
#define DL_DL_VALUE_value(_payload) (*(float*)(_payload+3))

#define DL_MARK_ac_id(_payload) (*(uint8_t*)(_payload+2))
#define DL_MARK_lat(_payload) (*(float*)(_payload+3))
#define DL_MARK_long(_payload) (*(float*)(_payload+7))

#define DL_DEBUG1_xxx(_payload) (*(uint8_t*)(_payload+2))
#define DL_DEBUG1_foo_length(_payload) (*(uint8_t*)(_payload+3))
#define DL_DEBUG1_foo(_payload) (uint8_t*)(_payload+4)

#define DL_DEBUG2_foo_length(_payload) (*(uint8_t*)(_payload+2))
#define DL_DEBUG2_foo(_payload) (uint8_t*)(_payload+3)

#define DL_WP_MOVED_wp_id(_payload) (*(uint8_t*)(_payload+2))
#define DL_WP_MOVED_utm_east(_payload) (*(float*)(_payload+3))
#define DL_WP_MOVED_utm_north(_payload) (*(float*)(_payload+7))
#define DL_WP_MOVED_alt(_payload) (*(float*)(_payload+11))

#define DL_GYRO_RATES_roll_adc(_payload) (*(int16_t*)(_payload+2))
#define DL_GYRO_RATES_pitch_adc(_payload) (*(int16_t*)(_payload+4))
#define DL_GYRO_RATES_yaw_adc(_payload) (*(int16_t*)(_payload+6))
#define DL_GYRO_RATES_roll(_payload) (*(float*)(_payload+8))
#define DL_GYRO_RATES_pitch(_payload) (*(float*)(_payload+12))
#define DL_GYRO_RATES_yaw(_payload) (*(float*)(_payload+16))

#define DL_GRZ_MEASURE_roll_dot(_payload) (*(float*)(_payload+2))
#define DL_GRZ_MEASURE_pitch_dot(_payload) (*(float*)(_payload+6))
#define DL_GRZ_MEASURE_yaw_dot(_payload) (*(float*)(_payload+10))
#define DL_GRZ_MEASURE_roll(_payload) (*(float*)(_payload+14))
#define DL_GRZ_MEASURE_pitch(_payload) (*(float*)(_payload+18))
#define DL_GRZ_MEASURE_yaw(_payload) (*(float*)(_payload+22))

#define DL_GRZ_RATE_LOOP_roll_dot_meas(_payload) (*(float*)(_payload+2))
#define DL_GRZ_RATE_LOOP_roll_dot_sp(_payload) (*(float*)(_payload+6))
#define DL_GRZ_RATE_LOOP_pitch_dot_meas(_payload) (*(float*)(_payload+10))
#define DL_GRZ_RATE_LOOP_pitch_dot_sp(_payload) (*(float*)(_payload+14))
#define DL_GRZ_RATE_LOOP_yaw_dot_meas(_payload) (*(float*)(_payload+18))
#define DL_GRZ_RATE_LOOP_yaw_dot_sp(_payload) (*(float*)(_payload+22))

#define DL_GRZ_ATTITUDE_LOOP_roll_meas(_payload) (*(float*)(_payload+2))
#define DL_GRZ_ATTITUDE_LOOP_roll_sp(_payload) (*(float*)(_payload+6))
#define DL_GRZ_ATTITUDE_LOOP_pitch_meas(_payload) (*(float*)(_payload+10))
#define DL_GRZ_ATTITUDE_LOOP_pitch_sp(_payload) (*(float*)(_payload+14))
#define DL_GRZ_ATTITUDE_LOOP_yaw_meas(_payload) (*(float*)(_payload+18))
#define DL_GRZ_ATTITUDE_LOOP_yaw_sp(_payload) (*(float*)(_payload+22))

#define DL_SPEED_LOOP_ve_set_point(_payload) (*(float*)(_payload+2))
#define DL_SPEED_LOOP_ve(_payload) (*(float*)(_payload+6))
#define DL_SPEED_LOOP_vn_set_point(_payload) (*(float*)(_payload+10))
#define DL_SPEED_LOOP_vn(_payload) (*(float*)(_payload+14))
#define DL_SPEED_LOOP_north_sp(_payload) (*(float*)(_payload+18))
#define DL_SPEED_LOOP_east_sp(_payload) (*(float*)(_payload+22))

#define DL_ALT_KALMAN_p00(_payload) (*(float*)(_payload+2))
#define DL_ALT_KALMAN_p01(_payload) (*(float*)(_payload+6))
#define DL_ALT_KALMAN_p10(_payload) (*(float*)(_payload+10))
#define DL_ALT_KALMAN_p11(_payload) (*(float*)(_payload+14))

#define DL_ESTIMATOR_z(_payload) (*(float*)(_payload+2))
#define DL_ESTIMATOR_z_dot(_payload) (*(float*)(_payload+6))
#define DL_ESTIMATOR_range(_payload) (*(float*)(_payload+10))
#define DL_ESTIMATOR_range_dot(_payload) (*(float*)(_payload+14))
#define DL_ESTIMATOR_range_ave(_payload) (*(float*)(_payload+18))

#define DL_PPM_values_length(_payload) (*(uint8_t*)(_payload+2))
#define DL_PPM_values(_payload) (uint16_t*)(_payload+3)

#define DL_RC_values_length(_payload) (*(uint8_t*)(_payload+2))
#define DL_RC_values(_payload) (int16_t*)(_payload+3)

#define DL_COMMANDS_values_length(_payload) (*(uint8_t*)(_payload+2))
#define DL_COMMANDS_values(_payload) (int16_t*)(_payload+3)

#define DL_FBW_STATUS_rc_status(_payload) (*(uint8_t*)(_payload+2))
#define DL_FBW_STATUS_mode(_payload) (*(uint8_t*)(_payload+3))
#define DL_FBW_STATUS_vsupply(_payload) (*(uint8_t*)(_payload+4))

#define DL_ADC_mcu(_payload) (*(uint8_t*)(_payload+2))
#define DL_ADC_values_length(_payload) (*(uint8_t*)(_payload+3))
#define DL_ADC_values(_payload) (uint16_t*)(_payload+4)

#define DL_ACTUATORS_values_length(_payload) (*(uint8_t*)(_payload+2))
#define DL_ACTUATORS_values(_payload) (uint16_t*)(_payload+3)

#define DL_DEBUG16_xxx(_payload) (*(uint16_t*)(_payload+2))

#define DL_IMU_GYRO_gx(_payload) (*(float*)(_payload+2))
#define DL_IMU_GYRO_gy(_payload) (*(float*)(_payload+6))
#define DL_IMU_GYRO_gz(_payload) (*(float*)(_payload+10))

#define DL_IMU_MAG_ax(_payload) (*(int16_t*)(_payload+2))
#define DL_IMU_MAG_ay(_payload) (*(int16_t*)(_payload+4))
#define DL_IMU_MAG_az(_payload) (*(int16_t*)(_payload+6))

#define DL_IMU_ACCEL_ax(_payload) (*(float*)(_payload+2))
#define DL_IMU_ACCEL_ay(_payload) (*(float*)(_payload+6))
#define DL_IMU_ACCEL_az(_payload) (*(float*)(_payload+10))

#define DL_AHRS_STATE_q0(_payload) (*(float*)(_payload+2))
#define DL_AHRS_STATE_q1(_payload) (*(float*)(_payload+6))
#define DL_AHRS_STATE_q2(_payload) (*(float*)(_payload+10))
#define DL_AHRS_STATE_q3(_payload) (*(float*)(_payload+14))
#define DL_AHRS_STATE_bx(_payload) (*(float*)(_payload+18))
#define DL_AHRS_STATE_by(_payload) (*(float*)(_payload+22))
#define DL_AHRS_STATE_bz(_payload) (*(float*)(_payload+26))

#define DL_AHRS_COV_p00(_payload) (*(float*)(_payload+2))
#define DL_AHRS_COV_p11(_payload) (*(float*)(_payload+6))

#define DL_TIME_t(_payload) (*(uint32_t*)(_payload+2))


#define DL_ANTENNA_DEBUG_mag_xraw(_payload) (*(int32_t*)(_payload+2))
#define DL_ANTENNA_DEBUG_mag_yraw(_payload) (*(int32_t*)(_payload+6))
#define DL_ANTENNA_DEBUG_mag_xcal(_payload) (*(float*)(_payload+10))
#define DL_ANTENNA_DEBUG_mag_ycal(_payload) (*(float*)(_payload+14))
#define DL_ANTENNA_DEBUG_mag_heading(_payload) (*(float*)(_payload+18))
#define DL_ANTENNA_DEBUG_mag_magnitude(_payload) (*(float*)(_payload+22))
#define DL_ANTENNA_DEBUG_mag_temp(_payload) (*(float*)(_payload+26))
#define DL_ANTENNA_DEBUG_mag_distor(_payload) (*(uint8_t*)(_payload+30))
#define DL_ANTENNA_DEBUG_mag_cal_status(_payload) (*(uint8_t*)(_payload+31))

#define DL_ANTENNA_STATUS_azim_sp(_payload) (*(float*)(_payload+2))
#define DL_ANTENNA_STATUS_elev_sp(_payload) (*(float*)(_payload+6))
#define DL_ANTENNA_STATUS_id_sp(_payload) (*(uint8_t*)(_payload+10))
#define DL_ANTENNA_STATUS_mode(_payload) (*(uint8_t*)(_payload+11))

#define DL_MOTOR_BENCH_STATUS_time_ticks(_payload) (*(uint32_t*)(_payload+2))
#define DL_MOTOR_BENCH_STATUS_time_s(_payload) (*(uint16_t*)(_payload+6))
#define DL_MOTOR_BENCH_STATUS_throttle(_payload) (*(uint16_t*)(_payload+8))
#define DL_MOTOR_BENCH_STATUS_mode(_payload) (*(uint8_t*)(_payload+10))

#define DL_SERVO_elev(_payload) (*(int16_t*)(_payload+2))
#define DL_SERVO_ailer(_payload) (*(int16_t*)(_payload+4))
#define DL_SERVO_thrust(_payload) (*(int16_t*)(_payload+6))

#define DL_IR_DEBUG_ir1(_payload) (*(int16_t*)(_payload+2))
#define DL_IR_DEBUG_ir2(_payload) (*(int16_t*)(_payload+4))
#define DL_IR_DEBUG_ir3(_payload) (*(int16_t*)(_payload+6))
#define DL_IR_DEBUG_ir4(_payload) (*(int16_t*)(_payload+8))

#define DL_ACCEL_RATES_ax_adc(_payload) (*(int16_t*)(_payload+2))
#define DL_ACCEL_RATES_ay_adc(_payload) (*(int16_t*)(_payload+4))
#define DL_ACCEL_RATES_az_adc(_payload) (*(int16_t*)(_payload+6))
#define DL_ACCEL_RATES_ax(_payload) (*(float*)(_payload+8))
#define DL_ACCEL_RATES_ay(_payload) (*(float*)(_payload+12))
#define DL_ACCEL_RATES_az(_payload) (*(float*)(_payload+16))
#define DL_ACCEL_RATES_axfil(_payload) (*(float*)(_payload+20))
#define DL_ACCEL_RATES_ayfil(_payload) (*(float*)(_payload+24))
#define DL_ACCEL_RATES_azfil(_payload) (*(float*)(_payload+28))

#define DL_KALMAN_ROLL_PITCH_roll(_payload) (*(float*)(_payload+2))
#define DL_KALMAN_ROLL_PITCH_pitch(_payload) (*(float*)(_payload+6))
#define DL_KALMAN_ROLL_PITCH_KALMAN_Q_ANGLE(_payload) (*(float*)(_payload+10))
#define DL_KALMAN_ROLL_PITCH_KALMAN_Q_GYRO(_payload) (*(float*)(_payload+14))
#define DL_KALMAN_ROLL_PITCH_KALMAN_R_ANGLE(_payload) (*(float*)(_payload+18))
