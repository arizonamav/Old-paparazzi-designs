/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/airframes/del2.xml */
/* Please DO NOT EDIT */

#ifndef AIRFRAME_H
#define AIRFRAME_H 

#define AIRFRAME_NAME "del2"
#define AC_ID 37

#define SERVOS_NB 4

#define SERVO_GAZ 3
#define SERVO_GAZ_NEUTRAL 1000
#define SERVO_GAZ_TRAVEL_UP 0.104166666667
#define SERVO_GAZ_TRAVEL_DOWN 0
#define SERVO_GAZ_MAX 2000
#define SERVO_GAZ_MIN 1000

#define SERVO_AILERON 1
#define SERVO_AILERON_NEUTRAL 1600
#define SERVO_AILERON_TRAVEL_UP 0.0416666666667
#define SERVO_AILERON_TRAVEL_DOWN 0.0416666666667
#define SERVO_AILERON_MAX 2000
#define SERVO_AILERON_MIN 1200

#define SERVO_ELEVATOR 0
#define SERVO_ELEVATOR_NEUTRAL 1600
#define SERVO_ELEVATOR_TRAVEL_UP 0.0416666666667
#define SERVO_ELEVATOR_TRAVEL_DOWN 0.0416666666667
#define SERVO_ELEVATOR_MAX 2000
#define SERVO_ELEVATOR_MIN 1200

#define SERVO_CAM_ROLL 2
#define SERVO_CAM_ROLL_NEUTRAL 1600
#define SERVO_CAM_ROLL_TRAVEL_UP 0.0520833333333
#define SERVO_CAM_ROLL_TRAVEL_DOWN 0.0729166666667
#define SERVO_CAM_ROLL_MAX 2100
#define SERVO_CAM_ROLL_MIN 900


#define COMMAND_THROTTLE 0
#define COMMAND_ROLL 1
#define COMMAND_PITCH 2
#define COMMAND_CAM_ROLL 3
#define COMMAND_CAM_PITCH 4
#define COMMANDS_NB 5
#define COMMANDS_FAILSAFE {0,0,0,0,0}


#define SetCommandsFromRC(commands) { \
  commands[COMMAND_THROTTLE] = rc_values[RADIO_THROTTLE];\
  commands[COMMAND_ROLL] = rc_values[RADIO_ROLL];\
  commands[COMMAND_PITCH] = rc_values[RADIO_PITCH];\
  commands[COMMAND_CAM_ROLL] = rc_values[RADIO_YAW];\
}

#define SECTION_MIXER 1
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
#define SECTION_adc 1
#define ADC_CHANNEL_IR1 1
#define ADC_CHANNEL_IR2 0
#define ADC_CHANNEL_VSUPPLY 3
#define ADC_CHANNEL_IR_NB_SAMPLES 16

#define SECTION_AUTO1 1
#define AUTO1_MAX_ROLL 0.6
#define AUTO1_MAX_PITCH 0.6

#define SECTION_INFRARED 1
#define IR_ROLL_NEUTRAL_DEFAULT 0.0
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

#define SECTION_PID 1
#define ROLL_PGAIN 6000.
#define ROLL_DGAIN -8000.
#define ROLL_IGAIN 3500.0
#define PITCH_OF_ROLL 0.6
#define PITCH_PGAIN 8000.
#define MAX_ROLL .52
#define MAX_PITCH 0.17
#define MIN_PITCH -0.085
#define AILERON_OF_GAZ 0.0
#define CAMERA_PGAIN 8000.

#define SECTION_ALT 1
#define CLIMB_PITCH_PGAIN -0.1
#define CLIMB_PITCH_IGAIN 0.0
#define CLIMB_PGAIN -0.1
#define CLIMB_IGAIN 0.0
#define CLIMB_MAX 5.
#define CLIMB_LEVEL_GAZ 0.5
#define CLIMB_PITCH_OF_VZ_PGAIN 0.05
#define CLIMB_GAZ_OF_CLIMB 0.2
#define CLIMB_MAX_DIFF_GAZ 0.05

#define SECTION_NAV 1
#define COURSE_PGAIN -0.5
#define ALTITUDE_PGAIN -0.065
#define NAV_PITCH 0.

#define SECTION_BAT 1
#define MILLIAMP_PER_PERCENT 0.86
#define VOLTAGE_ADC_A 0.0164
#define VOLTAGE_ADC_B 0.088
#define VoltageOfAdc(adc) (VOLTAGE_ADC_A * adc + VOLTAGE_ADC_B)
#define LOW_BATTERY 9.3

#define SECTION_MISC 1
#define NOMINAL_AIRSPEED 16.
#define CARROT 5.
#define KILL_MODE_DISTANCE (MAX_DIST_FROM_HOME*1.5)

#define SECTION_SIMU 1
#define ROLL_RESPONSE_FACTOR 60.
#define YAW_RESPONSE_FACTOR 0.6
#define WEIGHT 1.280

#define SECTION_FAILSAFE 1
#define FAILSAFE_DELAY_WITHOUT_GPS 2
#define FAILSAFE_DEFAULT_GAZ 0.1
#define FAILSAFE_DEFAULT_ROLL 0.3
#define FAILSAFE_DEFAULT_PITCH 0.08
#define FAILSAFE_HOME_RADIUS 50

#define SECTION_CAM 1
#define CAM_THETA0 0
#define CAM_PHI0 0


#endif // AIRFRAME_H
