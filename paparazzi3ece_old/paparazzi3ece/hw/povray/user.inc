



/********************************************************************************************************************************************
//Ceramic GPS patch antenna
********************************************************************************************************************************************/
#macro USER_GPS_PATCH_ANT_20()
union{
  object {
    box{<-10,0,-10><10,4.2,10>}      // Ceramic
    pigment{rgb(<0.400, 0.320, 0.220>)}
  }
  object {
    box{<-7.5,0,-7.5><7.5,4.21,7.5>} // Metal
    rotate<0, 2.5, 0>
    texture{col_silver}
  }
  sphere{ <-2, 3.5, -2> 1.5 texture{col_silver}}
}
#end

/********************************************************************************************************************************************
//Ceramic GPS helix antenna
********************************************************************************************************************************************/
#macro USER_GPS_HELICOIDAL_ANT()
union{
  object {
    box{<-10,0,-7><0,1.2,7>}     // PCB
    texture{pigment{DarkGreen}}
  }
  object {
    box{<-9.5,1.2,-6><1.5,3.7,6>} // shielding
    texture{col_silver}
  }
  object {
    cylinder{<1.5,0,0><21.5,0.0,0>5.75} // ceramic holder
    pigment{rgb(<0.400, 0.320, 0.220>)}
  }
  object {
    box{<-5,-1.5,-5.2><1.5,0,5.2>}         // ceramic holder
    pigment{rgb(<0.400, 0.320, 0.220>)}
  }
  object {
    cylinder{<4,0,0><28.5,0.0,0>6.25} // plastic cap
    pigment { Black } 
  }
}
#end

/********************************************************************************************************************************************
// ublox tim-lea-la GPS receiver
********************************************************************************************************************************************/
#macro USER_GPS_LEA_LA()
union{
  object {
    box{<-8.5,0,-11.5><8.5,1,11.5>}   // PCB
    texture{pigment{DarkGreen}}
  }
  object {
    box{<-8.2,0,-11.2><8.2,2,-0.3>}   // lower shielding
    texture{col_silver}
    translate<0, 1, 0>
  }
  object {
    box{<-8.2,0,0.3><8.2,2,11.2>}     // uper shielding
    texture{col_silver}
    translate<0, 1, 0>
  }
  object {
    text {ttf besch_font "LEA-LA" 1, 0 rotate<90,0,0> scale 1.5 translate<-2,3.1,4>}
    pigment { Black }
  }
}
#end
/********************************************************************************************************************************************
// Micro8
********************************************************************************************************************************************/
#macro USER_SMD_MICRO8(value)
object{IC_SMD_GRND(3.,3.,0.85,4.90,4,4,0.65,0.65,0.3,0.3,0.22,0.15,0,1,1,3.9/5,3.9/5,0)}
#end

/********************************************************************************************************************************************
// DF12 daughter board gumstix connector
********************************************************************************************************************************************/
#macro USER_SMD_DF12(value)
union{
  #local pin =
  union{
    box{<-1.9,0,-0.125> <-2.3,0.2,0.125> }
    box{<-1.3,0.5,-0.125> <-1.1,2.4,0.125> }
    box{< 1.9,0.0,-0.125><2.3,0.2,0.125> }
    box{<1.3,0.5,-0.125> <1.1,2.4,0.125> }
    texture{col_gold}
  }  
  #local n = 30;
  #local i = 0;
  #while(i<n)
    object{pin translate<0, 0, -(n-1)*0.5/2+i*0.5>}
  #local i = i + 1;
  #end

  difference {
    box{<-1.9,0,-8.6><1.9,2.4,8.6>}
    box{<-1.2,0.5,-7.85><1.2,2.5,7.85>}
    box{<-0.6,2,-9><0.6,2.5,9>}
 }
  pigment{White}
}
#end

/********************************************************************************************************************************************
// DF12 gumstix connector
********************************************************************************************************************************************/
#macro USER_SMD_DF12_M(value)
union{
  #local pin =
  union{
    box{<-1.9,0,-0.125> <-2.3,0.2,0.125> }
    box{<-1.3,0.5,-0.125> <-1.1,2.4,0.125> }
    box{< 1.9,0.0,-0.125><2.3,0.2,0.125> }
    box{<1.3,0.5,-0.125> <1.1,2.4,0.125> }
    texture{col_gold}
  }  
  #local n = 30;
  #local i = 0;
  #while(i<n)
    object{pin translate<0, 0, -(n-1)*0.5/2+i*0.5>}
  #local i = i + 1;
  #end

  difference {
    box{<-1.9,0,-8.6><1.9,2.2,8.6>}
    box{<-1.2,0.5,-8.7><-2,2.5,8.7>}
    box{<1.2,0.5,-8.7><2,2.5,8.7>}
    box{<-2,0.51,-7.85><2,2.5,-9>}
    box{<-2,0.51,7.85><2,2.5,9>}
 }
  pigment{White}
}
#end

/********************************************************************************************************************************************
//Analog device ADXR gyro
********************************************************************************************************************************************/
#macro USER_ADXR_GYRO()
union{
  object {
    box{<-3.5,0,-3.5><3.5,2.5,3.5>}     // Body
    pigment{rgb(<0.400, 0.320, 0.220>)}
  }
  object {
    text {ttf besch_font "ADXRS300" 0.5, 0 rotate<90,0,0> scale 0.8 translate<-2,2.51,0>}
    pigment { White }
  }
  translate<0,0.4,0>
}
#end

/********************************************************************************************************************************************
//Analog device ADXL320 accelerometer
********************************************************************************************************************************************/
#macro USER_ADXL320()
union {
  difference {
    object {
      box{<-2,0,-2><2,1.45,2>}     // Body
      pigment{Gray30}
    } 
    cylinder{<0,1.35,0><0,1.55,0>0.2 translate<-1.5,0,1.5> texture{col_silver}}
  }
  object {
    text {ttf besch_font "ADXL" 0.5, 0 rotate<90,0,0> scale 0.8 translate<-1,1.46,0>}
    pigment { White }
  }
}
#end

/********************************************************************************************************************************************
//Analog device ADXL320 accelerometer
********************************************************************************************************************************************/
#macro USER_MMA7260()
union {
  difference {
    object {
      box{<-2.6,0,-2.6><2.6,1.45,2.6>}     // Body
      pigment{Gray30}
    } 
    cylinder{<0,1.35,0><0,1.55,0>0.2 translate<-1.5,0,-1.5> texture{col_silver}}
  }
  object {
    text {ttf besch_font "MMA" 0.5, 0 rotate<90,0,0> scale 0.8 translate<-1,1.46,0>}
    pigment { White }
  }
}
#end

/********************************************************************************************************************************************
//HMC1053 magnetometer
********************************************************************************************************************************************/
#macro USER_HMC1053()
union {
  object {
    box{<-3.72,0,-3.72><3.72,2.8,3.72>}     // Body
    pigment{Gray30}
  }
  object {
    text {ttf besch_font "HMC1053" 0.5, 0 rotate<90,0,0> scale 0.8 translate<-2,2.81,0>}
    pigment { White }
  }
}
#end

/********************************************************************************************************************************************
// CTS crystal
********************************************************************************************************************************************/
#macro SPC_CTS_CRYSTAL()
union{
  object {
    box{<-2.5,0,-1.6><2.5,2.5,1.6>}     // Body
    pigment{rgb(<0.400, 0.320, 0.220>)}
  }
  object {
    text {ttf besch_font "14.756MHz" 0.2, 0 rotate<90,0,0> scale 0.8 translate<-2,2.51,0>}
    pigment { White }
  }
}
#end

/********************************************************************************************************************************************
// WE-PD smd power choke
********************************************************************************************************************************************/
#macro USER_SMD_WE_PD(value)
union{
  intersection {
    box{<-6,0,-6><6,8 ,6>}
    cylinder{<0,0,0><0, 8.1, 0>, 8}
    texture{pigment{Gray30}}
  }
  cylinder{<0,0,0><0, 8.1, 0>, 5.2}
  pigment{rgb(<0.400, 0.320, 0.220>)}
 }
#end
/********************************************************************************************************************************************
// Philips LPC2148
********************************************************************************************************************************************/
//SQFP-S-10X10-64
#macro QFP_SQFP_S_10X10_64(value)
object{QFP_GRND(12.0,12.0,2.8,16,16,16,16,0.5,0.22,0.15,10,10,0.1,0,1,"philips")}
#end

/********************************************************************************************************************************************
// Molex 53047 ( 1.25 pitch, vertical feeding, through holes )
********************************************************************************************************************************************/
#macro USER_CON_MOLEX_53047_GND(n)
union{
  #local L = n * 1.25 + 1.75;
  #local l = 3.2;
  #local h = 4.2;
   difference {
     box {<-L/2, 0, -l/2><L/2, h, l/2> }
     box {<-L/2+0.6, 1.3, -l/2+0.45><L/2-0.6, h+0.1, l/2-0.45>}
     box {<-L/2+1, 2.7, 0><L/2-1, h+0.1, l/2+0.1>}
     box {<-L/2+0.35, 1.31, -0.35><L/2-0.35, h+0.1, 0.35>}
     box {<-L/2-0.1, 3.21, l/2-0.46><L/2+0.1, h+0.1, l/2+0.1>}
     #local j = 0;
     #while(j<n)
     box {<-0.35, -0.1, -l/2-0.1><0.35, 0.3, l/2+0.1>  translate< -(n-1)*1.25/2+j*1.25, 0, 0> }
     #local j = j + 1;
     #end
     box {<-L/2+1.6, 1.6, -l/2+0.46><-L/2+2.9, 2.9, -l/2-0.1>}
     box {<L/2-1.6, 1.6, -l/2+0.46><L/2-2.9, 2.9, -l/2-0.1>}
     pigment{White}
   }
  #local pin =
  union{
    cylinder {<0, 0, -0.5> <0, -2, -0.5> 0.18}
    box{<-0.2, 0 , -1 > <0.2, 3.1, 0 > }
    cylinder {<0, 1.555, -1.> <0, 1.555, 0.> 0.2 scale < 1, 2, 1>}
    texture{col_gold}
  }  
  #local i = 0;
  #while(i<n)
    object{pin translate< -(n-1)*1.25/2+i*1.25, 0, 0>}
  #local i = i + 1;
  #end

}
#end

#macro USER_CON_MOLEX_53047_2()
object{USER_CON_MOLEX_53047_GND(2)}
#end
#macro USER_CON_MOLEX_53047_3()
object{USER_CON_MOLEX_53047_GND(3)}
#end
#macro USER_CON_MOLEX_53047_4()
object{USER_CON_MOLEX_53047_GND(4)}
#end
#macro USER_CON_MOLEX_53047_5()
object{USER_CON_MOLEX_53047_GND(5)}
#end
#macro USER_CON_MOLEX_53047_6()
object{USER_CON_MOLEX_53047_GND(6)}
#end
#macro USER_CON_MOLEX_53047_7()
object{USER_CON_MOLEX_53047_GND(7)}
#end
#macro USER_CON_MOLEX_53047_8()
object{USER_CON_MOLEX_53047_GND(8)}
#end
#macro USER_CON_MOLEX_53047_9()
object{USER_CON_MOLEX_53047_GND(9)}
#end
#macro USER_CON_MOLEX_53047_10()
object{USER_CON_MOLEX_53047_GND(10)}
#end
#macro USER_CON_MOLEX_53047_11()
object{USER_CON_MOLEX_53047_GND(11)}
#end
#macro USER_CON_MOLEX_53047_12()
object{USER_CON_MOLEX_53047_GND(12)}
#end
#macro USER_CON_MOLEX_53047_13()
object{USER_CON_MOLEX_53047_GND(13)}
#end
#macro USER_CON_MOLEX_53047_14()
object{USER_CON_MOLEX_53047_GND(14)}
#end
#macro USER_CON_MOLEX_53047_15()
object{USER_CON_MOLEX_53047_GND(15)}
#end

/********************************************************************************************************************************************
// Molex 53048 ( 1.25 pitch, horizontal feeding, through holes )
********************************************************************************************************************************************/
#macro USER_CON_MOLEX_53048_GND(n)
union{
  #local L = n * 1.25 + 1.75;
  #local l = 5.5;
  #local h = 3.5;
  difference {
    box {<-L/2, 0, -2.3><L/2, h, 3.2> }
    box {<-L/2+0.6, 0.8, 0.3><L/2-0.6, h-0.4, 3.3>}
    box {<-L/2+1, h-0.5, 1.6><L/2-1, h+0.1, 3.3>}
    box {<-L/2-0.1, h-0.41, 2.3><L/2+0.1, h+0.1, 3.3>}
    box {<-L/2+0.6, -0.1, -2.4><L/2-0.6, 0.3, 3.3>}
    box {<-L/2+0.8, -0.1, -2.4><L/2-0.8, h+0.1, -1.58>}
    box {<-L/2+0.81, 1.3, -2.4><L/2-0.81, h+0.1, -1.>}
    box {<-L/2-0.1, h-1, -2.4><L/2+0.1, h+0.1, -1.01>}
    #local j = 0;
    #while(j<n)
        box {<-0.3, h-0.6, -1.1><0.3, h+0.1, -0.7>  translate< -(n-1)*1.25/2+j*1.25, 0, 0> }
	cylinder {<0, -0.1, -1.3> <0, h+0.1, -1.3> 0.3  translate< -(n-1)*1.25/2+j*1.25, 0, 0> }
    #local j = j + 1;
    #end
        box {<-L/2+1.6, 0, 2.7><-L/2+2.9, 0.9, 1.1>}
        box {<L/2-1.6, 0, 2.7><L/2-2.9, 2.9, 1.1>}
    pigment{White}
  }
  #local pin =
  union{
    cylinder {<0, -2.3, -1.25> <0, 1.27, -1.25> 0.18}
    cylinder {<0, 1.52, -1> <0, 1.52, -0.75> 0.18}
    intersection {
      torus { 0.25 0.18 rotate < 0, 0, 90> }
      box { < 1, 0, 0> <-1, 1, -11> }
      translate < 0, 1.27, -1>
    }
    union {
      box{<-0.2, 1.2 , -0.75 > <0.2, 2, 1.95 > }
      cylinder {<0, 1.2, 1.02> <0, 2., 1.02> 0.2 scale < 1, 1, 2>}
    }
    texture{col_gold}
  }  
  #local i = 0;
  #while(i<n)
    object{pin translate< -(n-1)*1.25/2+i*1.25, 0, 0>}
  #local i = i + 1;
  #end

}
#end

#macro USER_CON_MOLEX_53048_2()
object{USER_CON_MOLEX_53048_GND(2)}
#end
#macro USER_CON_MOLEX_53048_3()
object{USER_CON_MOLEX_53048_GND(3)}
#end
#macro USER_CON_MOLEX_53048_4()
object{USER_CON_MOLEX_53048_GND(4)}
#end
#macro USER_CON_MOLEX_53048_5()
object{USER_CON_MOLEX_53048_GND(5)}
#end
#macro USER_CON_MOLEX_53048_6()
object{USER_CON_MOLEX_53048_GND(6)}
#end
#macro USER_CON_MOLEX_53048_7()
object{USER_CON_MOLEX_53048_GND(7)}
#end
#macro USER_CON_MOLEX_53048_8()
object{USER_CON_MOLEX_53048_GND(8)}
#end
#macro USER_CON_MOLEX_53048_9()
object{USER_CON_MOLEX_53048_GND(9)}
#end
#macro USER_CON_MOLEX_53048_10()
object{USER_CON_MOLEX_53048_GND(10)}
#end
#macro USER_CON_MOLEX_53048_11()
object{USER_CON_MOLEX_53048_GND(11)}
#end
#macro USER_CON_MOLEX_53048_12()
object{USER_CON_MOLEX_53048_GND(12)}
#end
#macro USER_CON_MOLEX_53048_13()
object{USER_CON_MOLEX_53048_GND(13)}
#end
#macro USER_CON_MOLEX_53048_14()
object{USER_CON_MOLEX_53048_GND(14)}
#end
#macro USER_CON_MOLEX_53048_15()
object{USER_CON_MOLEX_53048_GND(15)}
#end

/********************************************************************************************************************************************
// Molex 53398 ( 1.25 pitch, vertical feeding, SMD )
********************************************************************************************************************************************/
#macro USER_CON_SMD_MOLEX_53398_GND(n)

union{
        #local L = n * 1.25 + 1.75;
	#local h = 4.7;
	#local l = 3.7;

	#local pin =
	union{
	  box{<-0.18, 0.01 ,-0.35><0.18, 3.65, 0.35> translate<0, 0, 0>}
	  cylinder {<0, 0, -0.4> <0, 0, 0.4> 0.18  scale < 1, 2, 1> translate <0, 3.65, 0>}
          //		box{<-0.18,0.8,-1.5><0.18,1.375,-1.8> }
	  //		box{<-0.18,0.0,-1.8><0.18,1.375,-2.5> }
	}

	//Pins
	union{
		#local i = 0;
		#while(i<n)
			object{pin translate<-(n-1)*1.25/2+i*1.25,0,0>}
			#local i = i + 1;
		#end
		
		object{ TOOLS_RECT_BOGEN(0.5,90,0.25,2.2,1.2,1) rotate<0,180,0> translate<-L/2-0.2,0.125,0.6>  }
		object{ TOOLS_RECT_BOGEN(0.5,90,0.25,2.2,1.2,1) rotate<0,0,0> translate<L/2+0.2,0.125,0.6>  }
		texture{col_silver}
	}

	//  box{<-L/2, 0.01, 0><L/2,h, l> 	texture{pigment{Gray30}}}
	//Plastikkoerper
	//	union{
	//		difference{
	//			box{<-(4.25+(n-2)*1.25)/2,0,0.01><(4.25+(n-2)*1.25)/2,3.4,4.2>}
	//			box{<-(3.05+(n-2)*1.25)/2,0.6,0.8><(3.05+(n-2)*1.25)/2,3.0,4.3>}
	//			box{<-(4.3+(n-2)*1.25)/2,2.99,3.2><(4.3+(n-2)*1.25)/2,3.41,4.3>}
	//			box{<-(2.5+(n-2)*1.25)/2,2.99,2.8><(2.5+(n-2)*1.25)/2,3.41,4.3>}
	//
	//			#local i = 0;
	//			#while(i<n+2)
	//				box{<-0.3,2.8,0> <0.3,3.41,0.6> translate<-(n+1)*1.25/2+i*1.25,0,0>}
	//				#local i = i + 1;
	//			#end
	//		}
	//		
	//		box{<-(4.25+(n-2)*1.25)/2,0.25,0.9><-(4.25+(n-2)*1.25)/2-1.5,2,3.8>}
	//		box{<(4.25+(n-2)*1.25)/2,0.25,0.9><(4.25+(n-2)*1.25)/2+1.5,2,3.8>}
	//
	//		texture{pigment{Gray30}}
	//	}

}
#end

#macro USER_CON_SMD_MOLEX_53398_2()
object{USER_CON_SMD_MOLEX_53398_GND(2)}
#end
#macro USER_CON_SMD_MOLEX_53398_3()
object{USER_CON_SMD_MOLEX_53398_GND(3)}
#end
#macro USER_CON_SMD_MOLEX_53398_4()
object{USER_CON_SMD_MOLEX_53398_GND(4)}
#end
#macro USER_CON_SMD_MOLEX_53398_5()
object{USER_CON_SMD_MOLEX_53398_GND(5)}
#end
#macro USER_CON_SMD_MOLEX_53398_6()
object{USER_CON_SMD_MOLEX_53398_GND(6)}
#end
#macro USER_CON_SMD_MOLEX_53398_7()
object{USER_CON_SMD_MOLEX_53398_GND(7)}
#end
#macro USER_CON_SMD_MOLEX_53398_8()
object{USER_CON_SMD_MOLEX_53398_GND(8)}
#end
#macro USER_CON_SMD_MOLEX_53398_9()
object{USER_CON_SMD_MOLEX_53398_GND(9)}
#end
#macro USER_CON_SMD_MOLEX_53398_10()
object{USER_CON_SMD_MOLEX_53398_GND(10)}
#end
#macro USER_CON_SMD_MOLEX_53398_11()
object{USER_CON_SMD_MOLEX_53398_GND(11)}
#end
#macro USER_CON_SMD_MOLEX_53398_12()
object{USER_CON_SMD_MOLEX_53398_GND(12)}
#end
#macro USER_CON_SMD_MOLEX_53398_13()
object{USER_CON_SMD_MOLEX_53398_GND(13)}
#end
#macro USER_CON_SMD_MOLEX_53398_14()
object{USER_CON_SMD_MOLEX_53398_GND(14)}
#end
#macro USER_CON_SMD_MOLEX_53398_15()
object{USER_CON_SMD_MOLEX_53398_GND(15)}
#end

/********************************************************************************************************************************************
// Fake gumstix PXA255
********************************************************************************************************************************************/

#macro USER_FAKE_GUM_CPU(name)
union {
  box{ <-8.6, 0.2, -8.6> < 8.6, 0.8, 8.6> texture{pigment{DarkGreen}}}
  box{ <-7.5, 0.8, -7.5> < 7.5, 1.7, 7.5> texture{ pigment { Black }}}
}
#end

#macro USER_FAKE_GUM_RAM(name)
object {
  box{ <-4, 0.2, -7> < 4, 0.8, 7> texture{ pigment { Black }}}
}
#end

#macro USER_FAKE_GUM_FLASH(name)
object {
  box{ <-5, 0.2, -6.5> < 5, 1, 6.5> texture{ pigment { Black }}}
}
#end

#macro USER_FAKE_GUM_CARD(name)
union {
  difference {
    box{ <-13.2, 0, -10> < 13.2, 3.5, 10> texture{pigment{Gray30}}}
    box{ <-11.2, -0.1, 6> < 11.2, 0.6, 10.1>}
    box{ <-11.2, 0.5, -1> < 11.2, 3.6, 10.1>}
    box{ <-12.2, 1.3, -9> < 12.2, 2.9, 10.1>}
  }
  #local pin =
  union{
    box{<-0.2, 0 , -5 > <0.2, 0.6, 7 > }
    texture{col_silver}
  }  
  #local i = 0;
  #while(i<9)
    object{pin translate< -(9-1)*2.25/2+i*2.25, 0, 0>}
  #local i = i + 1;
  #end
  rotate <0, 180, 0>
}
#end


/********************************************************************************************************************************************
// Melexis MLX90247 thermopile
********************************************************************************************************************************************/

#macro USER_MLX_90247()
union {
  // body
  cylinder {<0, 0, 0> <0, 0, 0.4> 4.56 texture{col_gold}}
  cylinder {<0, 0, 0.4> <0, 0, 3.2> 4.4 texture{col_silver}}
  torus { 4. 0.4 rotate <90, 0, 0> translate <0,0,3.2>  texture{col_silver}}
  cylinder {<0, 0, 3.2> <0, 0, 3.6> 4.0 texture{col_silver}}
  difference{
    cylinder {<0, 0, 3.6> <0, 0, 4.> 2.8 texture{col_silver}}
    cylinder {<0, 0, 3.9> <0, 0, 4.1> 1.75 texture{ pigment { Black }}}
  }
  // pins
  cylinder {<0, 2.54, -5> <0, 2.54, 0> 0.225 texture{col_gold}}
  cylinder {<0, 0, 0.1> <0, 0, -0.05> 0.8 translate <0, 2.54, 0> pigment { White }}
  cylinder {<0, -2.54, -0.3> <0, -2.54, 0> 0.225 texture{col_gold}}
  cylinder {<0, 0, 0.1> <0, 0, -0.05> 0.8 translate <0, -2.54, 0> pigment { White }}
  #local bended_leg=
  union {
    union {
      cylinder {<0, 0, -3.8> <0, 0, 0> 0.225}
      intersection {
	torus { 0.5 0.225 }
	box {<0, -1, 0> < 2, 1, 2>}
	rotate <90, 90, 0> translate <0, .5,-3.8>
	  }
      cylinder {<0, 0.5, -4.3> <0, 3, -4.3> 0.225}
      texture{col_gold}
    }
    cylinder {<0, 0, 0.1> <0, 0, -0.05> 0.8 pigment { White }}
  }
  object {bended_leg translate < 2.54, 0, 0>}
  object {bended_leg translate < -2.54, 0, 0>}
  translate <0, -2.4, 0.5>
}
#end

/********************************************************************************************************************************************
// AD8551
********************************************************************************************************************************************/
//MSOP8
#macro USER_MSOP8(value)
object{IC_SMD_GRND(3.,3.,0.95,4.90,4,4,0.65,0.65,0.3,0.3,0.22,0.15,0,1,1,3.9/5,3.9/5,0)}
#end
