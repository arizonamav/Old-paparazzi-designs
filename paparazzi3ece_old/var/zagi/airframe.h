/* This file has been generated from /home/paparazzi/paparazzi3new/conf/airframes/zagi_arm.xml */
/* Please DO NOT EDIT */

#ifndef AIRFRAME_H
#define AIRFRAME_H 

#define AIRFRAME_NAME "zagi"
#define AC_ID 44

#define SERVOS_NB 4

#define SERVO_ELEVON1 0
#define SERVO_ELEVON1_NEUTRAL 1500
#define SERVO_ELEVON1_TRAVEL_UP 0.0520833333333
#define SERVO_ELEVON1_TRAVEL_DOWN 0.0520833333333
#define SERVO_ELEVON1_MAX 2000
#define SERVO_ELEVON1_MIN 1000

#define SERVO_ELEVON2 1
#define SERVO_ELEVON2_NEUTRAL 1500
#define SERVO_ELEVON2_TRAVEL_UP 0.0520833333333
#define SERVO_ELEVON2_TRAVEL_DOWN 0.0520833333333
#define SERVO_ELEVON2_MAX 2000
#define SERVO_ELEVON2_MIN 1000

#define SERVO_THR 3
#define SERVO_THR_NEUTRAL 1000
#define SERVO_THR_TRAVEL_UP 0.104166666667
#define SERVO_THR_TRAVEL_DOWN 0
#define SERVO_THR_MAX 2000
#define SERVO_THR_MIN 1000


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

#define SetActuatorsFromCommands(values) { \
  uint16_t servo_value;\
  float command_value;\
  command_value = values[COMMAND_THROTTLE];\
  command_value *= command_value>0 ? SERVO_THR_TRAVEL_UP : SERVO_THR_TRAVEL_DOWN;\
  servo_value = SERVO_THR_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_THR] = ChopServo(servo_value, SERVO_THR_MIN, SERVO_THR_MAX);\
\
  Actuator(SERVO_THR) = SERVOS_TICS_OF_USEC(actuators[SERVO_THR]);\
\
  command_value = -values[COMMAND_PITCH]+values[COMMAND_ROLL];\
  command_value *= command_value>0 ? SERVO_ELEVON1_TRAVEL_UP : SERVO_ELEVON1_TRAVEL_DOWN;\
  servo_value = SERVO_ELEVON1_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_ELEVON1] = ChopServo(servo_value, SERVO_ELEVON1_MIN, SERVO_ELEVON1_MAX);\
\
  Actuator(SERVO_ELEVON1) = SERVOS_TICS_OF_USEC(actuators[SERVO_ELEVON1]);\
\
  command_value = +values[COMMAND_PITCH]+values[COMMAND_ROLL];\
  command_value *= command_value>0 ? SERVO_ELEVON2_TRAVEL_UP : SERVO_ELEVON2_TRAVEL_DOWN;\
  servo_value = SERVO_ELEVON2_NEUTRAL + (int16_t)(command_value);\
  actuators[SERVO_ELEVON2] = ChopServo(servo_value, SERVO_ELEVON2_MIN, SERVO_ELEVON2_MAX);\
\
  Actuator(SERVO_ELEVON2) = SERVOS_TICS_OF_USEC(actuators[SERVO_ELEVON2]);\
\
  ActuatorsCommit();\
}
#define SECTION_adc 1
#define ADC_CHANNEL_IR1 ADC_3
#define ADC_CHANNEL_IR2 ADC_4
#define ADC_CHANNEL_IR_NB_SAMPLES 16

#define SECTION_AUTO1 1
#define AUTO1_MAX_ROLL RadOfDeg(45)
#define AUTO1_MAX_PITCH RadOfDeg(15)

#define SECTION_INFRARED 1
#define IR_ROLL_NEUTRAL_DEFAULT DegOfRad(0.)
#define IR_PITCH_NEUTRAL_DEFAULT 0
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
#define GYRO_ADC_ROLL_NEUTRAL 426
#define GYRO_ADC_PITCH_NEUTRAL 535
#define GYRO_ROLL_SCALE 0.5
#define GYRO_ROLL_DIRECTION -1
#define GYRO_PITCH_SCALE 0.5
#define GYRO_PITCH_DIRECTION 1.

#define SECTION_ACCEL 1
#define ACCEL_AX_NEUTRAL 528
#define ACCEL_AY_NEUTRAL 516
#define ACCEL_AZ_NEUTRAL 509
#define ACCEL_AX_SCALE 0.01
#define ACCEL_AY_SCALE 0.01
#define ACCEL_AZ_SCALE 0.01

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
#define V_CTL_ALTITUDE_PGAIN 0.25
#define V_CTL_ALTITUDE_MAX_CLIMB 2.
#define V_CTL_AUTO_THROTTLE_MIN_CRUISE_THROTTLE 0.35
#define V_CTL_AUTO_THROTTLE_MAX_CRUISE_THROTTLE 0.7
#define V_CTL_AUTO_THROTTLE_PGAIN 0.037
#define V_CTL_AUTO_THROTTLE_IGAIN 0.001
#define V_CTL_AUTO_THROTTLE_PITCH_OF_VZ_PGAIN 0.0
#define V_CTL_AUTO_THROTTLE_DASH_TRIM 1000
#define V_CTL_AUTO_THROTTLE_LOITER_TRIM 1500
#define V_CTL_AUTO_THROTTLE_CRUISE_THROTTLE 0.55
#define V_CTL_AUTO_THROTTLE_CRUISE_THROTTLE_PGAIN 0.005
#define V_CTL_AUTO_THROTTLE_NOMINAL_CRUISE_THROTTLE 0.55
#define V_CTL_AUTO_THROTTLE_CLIMB_THROTTLE_INCREMENT 0.051
#define V_CTL_THROTTLE_SUM_NB_SAMPLES 32
#define V_CTL_AUTO_PITCH_PGAIN 0.1
#define V_CTL_AUTO_PITCH_IGAIN 0.0
#define V_CTL_AUTO_PITCH_MAX_PITCH 0.35
#define V_CTL_AUTO_PITCH_MIN_PITCH -0.35
#define V_CTL_VDROP2THROTTLE 0
#define V_CTL_THROTTLE_SLEW 1.0

#define SECTION_HORIZONTAL CONTROL 1
#define H_CTL_COURSE_PGAIN 0.25
#define H_CTL_ROLL_MAX_SETPOINT RadOfDeg(40)
#define H_CTL_PITCH_MAX_SETPOINT RadOfDeg(20)
#define H_CTL_PITCH_MIN_SETPOINT RadOfDeg(-10)
#define H_CTL_YAW_MAX_SETPOINT RadOfDeg(30)
#define H_CTL_ROLL_PGAIN -12000.
#define H_CTL_AILERON_OF_THROTTLE 0.0
#define H_CTL_PITCH_PGAIN 11950.
#define H_CTL_PITCH_DGAIN 0.0
#define H_CTL_ELEVATOR_OF_ROLL 1000.
#define H_CTL_ROLL_RATE_MODE_DEFAULT 1
#define H_CTL_PITCH_RATE_MODE_DEFAULT 1
#define H_CTL_YAW_RATE_MODE_DEFAULT 1
#define H_CTL_ROLL_RATE_SETPOINT_PGAIN 0.75
#define H_CTL_ROLL_RATE_MAX_SETPOINT 10
#define H_CTL_PITCH_RATE_SETPOINT_PGAIN 0.75
#define H_CTL_PITCH_RATE_MAX_SETPOINT 10
#define H_CTL_YAW_RATE_SETPOINT_PGAIN 0.75
#define H_CTL_YAW_RATE_MAX_SETPOINT 10
#define H_CTL_LO_THROTTLE_ROLL_RATE_PGAIN 3000.0
#define H_CTL_HI_THROTTLE_ROLL_RATE_PGAIN 3000.0
#define H_CTL_LO_THROTTLE_PITCH_RATE_PGAIN 9000.0
#define H_CTL_HI_THROTTLE_PITCH_RATE_PGAIN 9000.0
#define H_CTL_LO_THROTTLE_YAW_RATE_PGAIN 0
#define H_CTL_HI_THROTTLE_YAW_RATE_PGAIN 0
#define H_CTL_ROLL_RATE_IGAIN 0.
#define H_CTL_ROLL_RATE_DGAIN 0.
#define H_CTL_ROLL_RATE_SUM_NB_SAMPLES 16
#define H_CTL_PITCH_RATE_IGAIN 0.
#define H_CTL_PITCH_RATE_DGAIN 0.
#define H_CTL_PITCH_RATE_SUM_NB_SAMPLES 16
#define H_CTL_YAW_RATE_IGAIN 0.
#define H_CTL_YAW_RATE_DGAIN 0.
#define H_CTL_YAW_RATE_SUM_NB_SAMPLES 16

#define SECTION_THR 1
#define DASH_THR 0.6
#define LOITER_THR 0.52

#define SECTION_NAV 1
#define NAV_PITCH 0.
#define NAV_GLIDE_PITCH_TRIM 0

#define SECTION_AGGRESSIVE 1
#define AGR_BLEND_START 10
#define AGR_BLEND_END 3
#define AGR_CLIMB_THROTTLE 0.70
#define AGR_CLIMB_PITCH 0.0
#define AGR_DESCENT_THROTTLE 0.40
#define AGR_DESCENT_PITCH 0.0
#define AGR_CLIMB_NAV_RATIO 0.8
#define AGR_DESCENT_NAV_RATIO 1.0

#define SECTION_FAILSAFE 1
#define FAILSAFE_DEFAULT_THROTTLE 0.2
#define FAILSAFE_DEFAULT_ROLL 0.3
#define FAILSAFE_DEFAULT_PITCH 0.1
#define FAILSAFE_HOME_RADIUS 50

#define SECTION_SIMU 1
#define ROLL_RESPONSE_FACTOR 2.
#define YAW_RESPONSE_FACTOR 1.35
#define WEIGHT 1.3

#define SECTION_MISC 1
#define NOMINAL_AIRSPEED 10.
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