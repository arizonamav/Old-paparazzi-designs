/*
 * $Id: aerocomm.c,v 1.0 2008/1/19 05:13:40 rkrash Exp $
 *  
 * Copyright (C) 2008 Roman Krashanitsa
 *
 * This file is part of paparazzi.
 *
 * paparazzi is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * paparazzi is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with paparazzi; see the file COPYING.  If not, write to
 * the Free Software Foundation, 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA. 
 *
 */

#include "sys_time.h"
#include "print.h"
#include "aerocomm.h"

#ifdef SIM_UART
#include "sim_uart.h"
#endif

uint8_t aerocomm_cs;
uint8_t aerocomm_payload[AEROCOMM_PAYLOAD_LEN];
volatile bool_t aerocomm_msg_received;
volatile bool_t aerocomm_confirmation_received=TRUE;
volatile bool_t aerocomm_confirmation_status=TRUE;
volatile uint8_t aerocomm_payload_len=0;
uint8_t aerocomm_rssi;
uint8_t aerocomm_ovrn, aerocomm_error;


#define AT_COMMAND_SEQUENCE "AT+++\r"
#define AT_INIT_PERIOD_US 2000000
#define AT_SET_MY "\xCC\xC1\x80\x06\x00\x50\x67\x00  "
#define AT_AP_MODE "\xCC\xC1\xC1\x01\x0F"
#define AT_RESET "\xCC\xFF"
#define AT_EXIT "\xCC\x41\x54\x4F\r"


void aerocomm_init( void ) {

aerocomm_confirmation_received=TRUE;
{  uint8_t init_cpt = 30;
  while (init_cpt) {
    if (sys_time_periodic())
      init_cpt--;
  }
}

#ifdef NO_API_INIT
#warning "NO_API_INIT defined"
#else
#warning "NO_API_INIT not defined"
#endif

#ifndef NO_API_INIT
  /** Switching to AT mode (FIXME: busy waiting) */
  AerocommPrintString(AT_COMMAND_SEQUENCE);

  /** Setting my address */
  uint16_t addr = AEROCOMM_MY_ADDR;
  char s[]=AT_SET_MY;
  s[8]=(unsigned int)(addr>> 8);
  s[9]=(unsigned int)(addr & 0xff);
  for (int i=0; i<10; i++)  AerocommTransportPut1Byte(s[i]);
  
  AerocommPrintString(AT_RESET);
  {  uint8_t init_cpt = 30;
     while (init_cpt) {
     if (sys_time_periodic())
        init_cpt--;
     }
   }

  AerocommPrintString(AT_COMMAND_SEQUENCE);
  AerocommPrintString(AT_AP_MODE);
  /** Switching back to normal mode */
  AerocommPrintString(AT_EXIT);
#endif
}
