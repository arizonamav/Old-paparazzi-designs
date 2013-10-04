//Header file for use with the VN100 AHRS sensor
//Methods used are relevant to the VN100 sensor
//Refer to Vector Nav VN100 fuctions at www.vectornav.com


#ifndef VN100_H
#define VN100_H

#include "std.h" 

/* VN-100 Registers */
#define     VN100_REG_MODEL     1
#define     VN100_REG_HWREV     2
#define     VN100_REG_SN        3
#define     VN100_REG_FWVER     4
#define     VN100_REG_SBAUD     5
#define     VN100_REG_ADOR      6
#define     VN100_REG_ADOF      7
#define     VN100_REG_YPR       8
#define     VN100_REG_QTN       9
#define     VN100_REG_QTM       10
#define     VN100_REG_QTA       11
#define     VN100_REG_QTR       12
#define     VN100_REG_QMA       13
#define     VN100_REG_QAR       14
#define     VN100_REG_QMR       15
#define     VN100_REG_DCM       16
#define     VN100_REG_MAG       17
#define     VN100_REG_ACC       18
#define     VN100_REG_GYR       19
#define     VN100_REG_MAR       20
#define     VN100_REG_REF       21
#define     VN100_REG_SIG       22
#define     VN100_REG_HSI       23
#define     VN100_REG_ATP       24
#define     VN100_REG_ACT       25
#define     VN100_REG_RFR       26
#define     VN100_REG_YMR       27
#define     VN100_REG_ACG       28
  
#define     VN100_REG_RAW         251
#define     VN100_REG_CMV       252
#define     VN100_REG_STV         253
#define     VN100_REG_COV       254
#define     VN100_REG_CAL         255

/* SPI Buffer size */
#define     VN100_SPI_BUFFER_SIZE    93



/* Convert 4 bytes to a 32-bit word in the order given with b1 as the most significant byte*/
#define VN_BYTES2WORD(b1, b2, b3, b4) (((unsigned long)(b1) << 24) | ((unsigned long)(b2) << 16) | ((unsigned long)(b3) << 8) | (unsigned long)(b4))

/* Bit mask to get the 1st byte (most significant) out of a 32-bit word */
#define VN_BYTE1(word)    ((unsigned char)(((word) & 0xFF000000) >> 24))

/* Bit mask to get the 2nd byte out of a 32-bit word */
#define VN_BYTE2(word)    ((unsigned char)(((word) & 0x00FF0000) >> 16))

/* Bit mask to get the 3rd byte (most significant) out of a 32-bit word */
#define VN_BYTE3(word)    ((unsigned char)(((word) & 0x0000FF00) >> 8))

/* Bit mask to get the 1st byte (least significant) out of a 32-bit word */
#define VN_BYTE4(word)    ((unsigned char)((word) & 0x000000FF))

/* Bit mask to get the nth byte out of a 32-bit word where n=0 is most significant and n=3 is least significant */
#define VN_BYTE(word, n)   ((unsigned char)((word & (0x000000FF << (n*8))) >> (n*8)))



/* Variables */
extern uint8_t vn100_status;
extern float Roll, Pitch, Yaw;


/* Command IDs */
typedef enum VN100_CmdID
{
	VN100_CmdID_ReadRegister = 0x01,
	VN100_CmdID_WriteRegister = 0x02,
	VN100_CmdID_WriteSettings = 0x03,
	VN100_CmdID_RestoreFactorySettings = 0x04,
	VN100_CmdID_Tare = 0x05,
	VN100_CmdID_Reset = 0x06,

} VN100_CmdID;



/* The SPI response packet is a data structure that is used to organize the SPI response data packets. 
Each time a command is sent to the VN-100 and a response is received, it is placed in a response packet 
structure. This allows for easy access to the various components of the response packet. */

/* 32-bit Parameter Type */
typedef union {
	unsigned long UInt;
	float Float;
} VN100_Param;

/* SPI Response Packet */
typedef struct {
	unsigned char ZeroByte;
	unsigned char CmdID;
	unsigned char RegID;
	unsigned char ErrID;
	VN100_Param Data[VN100_SPI_BUFFER_SIZE];
} VN100_SPI_Packet;

/*The first four bytes of the packet are accessible via the CmdID, RegID, and ErrID members of the above structure. 
The actual data that is passed back to the user from the VN-100 will either take the form of a 32-bit unsigned 
integer or a 32-bit floating point number. */


/* Externally Defined Functions */
extern void vn100_init( void );
extern void vn100_periodic( void );
extern void vnSetSS(int x);
extern unsigned long vnSendReceive(unsigned long data);
extern void vnDelay(unsigned long delay_uS);

extern VN100_SPI_Packet* vnReadRegister(unsigned char regID,unsigned char regWidth);
extern VN100_SPI_Packet* vnGetAnglesDD(float* yaw, float* pitch, float* roll);



#endif /*VN100_H*/
