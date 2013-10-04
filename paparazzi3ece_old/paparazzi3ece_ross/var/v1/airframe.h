/* This file has been generated from /home/mav/Desktop/paparazzi3new/conf/airframes/vertigo_arm_ir_ac_paint.xml */
/* Please DO NOT EDIT */

#ifndef AIRFRAME_H
#define AIRFRAME_H 

#define AIRFRAME_NAME "v1"
#define AC_ID 34

#define SERVOS_NB 6

#define SERVO_AILERON1 0
#define SERVO_AILERON1_NEUTRAL 1500
#define SERVO_AILERON1_TRAVEL_UP 0.0520833333333
#define SERVO_AILERON1_TRAVEL_DOWN 0.0520833333333
#define SERVO_AILERON1_MAX 2000
#define SERVO_AILERON1_MIN 1000

#define SERVO_AILERON2 1
#define SERVO_AILERON2_NEUTRAL 1500
#define SERVO_AILERON2_TRAVEL_UP 0.0520833333333
#define SERVO_AILERON2_TRAVEL_DOWN 0.0520833333333
#define SERVO_AILERON2_MAX 2000
#define SERVO_AILERON2_MIN 1000

#define SERVO_THROTTLE 3
#define SERVO_THROTTLE_NEUTRAL 1200
#define SERVO_THROTTLE_TRAVEL_UP 0.0833333333333
#define SERVO_THROTTLE_TRAVEL_DOWN 0.0104166666667
#define SERVO_THROTTLE_MAX 2000
#define SERVO_THROTTLE_MIN 1100

#define SERVO_RUDDER 4
#define SERVO_RUDDER_NEUTRAL 1500
#define SERVO_RUDDER_TRAVEL_UP 0.0520833333333
#define SERVO_RUDDER_TRAVEL_DOWN 0.0520833333333
#define SERVO_RUDDER_MAX 2000
#define SERVO_RUDDER_MIN 1000

#define SERVO_CAM_PITCH 5
#define SERVO_CAM_PITCH_NEUTRAL 1500
#define SERVO_CAM_PITCH_TRAVEL_UP -0.0520833333333
#define SERVO_CAM_PITCH_TRAVEL_DOWN -0.0520833333333
#define SERVO_CAM_PITCH_MAX 2000
#define SERVO_CAM_PITCH_MIN 1000


#define COMMAND_THROTTLE 0
#define COMMAND_ROLL 1
#define COMMAND_PITCH 2
#define COMMAND_YAW 3
#define COMMAND_CAM_PITCH 4
#define COMMANDS_NB 5
#define COMMANDS_FAILSAFE {0,0,0,0,0}


#define SetCommandsFromRC(commands) { \
  commands[COMMAND_THROTTLE] = rc_values[RADIO_THROTTLE];\
  commands[COMMAND_ROLL] = rc_values[RADIO_ROLL];\
  commands[COMMAND_PITCH] = rc_values[RADIO_PITCH];\
  commands[COMMAND_YAW] = rc_values[RADIO_YAW];\
  commands[COMMAND_CAM_PITCH] = rc_values[RADIO_CAM_PITCH];\
}

#define SECTION_MIXER 1
#define AILEVON_AILERON_RATE 0.8
#define AILEVON_ELEVATOR_RATE 0.8
#define ROLL_TGAIN 0.005
#define PITCH_TGAIN -0.0

#define SetActuatorsFromCommands(values) { \
  uint16_t servo_value;\
  float command_value;\
  command_value = values[COMMAND_THROTTLE]-(vsupply-110.0f)*vdrop2throt_coeff;\
  command_value *= command_value>0 ? SERVO_THROTTLE_TRAVEL_UP : SERVO_THROTTLE_TRAVEL_DOWN;\
  servo_value = SERVO_THROTTLE_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_THROTTLE] = ChopServo(servo_value, SERVO_THROTTLE_MIN, SERVO_THROTTLE_MAX);\
\
  Actuator(SERVO_THROTTLE) = SERVOS_TICS_OF_USEC(actuators[SERVO_THROTTLE]);\
\
  int16_t _var_roll = values[COMMAND_ROLL];\
  int16_t _var_rollofthr = values[COMMAND_THROTTLE] * ROLL_TGAIN;\
  int16_t _var_pitch = values[COMMAND_PITCH];\
  int16_t _var_pitchofthr = values[COMMAND_THROTTLE] * PITCH_TGAIN;\
  command_value = _var_roll+_var_pitch;\
  command_value *= command_value>0 ? SERVO_AILERON1_TRAVEL_UP : SERVO_AILERON1_TRAVEL_DOWN;\
  servo_value = SERVO_AILERON1_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_AILERON1] = ChopServo(servo_value, SERVO_AILERON1_MIN, SERVO_AILERON1_MAX);\
\
  Actuator(SERVO_AILERON1) = SERVOS_TICS_OF_USEC(actuators[SERVO_AILERON1]);\
\
  command_value = _var_roll-_var_pitch;\
  command_value *= command_value>0 ? SERVO_AILERON2_TRAVEL_UP : SERVO_AILERON2_TRAVEL_DOWN;\
  servo_value = SERVO_AILERON2_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_AILERON2] = ChopServo(servo_value, SERVO_AILERON2_MIN, SERVO_AILERON2_MAX);\
\
  Actuator(SERVO_AILERON2) = SERVOS_TICS_OF_USEC(actuators[SERVO_AILERON2]);\
\
  int16_t _var_yaw = values[COMMAND_YAW];\
  command_value = +_var_yaw+0.0*_var_roll;\
  command_value *= command_value>0 ? SERVO_RUDDER_TRAVEL_UP : SERVO_RUDDER_TRAVEL_DOWN;\
  servo_value = SERVO_RUDDER_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_RUDDER] = ChopServo(servo_value, SERVO_RUDDER_MIN, SERVO_RUDDER_MAX);\
\
  Actuator(SERVO_RUDDER) = SERVOS_TICS_OF_USEC(actuators[SERVO_RUDDER]);\
\
  command_value = values[COMMAND_CAM_PITCH];\
  command_value *= command_value>0 ? SERVO_CAM_PITCH_TRAVEL_UP : SERVO_CAM_PITCH_TRAVEL_DOWN;\
  servo_value = SERVO_CAM_PITCH_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_CAM_PITCH] = ChopServo(servo_value, SERVO_CAM_PITCH_MIN, SERVO_CAM_PITCH_MAX);\
\
  Actuator(SERVO_CAM_PITCH) = SERVOS_TICS_OF_USEC(actuators[SERVO_CAM_PITCH]);\
\
  ActuatorsCommit();\
}
#define SECTION_adc 1
#define ADC_CHANNEL_GYRO_ROLL ADC_0
#define ADC_CHANNEL_GYRO_PITCH ADC_1
#define ADC_CHANNEL_GYRO_YAW ADC_2
#define ADC_CHANNEL_GYRO_NB_SAMPLES 16
#define ADC_CHANNEL_IR1 ADC_3
#define ADC_CHANNEL_IR2 ADC_4
#define ADC_CHANNEL_IR_NB_SAMPLES 16

#define SECTION_AUTO1 1
#define AUTO1_MAX_ROLL RadOfDeg(30)
#define AUTO1_MAX_PITCH RadOfDeg(90)
#define AUTO1_MAX_YAW RadOfDeg(30)

#define SECTION_INFRARED 1
#define IR_ROLL_NEUTRAL_DEFAULT 0
#define IR_PITCH_NEUTRAL_DEFAULT -57
#define IR_DEFAULT_CONTRAST 900
#define IR_RAD_OF_IR_CONTRAST 1.9
#define IR_RollOfIrs(x1,x2) (0.7*(x1)+ -0.7*(x2))
#define IR_PitchOfIrs(x1,x2) (-0.7*(x1)+ -0.7*(x2))
#define IR_RAD_OF_IR_MAX_VALUE 0.0045
#define IR_RAD_OF_IR_MIN_VALUE 0.00075
#define IR_ADC_ROLL_NEUTRAL 0
#define IR_ADC_PITCH_NEUTRAL 0
#define IR_ESTIMATED_PHI_PI_4 M_PI_4*0.6
#define IR_CORRECTION_UP 1.5
#define IR_CORRECTION_DOWN 1.5
#define IR_CORRECTION_LEFT 1.5
#define IR_CORRECTION_RIGHT 1.5

#define SECTION_GYRO 1
#define GYRO_ADC_ROLL_NEUTRAL 477
#define GYRO_ADC_PITCH_NEUTRAL 462
#define GYRO_ADC_YAW_NEUTRAL 453
#define GYRO_ROLL_SCALE 0.5
#define GYRO_ROLL_DIRECTION -1
#define GYRO_PITCH_SCALE 0.5
#define GYRO_PITCH_DIRECTION 1.
#define GYRO_YAW_SCALE 0.5
#define GYRO_YAW_DIRECTION 1.

#define SECTION_KALMAN 1
#define KALMAN_Q_ANGLE 1e-1f
#define KALMAN_Q_GYRO 5e-1f
#define KALMAN_R_ANGLE 1e-3f

#define SECTION_BAT 1
#define MILLIAMP_PER_PERCENT 0.86
#define ADC_CHANNEL_VSUPPLY AdcBank1(6)
#define VoltageOfAdc(adc) (0.01787109375*adc)
#define LOW_BATTERY 9.3

#define SECTION_VERTICAL CONTROL 1
#define V_CTL_ALTITUDE_PGAIN 0.228
#define V_CTL_ALTITUDE_MAX_CLIMB 2.
#define V_CTL_AUTO_THROTTLE_MIN_CRUISE_THROTTLE 0.38
#define V_CTL_AUTO_THROTTLE_MAX_CRUISE_THROTTLE 0.45
#define V_CTL_AUTO_THROTTLE_PGAIN 0.023
#define V_CTL_AUTO_THROTTLE_IGAIN 0.001
#define V_CTL_AUTO_THROTTLE_PITCH_OF_VZ_PGAIN 0.01
#define V_CTL_AUTO_THROTTLE_DASH_TRIM 1000
#define V_CTL_AUTO_THROTTLE_LOITER_TRIM 1500
#define V_CTL_AUTO_THROTTLE_CRUISE_THROTTLE 0.423
#define V_CTL_AUTO_THROTTLE_CRUISE_THROTTLE_PGAIN 0
#define V_CTL_AUTO_THROTTLE_NOMINAL_CRUISE_THROTTLE 0.462
#define V_CTL_AUTO_THROTTLE_CLIMB_THROTTLE_INCREMENT 0.01
#define V_CTL_THROTTLE_SUM_NB_SAMPLES 32
#define V_CTL_AUTO_PITCH_PGAIN 0.1
#define V_CTL_AUTO_PITCH_IGAIN 0.0
#define V_CTL_AUTO_PITCH_MAX_PITCH 0.35
#define V_CTL_AUTO_PITCH_MIN_PITCH -0.35
#define V_CTL_VDROP2THROTTLE 0
#define V_CTL_THROTTLE_SLEW 1.0

#define SECTION_HORIZONTAL CONTROL 1
#define H_CTL_COURSE_PGAIN 0.064
#define H_CTL_ROLL_MAX_SETPOINT RadOfDeg(10)
#define H_CTL_PITCH_MAX_SETPOINT RadOfDeg(50)
#define H_CTL_PITCH_MIN_SETPOINT RadOfDeg(-50)
#define H_CTL_YAW_MAX_SETPOINT RadOfDeg(20)
#define H_CTL_ROLL_PGAIN -12000.
#define H_CTL_AILERON_OF_THROTTLE 0.0
#define H_CTL_PITCH_PGAIN 11950.
#define H_CTL_PITCH_DGAIN 0.0
#define H_CTL_ELEVATOR_OF_ROLL 0.
#define H_CTL_ROLL_RATE_MODE_DEFAULT 1
#define H_CTL_PITCH_RATE_MODE_DEFAULT 1
#define H_CTL_YAW_RATE_MODE_DEFAULT 1
#define H_CTL_ROLL_RATE_SETPOINT_PGAIN 0.75
#define H_CTL_ROLL_RATE_MAX_SETPOINT 10
#define H_CTL_PITCH_RATE_SETPOINT_PGAIN 0.75
#define H_CTL_PITCH_RATE_MAX_SETPOINT 10
#define H_CTL_YAW_RATE_SETPOINT_PGAIN 0.75
#define H_CTL_YAW_RATE_MAX_SETPOINT 10
#define H_CTL_LO_THROTTLE_ROLL_RATE_PGAIN 28400.
#define H_CTL_HI_THROTTLE_ROLL_RATE_PGAIN 28400.
#define H_CTL_LO_THROTTLE_PITCH_RATE_PGAIN 26800.
#define H_CTL_HI_THROTTLE_PITCH_RATE_PGAIN 26800.
#define H_CTL_LO_THROTTLE_YAW_RATE_PGAIN 24600.
#define H_CTL_HI_THROTTLE_YAW_RATE_PGAIN 24600.
#define H_CTL_ROLL_RATE_IGAIN 0.
#define H_CTL_ROLL_RATE_DGAIN 0.
#define H_CTL_ROLL_RATE_SUM_NB_SAMPLES 16
#define H_CTL_PITCH_RATE_IGAIN 0.
#define H_CTL_PITCH_RATE_DGAIN 0.
#define H_CTL_PITCH_RATE_SUM_NB_SAMPLES 16
#define H_CTL_YAW_RATE_IGAIN 0.
#define H_CTL_YAW_RATE_DGAIN 0.
#define H_CTL_YAW_RATE_SUM_NB_SAMPLES 16
#define H_CTL_MID_AOA_ROLL_RATE_PGAIN 15200.
#define H_CTL_MID_AOA_PITCH_RATE_PGAIN 12700.
#define H_CTL_MID_AOA_YAW_RATE_PGAIN 9300.
#define H_CTL_MID_AOA_ELEVATOR_OF_ROLL 3200.
#define H_CTL_HI_AOA_ROLL_RATE_PGAIN 20500.
#define H_CTL_HI_AOA_PITCH_RATE_PGAIN 16400.
#define H_CTL_HI_AOA_YAW_RATE_PGAIN 17400.
#define H_CTL_HI_AOA_ELEVATOR_OF_ROLL 0.
#define H_CTL_LO_AOA_ROLL_RATE_PGAIN 11850.
#define H_CTL_LO_AOA_PITCH_RATE_PGAIN 10000.
#define H_CTL_LO_AOA_YAW_RATE_PGAIN 10000.
#define H_CTL_LO_AOA_ELEVATOR_OF_ROLL 5500.

#define SECTION_THR 1
#define DASH_THR 0.6
#define LOITER_THR 0.52

#define SECTION_NAV 1
#define NAV_PITCH 0.
#define NAV_GLIDE_PITCH_TRIM 0

#define SECTION_FAILSAFE 1
#define FAILSAFE_DELAY_WITHOUT_GPS 5
#define FAILSAFE_DEFAULT_THROTTLE 0.4
#define FAILSAFE_DEFAULT_ROLL 0.3
#define FAILSAFE_DEFAULT_PITCH 0.1
#define FAILSAFE_HOME_RADIUS 50

#define SECTION_SIMU 1
#define ROLL_RESPONSE_FACTOR 2.
#define YAW_RESPONSE_FACTOR 1.35
#define WEIGHT 1.3

#define SECTION_MISC 1
#define NOMINAL_AIRSPEED 7.
#define CARROT 5.
#define KILL_MODE_DISTANCE (MAX_DIST_FROM_HOME*1.5)
#define AEROCOMM_INIT 
#define NO_API_INIT TRUE
#define TRIGGER_DELAY 1.1
#define DEFAULT_CIRCLE_RADIUS 100.

#define SECTION_DATALINK 1
#define DATALINK_DEVICE_TYPE AEROCOMM__
#define DATALINK_DEVICE_ADDRESS ....


#endif // AIRFRAME_H
