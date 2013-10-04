#include <string.h>   /*to be able to use the memcpy function*/

#include CONFIG
#include "spi.h"
#include "ap_vn100.h"


/////////////////////////////////////////////////////////////////////////////////////
/* Both the read and write register SPI routines below use this packet 
   to store the returned SPI response. None of the write register commands 
   implemented in this library check the data that is returned by the sensor 
   to ensure that it is consistent with the data that was sent.  For normal
   cases this isn't necessary however if you wish to implement your own
   checking then this is the structure that you need to check after each 
   register set command.  The structure has the following form:
   VN_SPI_LastReceivedPacket.CmdID -> This is the ID for the command that
                                   the response is for
   VN_SPI_LastReceivedPacket.RegID -> This is the ID for the register that
                                   the response is for
   VN_SPI_LastReceivedPacket.Data[] -> This is the data that was returned by
                                    the sensor as an array of unsigned 32-bit
                                    integers  */

VN100_SPI_Packet VN_SPI_LastReceivedPacket = {0, 0, 0, 0, {0}};

///////////////////////////////////////////////////////////////////////////////////////

float Roll, Pitch, Yaw;

void vn100_init( void ) {	
	
}

void vnSetSS(int x){
	if(x == 0){
		/* Start SPI Transaction - Pull SPI CS line low */
		SpiEnable();
	}
	else{
		/* End SPI transaction - Pull SPI CS line high */
		SpiDisable();
	}
}

unsigned long vnSendReceive(unsigned long data){
	/* User code to send out 4 bytes over SPI */

	unsigned long i;
	unsigned long ret = 0;

	for(i=0;i<4;i++){
		/* Initialize SPI Buffer */
		/* Use these variables to set data that will be passed uint8_t* spi_buffer_input; uint8_t* spi_buffer_output; uint8_t spi_buffer_length; */
		
		
		SpiInitBuf();

		/* Send SPI1 requests */
		SpiTransmit();

		/* Save received data in buffer */
		SpiReceive();

		/* Wait for SPI1 Tx buffer empty */
		//while (SPI_I2S_GetFlagStatus(SPI1, SPI_I2S_FLAG_TXE) == RESET);TNF

		/* Send SPI1 requests */
		//SPI_I2S_SendData(SPI1, VN_BYTE(data, i));

		/* Wait for response from VN-100 */
		//while (SPI_I2S_GetFlagStatus(SPI1, SPI_I2S_FLAG_RXNE) == RESET);RNE

		/* Save received data in buffer */
		//ret |= ((unsigned long)SPI_I2S_ReceiveData(SPI1) << (8*i));

		


	}
	return ret;
}

void vnDelay(unsigned long delay_uS){
	unsigned long i;
	for(i=delay_uS*10; i--; );
}



/*Function vnReadRegister Returns a pointer to the spi packet.*/
VN100_SPI_Packet* vnReadRegister(unsigned char regID, unsigned char regWidth){

	/* Pull SS line low to start transaction*/
	vnSetSS(0);

	/* Send request */
	vnSendReceive(VN_BYTES2WORD(0, 0, regID, VN100_CmdID_ReadRegister));
	vnSendReceive(0);

	/* Pull SS line high to end SPI transaction */
	vnSetSS(1);

	/* Delay for 50us */
	vnDelay(50);		

	/* Pull SS line low to start SPI transaction */
	vnSetSS(0);

	/* Get response over SPI */
	for(int i=0;i<=regWidth;i++){
	*(((unsigned long*)&VN_SPI_LastReceivedPacket) + i) = vnSendReceive(0);
	}

	/* Pull SS line high to end SPI transaction */ 
	vnSetSS(1);

	/* Return Error code */
	return &VN_SPI_LastReceivedPacket;  
}

/* Gets angular data in Decimal Degrees */
VN100_SPI_Packet* vnGetAnglesDD(float* yaw, float* pitch, float* roll){

  /* Read register */
  vnReadRegister(VN100_REG_YPR, 3);
  
  /* Get Yaw, Pitch, Roll */
  *yaw   = VN_SPI_LastReceivedPacket.Data[0].Float;
  *pitch = VN_SPI_LastReceivedPacket.Data[1].Float;
  *roll  = VN_SPI_LastReceivedPacket.Data[2].Float;
  

  return &VN_SPI_LastReceivedPacket;
}

void vn100_periodic( void ) {
	Roll = 1.5;
	Pitch = 2.5;
	Yaw = 3.4;
	
	float* yaw;
	float* pitch;
	float* roll;	

	/* Pointer test case: */
	//float fp = 33.33;
	//yaw = &fp;
	//pitch = &fp;
	//roll =&fp;	
	
	/* Uncomment when not testing pointer */
	vnGetAnglesDD(yaw, pitch, roll);
	
	Roll = *roll;
	Pitch = *pitch;
	Yaw = *yaw;

}

