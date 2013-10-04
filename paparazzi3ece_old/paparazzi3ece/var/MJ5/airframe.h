/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/airframes/microjet5.xml */
/* Please DO NOT EDIT */

#ifndef AIRFRAME_H
#define AIRFRAME_H 

#define AIRFRAME_NAME "MJ5"
#define AC_ID 5

#define SERVOS_NB 3

#define SERVO_GAZ 0
#define SERVO_GAZ_NEUTRAL 1000
#define SERVO_GAZ_TRAVEL_UP 0.104166666667
#define SERVO_GAZ_TRAVEL_DOWN 0
#define SERVO_GAZ_MAX 2000
#define SERVO_GAZ_MIN 1000

#define SERVO_AILEVON_LEFT 1
#define SERVO_AILEVON_LEFT_NEUTRAL 1520
#define SERVO_AILEVON_LEFT_TRAVEL_UP -0.0385416666667
#define SERVO_AILEVON_LEFT_TRAVEL_DOWN -0.0447916666667
#define SERVO_AILEVON_LEFT_MAX 1950
#define SERVO_AILEVON_LEFT_MIN 1150

#define SERVO_AILEVON_RIGHT 2
#define SERVO_AILEVON_RIGHT_NEUTRAL 1460
#define SERVO_AILEVON_RIGHT_TRAVEL_UP 0.0458333333333
#define SERVO_AILEVON_RIGHT_TRAVEL_DOWN 0.0427083333333
#define SERVO_AILEVON_RIGHT_MAX 1900
#define SERVO_AILEVON_RIGHT_MIN 1050


#define COMMAND_THROTTLE 0
#define COMMAND_ROLL 1
#define COMMAND_PITCH 2
#define COMMANDS_NB 3
#define COMMANDS_FAILSAFE {0,0,0}


#define SetCommandsFromRC(commands) { \
  commands[COMMAND_THROTTLE] = rc_values[RADIO_THROTTLE];\
  commands[COMMAND_ROLL] = rc_values[RADIO_ROLL];\
  commands[COMMAND_PITCH] = rc_values[RADIO_PITCH];\
}

#define SECTION_MIXER 1
#define AILEVON_AILERON_RATE 0.3
#define AILEVON_ELEVATOR_RATE 0.7

#define SetActuatorsFromCommands(values) { \
  uint16_t servo_value;\
  float command_value;\
  int16_t _var_aileron = values[COMMAND_ROLL]  * AILEVON_AILERON_RATE;\
  int16_t _var_elevator = values[COMMAND_PITCH] * AILEVON_ELEVATOR_RATE;\
  command_value = values[COMMAND_THROTTLE];\
  command_value *= command_value>0 ? SERVO_GAZ_TRAVEL_UP : SERVO_GAZ_TRAVEL_DOWN;\
  servo_value = SERVO_GAZ_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_GAZ] = ChopServo(servo_value, SERVO_GAZ_MIN, SERVO_GAZ_MAX);\
\
  Actuator(SERVO_GAZ) = SERVOS_TICS_OF_USEC(actuators[SERVO_GAZ]);\
\
  command_value = _var_elevator + _var_aileron;\
  command_value *= command_value>0 ? SERVO_AILEVON_LEFT_TRAVEL_UP : SERVO_AILEVON_LEFT_TRAVEL_DOWN;\
  servo_value = SERVO_AILEVON_LEFT_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_AILEVON_LEFT] = ChopServo(servo_value, SERVO_AILEVON_LEFT_MIN, SERVO_AILEVON_LEFT_MAX);\
\
  Actuator(SERVO_AILEVON_LEFT) = SERVOS_TICS_OF_USEC(actuators[SERVO_AILEVON_LEFT]);\
\
  command_value = _var_elevator - _var_aileron;\
  command_value *= command_value>0 ? SERVO_AILEVON_RIGHT_TRAVEL_UP : SERVO_AILEVON_RIGHT_TRAVEL_DOWN;\
  servo_value = SERVO_AILEVON_RIGHT_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_AILEVON_RIGHT] = ChopServo(servo_value, SERVO_AILEVON_RIGHT_MIN, SERVO_AILEVON_RIGHT_MAX);\
\
  Actuator(SERVO_AILEVON_RIGHT) = SERVOS_TICS_OF_USEC(actuators[SERVO_AILEVON_RIGHT]);\
\
  ActuatorsCommit();\
}
#define SECTION_AUTO1 1
#define AUTO1_MAX_ROLL 0.6
#define AUTO1_MAX_PITCH 0.6

#define SECTION_adc 1
#define ADC_CHANNEL_IR1 ADC_0
#define ADC_CHANNEL_IR2 ADC_1
#define ADC_CHANNEL_IR_TOP ADC_6
#define ADC_CHANNEL_IR_NB_SAMPLES 16
#define ADC_CHANNEL_VSUPPLY ADC_3
#define ADC_CHANNEL_GYRO_ROLL ADC_4
#define ADC_CHANNEL_GYRO_TEMP ADC_5
#define ADC_CHANNEL_GYRO_NB_SAMPLES 16

#define SECTION_INFRARED 1
#define IR_ROLL_NEUTRAL_DEFAULT 6
#define IR_PITCH_NEUTRAL_DEFAULT 9
#define IR_DEFAULT_CONTRAST 200
#define IR_RAD_OF_IR_CONTRAST 0.75
#define IR_RollOfIrs(x1,x2) (-0.7*(x1)+ 0.7*(x2))
#define IR_PitchOfIrs(x1,x2) (-0.7*(x1)+ -0.7*(x2))
#define IR_TopOfIr(x1) (1*(x1))
#define IR_RAD_OF_IR_MAX_VALUE 0.0045
#define IR_RAD_OF_IR_MIN_VALUE 0.00075
#define IR_ADC_ROLL_NEUTRAL 0
#define IR_ADC_PITCH_NEUTRAL -716
#define IR_ADC_TOP_NEUTRAL 512
#define IR_ESTIMATED_PHI_PI_4 M_PI_4

#define SECTION_GYRO 1
#define GYRO_ADC_ROLL_COEF 1
#define GYRO_ADC_ROLL_NEUTRAL 500
#define GYRO_ADC_TEMP_NEUTRAL 476
#define GYRO_ADC_TEMP_SLOPE 0
#define GYRO_ROLL_SCALE 0.44
#define GYRO_ROLL_DIRECTION 1

#define SECTION_BAT 1
#define MILLIAMP_PER_PERCENT 0.86
#define VOLTAGE_ADC_A 0.0177531
#define VOLTAGE_ADC_B 0.173626
#define VoltageOfAdc(adc) (VOLTAGE_ADC_A * adc + VOLTAGE_ADC_B)
#define LOW_BATTERY 9.3

#define SECTION_MISC 1
#define NOMINAL_AIRSPEED 12.
#define CARROT 5.
#define KILL_MODE_DISTANCE (1.5*MAX_DIST_FROM_HOME)
#define CONTROL_RATE 60

#define SECTION_PID 1
#define ROLL_PGAIN 5000.
#define PITCH_OF_ROLL 0.25
#define PITCH_PGAIN 10000.
#define MAX_ROLL 0.35
#define MAX_PITCH 0.35
#define MIN_PITCH -0.35
#define AILERON_OF_GAZ 0.0
#define CRUISE_THROTTLE 0.35

#define SECTION_ALT 1
#define CLIMB_PITCH_PGAIN -0.05
#define CLIMB_PITCH_IGAIN 0.075
#define CLIMB_PGAIN -0.01
#define CLIMB_IGAIN 0.1
#define CLIMB_MAX 1.
#define CLIMB_PITCH_OF_VZ_PGAIN 0.05
#define CLIMB_GAZ_OF_CLIMB 0.15

#define SECTION_NAV 1
#define COURSE_PGAIN -0.4
#define ALTITUDE_PGAIN -0.03
#define NAV_PITCH 0.

#define SECTION_AGGRESSIVE 1
#define AGR_CLIMB_GAZ 0.95
#define AGR_DESCENT_GAZ 0.1
#define AGR_CLIMB_PITCH 0.3
#define AGR_DESCENT_PITCH -0.25
#define AGR_BLEND_START 20
#define AGR_BLEND_END 10
#define AGR_CLIMB_NAV_RATIO 0.8
#define AGR_DESCENT_NAV_RATIO 1.0

#define SECTION_GYRO_GAINS 1
#define GYRO_MAX_RATE 200.
#define ROLLRATESUM_NB_SAMPLES 60
#define ALT_ROLL_PGAIN 120.0
#define ROLL_RATE_PGAIN 85.0
#define ROLL_RATE_IGAIN 0.0
#define ROLL_RATE_DGAIN 0.0

#define SECTION_FAILSAFE 1
#define FAILSAFE_DELAY_WITHOUT_GPS 1
#define FAILSAFE_DEFAULT_GAZ 0.3
#define FAILSAFE_DEFAULT_ROLL 0.3
#define FAILSAFE_DEFAULT_PITCH 0.5
#define FAILSAFE_HOME_RADIUS 100


#endif // AIRFRAME_H
