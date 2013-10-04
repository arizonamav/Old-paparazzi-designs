#include <string.h>   /*to be able to use the memcpy function*/

#include CONFIG
#include "i2c.h"
#include "enose.h"

#define ENOSE_SLAVE_ADDR_W 0xAE		/*Sensor slave address with write bit inclusion*/
#define ENOSE_SLAVE_ADDR_R 0xAF		/*Sensor slave address with read bit inclusion*/
#define ENOSE_HEATER_VALUE 0xED		/*PWx=237 - Corresponds to heater voltage a 5V - (for control experiments - PWx=128)*/
#define ENOSE_HEATER_ADDR 0x06		/*n=6*/
#define ENOSE_SENSOR_ADDR 0x00		/*n=0*/

uint8_t enose_heating_setting[ENOSE_SENSOR_NUM];	/*relates to heaters on chemo-sensor*/
uint16_t enose_sensor_data[ENOSE_SENSOR_NUM];	/*relates to sensors on chemo-senor*/
/*uint16_t MSB1, LSB1, MSB2, LSB2, MSB3, LSB3;*/
uint8_t enose_status; /*Sets the status of the chemical sensor (idle, writing, reading)*/
float Gnostim1=0.000081;
float Gnostim2=0.00115;
float Gnostim3=0.00045;
float Gstim1, Gstim2, Gstim3;
float FCG1, FCG2, FCG3;

static volatile bool_t enose_i2c_completed;
/*We need to set the initial values before sending out information to the sensor*/
void enose_init( void ) {	
	uint8_t i;
	for (i=0; i<ENOSE_SENSOR_NUM; i++) {
		enose_heating_setting[i]=ENOSE_HEATER_VALUE; /*Initializes the heater values*/
		enose_sensor_data[i]=0; /*Initializes the sensor data values*/
	}
	enose_status = ENOSE_IDLE; 
	enose_i2c_completed = TRUE; /*Sends an aknowledgement to the chemical sensor*/
}
void enose_periodic( void ) {
	if (enose_status == ENOSE_IDLE) {
		const uint8_t msg[] = { ENOSE_HEATER_ADDR, enose_heating_setting[0], enose_heating_setting[1], enose_heating_setting[2] }; 
		memcpy((void*)i2c_buf, msg, sizeof(msg)); /*Send the heating values to the i2c buffer*/
		i2c_transmit(ENOSE_SLAVE_ADDR_W, sizeof(msg), &enose_i2c_completed); /*Transmits heating values to heater address on enose sensor*/
		enose_status = ENOSE_HEATSET;
		return;
	}
	if (enose_status == ENOSE_HEATSET) {
		const uint8_t msg[]= { ENOSE_SENSOR_ADDR };
		memcpy((void*)i2c_buf, msg, sizeof(msg));
		i2c_transmit(ENOSE_SLAVE_ADDR_W, sizeof(msg), &enose_i2c_completed); /*Sets sensor address on enose sensor*/
		enose_status = ENOSE_WRITING;
		return;
	}
	if (enose_status == ENOSE_WRITING) {
		i2c_receive(ENOSE_SLAVE_ADDR_W, 6, &enose_i2c_completed); /*Requests data from 3 sensors to be stored on buffer*/
		enose_status = ENOSE_READING;
		return;
	}
	if (enose_status == ENOSE_READING) {
		/*Data coming from sensor is in 8bit mode. Full data is 16bit. 6, 8bit pieces of data to be converted to 3, 16 bit sensor data.*/
/*		MSB1=i2c_buf[0];
		LSB1=i2c_buf[1];
		uint16_t sensor1 = (MSB1<<8) | LSB1;  
		enose_sensor_data[0] = sensor1;

		MSB2=i2c_buf[2];
		LSB2=i2c_buf[3];
		uint16_t sensor2 = (MSB2<<8) | LSB2;  
		enose_sensor_data[1] = sensor2;		

		MSB3=i2c_buf[4];
		LSB3=i2c_buf[5];
		uint16_t sensor3 = (MSB3<<8) | LSB3;  
		enose_sensor_data[2] = sensor3;
*/
		FCG1=0.;
		FCG2=0.;
		FCG3=0.;
		uint16_t sensor1 = (i2c_buf[0]<<8) | i2c_buf[1];  
		enose_sensor_data[0] = sensor1;
		Gstim1=1/(float)sensor1;
		FCG1=(Gstim1-Gnostim1)/Gnostim1;
		uint16_t sensor2 = (i2c_buf[2]<<8) | i2c_buf[3];  
		enose_sensor_data[1] = sensor2;
		Gstim2=1/(float)sensor2;
		FCG2=(Gstim2-Gnostim2)/Gnostim2;
		uint16_t sensor3 = (i2c_buf[4]<<8) | i2c_buf[5];  
		enose_sensor_data[2] = sensor3;
		Gstim3=1/(float)sensor3;
		FCG3=(Gstim3-Gnostim3)/Gnostim3;		
		enose_status = ENOSE_HEATSET;
		return;
	}
}
