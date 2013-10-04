/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/airframes/d3.xml */
/* Please DO NOT EDIT */

#ifndef AIRFRAME_H
#define AIRFRAME_H 

#define AIRFRAME_NAME "d3"
#define AC_ID 38

#define SERVOS_NB 6

#define SERVO_ELEVATOR 0
#define SERVO_ELEVATOR_NEUTRAL 1500
#define SERVO_ELEVATOR_TRAVEL_UP 0.0520833333333
#define SERVO_ELEVATOR_TRAVEL_DOWN 0.0520833333333
#define SERVO_ELEVATOR_MAX 2000
#define SERVO_ELEVATOR_MIN 1000

#define SERVO_AILERON 1
#define SERVO_AILERON_NEUTRAL 1500
#define SERVO_AILERON_TRAVEL_UP 0.0520833333333
#define SERVO_AILERON_TRAVEL_DOWN 0.0520833333333
#define SERVO_AILERON_MAX 2000
#define SERVO_AILERON_MIN 1000

#define SERVO_GAZ 3
#define SERVO_GAZ_NEUTRAL 1200
#define SERVO_GAZ_TRAVEL_UP 0.0833333333333
#define SERVO_GAZ_TRAVEL_DOWN 0.0104166666667
#define SERVO_GAZ_MAX 2000
#define SERVO_GAZ_MIN 1100

#define SERVO_CAM_ROLL 5
#define SERVO_CAM_ROLL_NEUTRAL 1550
#define SERVO_CAM_ROLL_TRAVEL_UP 0.0364583333333
#define SERVO_CAM_ROLL_TRAVEL_DOWN 0.0364583333333
#define SERVO_CAM_ROLL_MAX 1900
#define SERVO_CAM_ROLL_MIN 1200


#define COMMAND_THROTTLE 0
#define COMMAND_ROLL 1
#define COMMAND_PITCH 2
#define COMMAND_CAM_ROLL 3
#define COMMAND_CAM_PITCH 4
#define COMMAND_PAYPLOAD 5
#define COMMANDS_NB 6
#define COMMANDS_FAILSAFE {0,0,0,0,0,0}


#define SetCommandsFromRC(commands) { \
  commands[COMMAND_THROTTLE] = rc_values[RADIO_THROTTLE];\
  commands[COMMAND_ROLL] = rc_values[RADIO_ROLL];\
  commands[COMMAND_PITCH] = rc_values[RADIO_PITCH];\
}

#define SECTION_MIXER 1
#define AILEVON_AILERON_RATE 0.8
#define AILEVON_ELEVATOR_RATE 0.8
#define ROLL_TGAIN 0.005
#define PITCH_TGAIN -0.0

#define SetActuatorsFromCommands(values) { \
  uint16_t servo_value;\
  float command_value;\
  command_value = values[COMMAND_THROTTLE];\
  command_value *= command_value>0 ? SERVO_GAZ_TRAVEL_UP : SERVO_GAZ_TRAVEL_DOWN;\
  servo_value = SERVO_GAZ_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_GAZ] = ChopServo(servo_value, SERVO_GAZ_MIN, SERVO_GAZ_MAX);\
\
  Actuator(SERVO_GAZ) = SERVOS_TICS_OF_USEC(actuators[SERVO_GAZ]);\
\
  int16_t _var_roll = values[COMMAND_ROLL];\
  int16_t _var_rollofthr = values[COMMAND_THROTTLE] * ROLL_TGAIN;\
  int16_t _var_pitch = values[COMMAND_PITCH];\
  int16_t _var_pitchofthr = values[COMMAND_THROTTLE] * PITCH_TGAIN;\
  command_value = _var_pitch + _var_pitchofthr;\
  command_value *= command_value>0 ? SERVO_ELEVATOR_TRAVEL_UP : SERVO_ELEVATOR_TRAVEL_DOWN;\
  servo_value = SERVO_ELEVATOR_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_ELEVATOR] = ChopServo(servo_value, SERVO_ELEVATOR_MIN, SERVO_ELEVATOR_MAX);\
\
  Actuator(SERVO_ELEVATOR) = SERVOS_TICS_OF_USEC(actuators[SERVO_ELEVATOR]);\
\
  command_value = _var_roll + _var_rollofthr;\
  command_value *= command_value>0 ? SERVO_AILERON_TRAVEL_UP : SERVO_AILERON_TRAVEL_DOWN;\
  servo_value = SERVO_AILERON_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_AILERON] = ChopServo(servo_value, SERVO_AILERON_MIN, SERVO_AILERON_MAX);\
\
  Actuator(SERVO_AILERON) = SERVOS_TICS_OF_USEC(actuators[SERVO_AILERON]);\
\
  command_value = values[COMMAND_CAM_ROLL];\
  command_value *= command_value>0 ? SERVO_CAM_ROLL_TRAVEL_UP : SERVO_CAM_ROLL_TRAVEL_DOWN;\
  servo_value = SERVO_CAM_ROLL_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_CAM_ROLL] = ChopServo(servo_value, SERVO_CAM_ROLL_MIN, SERVO_CAM_ROLL_MAX);\
\
  Actuator(SERVO_CAM_ROLL) = SERVOS_TICS_OF_USEC(actuators[SERVO_CAM_ROLL]);\
\
  ActuatorsCommit();\
}
#define SECTION_AUTO1 1
#define AUTO1_MAX_ROLL 0.96
#define AUTO1_MAX_PITCH 0.8

#define SECTION_adc 1
#define ADC_CHANNEL_IR1 ADC_1
#define ADC_CHANNEL_IR2 ADC_0
#define ADC_CHANNEL_IR_NB_SAMPLES 16

#define SECTION_INFRARED 1
#define IR_ROLL_NEUTRAL_DEFAULT 0
#define IR_PITCH_NEUTRAL_DEFAULT 75.0
#define IR_DEFAULT_CONTRAST 900
#define IR_RAD_OF_IR_CONTRAST 1.0
#define IR_RollOfIrs(x1,x2) (0.7*(x1)+ -0.7*(x2))
#define IR_PitchOfIrs(x1,x2) (0.7*(x1)+ 0.7*(x2))
#define IR_RAD_OF_IR_MAX_VALUE 0.0045
#define IR_RAD_OF_IR_MIN_VALUE 0.00075
#define IR_ADC_ROLL_NEUTRAL 0
#define IR_ADC_PITCH_NEUTRAL 0
#define IR_ESTIMATED_PHI_PI_4 M_PI_4

#define SECTION_BAT 1
#define MILLIAMP_PER_PERCENT 0.86
#define ADC_CHANNEL_VSUPPLY AdcBank1(6)
#define VoltageOfAdc(adc) (0.01787109375*adc)
#define LOW_BATTERY 9.3

#define SECTION_VERTICAL CONTROL 1
#define V_CTL_ALTITUDE_PGAIN -0.065
#define V_CTL_ALTITUDE_MAX_CLIMB 2.
#define V_CTL_AUTO_THROTTLE_PGAIN -0.01
#define V_CTL_AUTO_THROTTLE_IGAIN 0.1
#define V_CTL_AUTO_THROTTLE_PITCH_OF_VZ_PGAIN 0.05
#define V_CTL_AUTO_THROTTLE_DASH_TRIM -1000
#define V_CTL_AUTO_THROTTLE_LOITER_TRIM 1500
#define V_CTL_AUTO_THROTTLE_CRUISE_THROTTLE 0.50
#define V_CTL_AUTO_THROTTLE_NOMINAL_CRUISE_THROTTLE 0.35
#define V_CTL_AUTO_THROTTLE_CLIMB_THROTTLE_INCREMENT 0.15
#define V_CTL_AUTO_PITCH_PGAIN -0.1
#define V_CTL_AUTO_PITCH_IGAIN 0.0
#define V_CTL_AUTO_PITCH_MAX_PITCH 0.35
#define V_CTL_AUTO_PITCH_MIN_PITCH -0.35
#define V_CTL_THROTTLE_SLEW 0.05

#define SECTION_HORIZONTAL CONTROL 1
#define H_CTL_COURSE_PGAIN 0.5
#define H_CTL_ROLL_MAX_SETPOINT 0.6
#define H_CTL_PITCH_MAX_SETPOINT 0.5
#define H_CTL_PITCH_MIN_SETPOINT -0.5
#define H_CTL_ROLL_PGAIN -12000.
#define H_CTL_AILERON_OF_THROTTLE 0.0
#define H_CTL_PITCH_PGAIN -8000.
#define H_CTL_PITCH_DGAIN 0.0
#define H_CTL_ELEVATOR_OF_ROLL 1250
#define H_CTL_ROLL_RATE_MODE_DEFAULT 1
#define H_CTL_ROLL_RATE_SETPOINT_PGAIN -5.
#define H_CTL_ROLL_RATE_MAX_SETPOINT 10
#define H_CTL_LO_THROTTLE_ROLL_RATE_PGAIN -9000.
#define H_CTL_HI_THROTTLE_ROLL_RATE_PGAIN -12000.
#define H_CTL_ROLL_RATE_IGAIN 0.
#define H_CTL_ROLL_RATE_DGAIN 0.
#define H_CTL_ROLL_RATE_SUM_NB_SAMPLES 64

#define SECTION_THR 1
#define DASH_THR 1.0
#define LOITER_THR 0.50

#define SECTION_NAV 1
#define NAV_PITCH 0.
#define NAV_GLIDE_PITCH_TRIM 0

#define SECTION_AGGRESSIVE 1
#define AGR_BLEND_START 20
#define AGR_BLEND_END 10
#define AGR_CLIMB_THROTTLE 0.95
#define AGR_CLIMB_PITCH 0.3
#define AGR_DESCENT_THROTTLE 0.1
#define AGR_DESCENT_PITCH -0.25
#define AGR_CLIMB_NAV_RATIO 0.8
#define AGR_DESCENT_NAV_RATIO 1.0

#define SECTION_FAILSAFE 1
#define FAILSAFE_DELAY_WITHOUT_GPS 1
#define FAILSAFE_DEFAULT_THROTTLE 0.0
#define FAILSAFE_DEFAULT_ROLL 0.6
#define FAILSAFE_DEFAULT_PITCH 0.5
#define FAILSAFE_HOME_RADIUS 100

#define SECTION_SIMU 1
#define ROLL_RESPONSE_FACTOR 2.
#define YAW_RESPONSE_FACTOR 1.35
#define WEIGHT 1.3

#define SECTION_MISC 1
#define NOMINAL_AIRSPEED 10.
#define CARROT 5.
#define KILL_MODE_DISTANCE (MAX_DIST_FROM_HOME*1.5)
#define XBEE_INIT "ATPL4\rATRN1\rATTT80\rATBD3\rATWR\r"
#define NO_XBEE_API_INIT TRUE

#define SECTION_DATALINK 1
#define DATALINK_DEVICE_TYPE XBEE
#define DATALINK_DEVICE_ADDRESS ....


#endif // AIRFRAME_H