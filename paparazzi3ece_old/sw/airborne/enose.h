#ifndef ENOSE_H
#define ENOSE_H

#include "std.h" 

#define ENOSE_SENSOR_NUM 3
#define ENOSE_IDLE 0
#define ENOSE_HEATSET 1
#define ENOSE_WRITING 2
#define ENOSE_READING 3

extern uint8_t enose_heating_setting[ENOSE_SENSOR_NUM];
extern uint16_t enose_sensor_data[ENOSE_SENSOR_NUM];
/*extern uint16_t MSB1, LSB1, MSB2, LSB2, MSB3, LSB3;*/
extern float FCG1, FCG2, FCG3;
extern uint8_t enose_status;

extern void enose_init( void );
extern void enose_periodic( void );

#endif /*ENOSE_H*/
