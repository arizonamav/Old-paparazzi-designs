/* This file has been generated from /home/dragonfly/paparazzi_new/test/paparazzi3/conf/airframes/microjet7.xml */
/* Please DO NOT EDIT */

#ifndef AIRFRAME_H
#define AIRFRAME_H 

#define AIRFRAME_NAME "MJ7"
#define AC_ID 7

#define SERVOS_NB 7

#define SERVO_GAZ 0
#define SERVO_GAZ_NEUTRAL 1000
#define SERVO_GAZ_TRAVEL_UP 0.104166666667
#define SERVO_GAZ_TRAVEL_DOWN 0
#define SERVO_GAZ_MAX 2000
#define SERVO_GAZ_MIN 1000

#define SERVO_AILEVON_LEFT 6
#define SERVO_AILEVON_LEFT_NEUTRAL 1480
#define SERVO_AILEVON_LEFT_TRAVEL_UP 0.0567708333333
#define SERVO_AILEVON_LEFT_TRAVEL_DOWN 0.0421875
#define SERVO_AILEVON_LEFT_MAX 2025
#define SERVO_AILEVON_LEFT_MIN 1075

#define SERVO_AILEVON_RIGHT 3
#define SERVO_AILEVON_RIGHT_NEUTRAL 1515
#define SERVO_AILEVON_RIGHT_TRAVEL_UP -0.05625
#define SERVO_AILEVON_RIGHT_TRAVEL_DOWN -0.0479166666667
#define SERVO_AILEVON_RIGHT_MAX 1975
#define SERVO_AILEVON_RIGHT_MIN 975

#define SERVO_HATCH 2
#define SERVO_HATCH_NEUTRAL 1000
#define SERVO_HATCH_TRAVEL_UP 0.104166666667
#define SERVO_HATCH_TRAVEL_DOWN 0
#define SERVO_HATCH_MAX 2000
#define SERVO_HATCH_MIN 1000


#define COMMAND_THROTTLE 0
#define COMMAND_ROLL 1
#define COMMAND_PITCH 2
#define COMMAND_HATCH 3
#define COMMANDS_NB 4
#define COMMANDS_FAILSAFE {0,0,0,0}


#define SetCommandsFromRC(commands) { \
  commands[COMMAND_THROTTLE] = rc_values[RADIO_THROTTLE];\
  commands[COMMAND_ROLL] = rc_values[RADIO_ROLL];\
  commands[COMMAND_PITCH] = rc_values[RADIO_PITCH];\
  commands[COMMAND_HATCH] = rc_values[RADIO_GAIN1];\
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
  command_value = values[COMMAND_HATCH];\
  command_value *= command_value>0 ? SERVO_HATCH_TRAVEL_UP : SERVO_HATCH_TRAVEL_DOWN;\
  servo_value = SERVO_HATCH_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_HATCH] = ChopServo(servo_value, SERVO_HATCH_MIN, SERVO_HATCH_MAX);\
\
  Actuator(SERVO_HATCH) = SERVOS_TICS_OF_USEC(actuators[SERVO_HATCH]);\
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
#define ADC_CHANNEL_GYRO_ROLL ADC_4
#define ADC_CHANNEL_GYRO_TEMP ADC_5
#define ADC_CHANNEL_GYRO_NB_SAMPLES 16

#define SECTION_INFRARED 1
#define IR_ROLL_NEUTRAL_DEFAULT 0
#define IR_PITCH_NEUTRAL_DEFAULT 10
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
#define IR_CORRECTION_UP 1.
#define IR_CORRECTION_DOWN 1.
#define IR_CORRECTION_LEFT 1.
#define IR_CORRECTION_RIGHT 1.
#define IR_ESTIMATED_PHI_PI_4 0.9
#define IR_360_LATERAL_CORRECTION 1.
#define IR_360_LONGITUDINAL_CORRECTION 1.
#define IR_360_VERTICAL_CORRECTION 1.

#define SECTION_GYRO 1
#define GYRO_ADC_ROLL_NEUTRAL 500
#define GYRO_ADC_TEMP_NEUTRAL 476
#define GYRO_ADC_TEMP_SLOPE 0
#define GYRO_ROLL_SCALE 0.44
#define GYRO_ROLL_DIRECTION 1.

#define SECTION_BAT 1
#define MILLIAMP_PER_PERCENT 0.86
#define ADC_CHANNEL_VSUPPLY AdcBank1(6)
#define VoltageOfAdc(adc) (0.01787109375*adc)
#define LOW_BATTERY 9.3

#define SECTION_MISC 1
#define NOMINAL_AIRSPEED 12.
#define CARROT 5.
#define KILL_MODE_DISTANCE (1.5*MAX_DIST_FROM_HOME)
#define CONTROL_RATE 60
#define XBEE_INIT "ATPL2\rATRN1\rATTT80\r"
#define ALT_KALMAN_ENABLED TRUE
#define TRIGGER_DELAY 1.
#define DEFAULT_CIRCLE_RADIUS 80.
#define MIN_CIRCLE_RADIUS 50.

#define SECTION_VERTICAL CONTROL 1
#define V_CTL_POWER_CTL_BAT_NOMINAL 11.1
#define V_CTL_ALTITUDE_PGAIN -0.03
#define V_CTL_ALTITUDE_MAX_CLIMB 2.
#define V_CTL_AUTO_THROTTLE_NOMINAL_CRUISE_THROTTLE 0.35
#define V_CTL_AUTO_THROTTLE_MIN_CRUISE_THROTTLE 0.30
#define V_CTL_AUTO_THROTTLE_MAX_CRUISE_THROTTLE 0.80
#define V_CTL_AUTO_THROTTLE_LOITER_TRIM 1500
#define V_CTL_AUTO_THROTTLE_DASH_TRIM -1000
#define V_CTL_AUTO_THROTTLE_CLIMB_THROTTLE_INCREMENT 0.15
#define V_CTL_AUTO_THROTTLE_PGAIN -0.01
#define V_CTL_AUTO_THROTTLE_IGAIN 0.1
#define V_CTL_AUTO_THROTTLE_PITCH_OF_VZ_PGAIN 0.05
#define V_CTL_AUTO_PITCH_PGAIN -0.05
#define V_CTL_AUTO_PITCH_IGAIN 0.075
#define V_CTL_AUTO_PITCH_MAX_PITCH 0.35
#define V_CTL_AUTO_PITCH_MIN_PITCH -0.35
#define V_CTL_THROTTLE_SLEW 0.05

#define SECTION_HORIZONTAL CONTROL 1
#define H_CTL_COURSE_PGAIN -0.8
#define H_CTL_ROLL_MAX_SETPOINT 0.6
#define H_CTL_PITCH_MAX_SETPOINT 0.5
#define H_CTL_PITCH_MIN_SETPOINT -0.5
#define H_CTL_ROLL_PGAIN 5000.
#define H_CTL_AILERON_OF_THROTTLE 0.0
#define H_CTL_PITCH_PGAIN -9000.
#define H_CTL_PITCH_DGAIN 1.5
#define H_CTL_ELEVATOR_OF_ROLL 1250
#define H_CTL_ROLL_RATE_MODE_DEFAULT 1
#define H_CTL_ROLL_RATE_SETPOINT_PGAIN -5.
#define H_CTL_ROLL_RATE_MAX_SETPOINT 10
#define H_CTL_LO_THROTTLE_ROLL_RATE_PGAIN 1000.
#define H_CTL_HI_THROTTLE_ROLL_RATE_PGAIN 1000.
#define H_CTL_ROLL_RATE_IGAIN 0.
#define H_CTL_ROLL_RATE_DGAIN 0.
#define H_CTL_ROLL_RATE_SUM_NB_SAMPLES 64

#define SECTION_NAV 1
#define NAV_PITCH 0.
#define NAV_GLIDE_PITCH_TRIM 0

#define SECTION_AGGRESSIVE 1
#define AGR_BLEND_START 20
#define AGR_BLEND_END 10
#define AGR_CLIMB_THROTTLE 0.8
#define AGR_CLIMB_PITCH 0.3
#define AGR_DESCENT_THROTTLE 0.1
#define AGR_DESCENT_PITCH -0.25
#define AGR_CLIMB_NAV_RATIO 0.8
#define AGR_DESCENT_NAV_RATIO 1.0

#define SECTION_GYRO_GAINS 1
#define GYRO_MAX_RATE 200.
#define ROLLRATESUM_NB_SAMPLES 64
#define ALT_ROLL__PGAIN 1.0
#define ROLL_RATE_PGAIN 1000.0
#define ROLL_RATE_IGAIN 0.0
#define ROLL_RATE_DGAIN 0.0

#define SECTION_FAILSAFE 1
#define FAILSAFE_DELAY_WITHOUT_GPS 1
#define FAILSAFE_DEFAULT_THROTTLE 0.3
#define FAILSAFE_DEFAULT_ROLL 0.3
#define FAILSAFE_DEFAULT_PITCH 0.5
#define FAILSAFE_HOME_RADIUS 100

#define SECTION_DATALINK 1
#define DATALINK_DEVICE_TYPE XBEE
#define DATALINK_DEVICE_ADDRESS ....

#define SECTION_SIMU 1
#define YAW_RESPONSE_FACTOR 0.5


#endif // AIRFRAME_H