/*
 * $Id: i2c_hw.c,v 1.5 2008/08/22 16:21:55 poine Exp $
 *  
 * Copyright (C) 2008  Pascal Brisset, Antoine Drouin
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

#include "i2c.h"


#include "led.h"

#include "std.h"

#include "interrupt_hw.h"

/* default clock speed 37.5KHz with our 15MHz PCLK */
#ifndef I2C0_SCLL
#define I2C0_SCLL 200
#endif

#ifndef I2C0_SCLH
#define I2C0_SCLH 200
#endif

#ifndef I2C0_VIC_SLOT
#define I2C0_VIC_SLOT 9
#endif

void i2c0_ISR(void) __attribute__((naked));


/* SDA0 on P0.3 */
/* SCL0 on P0.2 */
void i2c0_hw_init ( void ) {

  /* set P0.2 and P0.3 to I2C0 */
  PINSEL0 |= 1 << 4 | 1 << 6;
  /* clear all flags */
  I2C0CONCLR = _BV(AAC) | _BV(SIC) | _BV(STAC) | _BV(I2ENC);
  /* enable I2C */
  I2C0CONSET = _BV(I2EN);
  /* set bitrate */
  I2C0SCLL = I2C0_SCLL;  
  I2C0SCLH = I2C0_SCLH;  
  
  // initialize the interrupt vector
  VICIntSelect &= ~VIC_BIT(VIC_I2C0);              // I2C0 selected as IRQ
  VICIntEnable = VIC_BIT(VIC_I2C0);                // I2C0 interrupt enabled
  _VIC_CNTL(I2C0_VIC_SLOT) = VIC_ENABLE | VIC_I2C0;
  _VIC_ADDR(I2C0_VIC_SLOT) = (uint32_t)i2c0_ISR;    // address of the ISR
}

#define I2C_DATA_REG I2C0DAT
#define I2C_STATUS_REG I2C0STAT

void i2c0_ISR(void)
{
  ISR_ENTRY();

  uint32_t state = I2C_STATUS_REG;
  I2cAutomaton(state);
  I2cClearIT();
  
  VICVectAddr = 0x00000000;             // clear this interrupt from the VIC
  ISR_EXIT();                           // recover registers and return
}

#ifdef USE_I2C1

#define I2C1_DATA_REG   I2C1DAT
#define I2C1_STATUS_REG I2C1STAT

void i2c1_ISR(void) __attribute__((naked));

/* SDA1 on P0.14 */
/* SCL1 on P0.11 */
void i2c1_hw_init ( void ) {

  /* set P0.11 and P0.14 to I2C1 */
  PINSEL0 |= 3 << 22 | 3 << 28;
  /* clear all flags */
  I2C1CONCLR = _BV(AAC) | _BV(SIC) | _BV(STAC) | _BV(I2ENC);
  /* enable I2C */
  I2C1CONSET = _BV(I2EN);
  /* set bitrate */
  I2C1SCLL = I2C1_SCLL;  
  I2C1SCLH = I2C1_SCLH;  
  
  // initialize the interrupt vector
  VICIntSelect &= ~VIC_BIT(VIC_I2C1);              // I2C0 selected as IRQ
  VICIntEnable = VIC_BIT(VIC_I2C1);                // I2C0 interrupt enabled
  _VIC_CNTL(I2C1_VIC_SLOT) = VIC_ENABLE | VIC_I2C1;
  _VIC_ADDR(I2C1_VIC_SLOT) = (uint32_t)i2c1_ISR;    // address of the ISR
}

void i2c1_ISR(void)
{
  ISR_ENTRY();

  uint32_t state = I2C1_STATUS_REG;
  I2c1Automaton(state);
  I2c1ClearIT();
  
  VICVectAddr = 0x00000000;             // clear this interrupt from the VIC
  ISR_EXIT();                           // recover registers and return
}


#endif /* USE_I2C1 */

