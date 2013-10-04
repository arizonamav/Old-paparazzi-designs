//POVRay-File created by 3d41.ulp v1.03
///export/home/drouin/work/paparazzi/savannah/paparazzi3/hw/in_progress/imu_xy.brd
//11/14/2005 11:48:49 

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = on;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare environment = on;

#local cam_x = 0;
#local cam_y = 165;
#local cam_z = -72;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -3;
#local cam_look_z = 0;

#local pcb_rotate_x = 180;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 19;
#local lgt1_pos_y = 29;
#local lgt1_pos_z = 16;
#local lgt1_intense = 0.723192;
#local lgt2_pos_x = -19;
#local lgt2_pos_y = 29;
#local lgt2_pos_z = 16;
#local lgt2_intense = 0.723192;
#local lgt3_pos_x = 19;
#local lgt3_pos_y = 29;
#local lgt3_pos_z = -11;
#local lgt3_intense = 0.723192;
#local lgt4_pos_x = -19;
#local lgt4_pos_y = 29;
#local lgt4_pos_z = -11;
#local lgt4_intense = 0.723192;

//Do not change these values
#declare pcb_hight = 1.500000;
#declare pcb_cuhight = 0.035000;
#declare pcb_x_size = 51.669000;
#declare pcb_y_size = 31.420000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(915);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.500000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "tools.inc"
#include "user.inc"

global_settings{charset utf8}

#if(environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-25.834500,0,-15.710000>
}
#end

background{col_bgr}


//Axis uncomment to activate
//object{TOOLS_AXIS_XYZ(100,100,100 //texture{ pigment{rgb<1,0,0>} finish{diffuse 0.8 phong 1}}, //texture{ pigment{rgb<1,1,1>} finish{diffuse 0.8 phong 1}})}

light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro IMU_XY(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<30.358000,-0.470000><82.027000,-0.470000>
<82.027000,-0.470000><82.027000,30.950000>
<82.027000,30.950000><30.358000,30.950000>
<30.358000,30.950000><30.358000,-0.470000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
//Holes(real)/Board
cylinder{<79.248000,1,28.448000><79.248000,-5,28.448000>1.000000 texture{col_hls}}
cylinder{<79.248000,1,2.032000><79.248000,-5,2.032000>1.000000 texture{col_hls}}
cylinder{<33.147000,1,28.448000><33.147000,-5,28.448000>1.000000 texture{col_hls}}
cylinder{<33.147000,1,2.032000><33.147000,-5,2.032000>1.000000 texture{col_hls}}
cylinder{<33.147000,1,28.448000><33.147000,-5,28.448000>1.500000 texture{col_hls}}
cylinder{<33.147000,1,2.032000><33.147000,-5,2.032000>1.500000 texture{col_hls}}
cylinder{<79.248000,1,28.448000><79.248000,-5,28.448000>1.500000 texture{col_hls}}
cylinder{<79.248000,1,2.032000><79.248000,-5,2.032000>1.500000 texture{col_hls}}
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_AP) #declare global_pack_AP=yes; object {QFP_SQFP_S_10X10_64("LPC2148",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-225.000000,0> rotate<0,0,180> translate<53.504200,-1.500000,8.090900>translate<0,-0.035000,0> }#end		//SQFP-S-10X10-64 AP LPC2148 SQFP-S-10X10-64
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<75.819000,-0.000000,8.763000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C1 22nF C0603K
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<72.263000,-0.000000,11.303000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C2 22nF C0603K
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<68.961000,-0.000000,11.303000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C3 100nF C0603K
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<75.819000,-0.000000,4.445000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C4 100nF C0603K
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<66.421000,-0.000000,5.461000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C5 100nF C0603K
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<77.724000,-1.500000,5.080000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C6 47nF C0603K
#ifndef(pack_C7) #declare global_pack_C7=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<66.421000,-0.000000,8.763000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C7 22nF C0603K
#ifndef(pack_C7_) #declare global_pack_C7_=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<64.897000,-1.500000,17.653000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C7_ 150pF C0603K
#ifndef(pack_C8) #declare global_pack_C8=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-45.000000,0> rotate<0,0,0> translate<49.477400,-0.000000,9.958700>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C8 13pF C0603K
#ifndef(pack_C8_) #declare global_pack_C8_=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<73.787000,-1.500000,16.637000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C8_ 150pF C0603K
#ifndef(pack_C9) #declare global_pack_C9=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-135.000000,0> rotate<0,0,0> translate<45.465900,-0.000000,10.488400>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C9 13pF C0603K
#ifndef(pack_C9_) #declare global_pack_C9_=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<73.025000,-1.500000,27.813000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C9_ 150pF C0603K
#ifndef(pack_C9_1) #declare global_pack_C9_1=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<65.786000,-0.000000,27.940000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C9_1 100nF C0603K
#ifndef(pack_C9_2) #declare global_pack_C9_2=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<65.786000,-0.000000,29.464000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C9_2 100nF C0603K
#ifndef(pack_C10) #declare global_pack_C10=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<47.116900,-0.000000,25.400100>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C10 100nF C0603K
#ifndef(pack_C11) #declare global_pack_C11=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-315.000000,0> rotate<0,0,0> translate<60.579000,-0.000000,24.765000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C11 100nF C0603K
#ifndef(pack_C12) #declare global_pack_C12=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-135.000000,0> rotate<0,0,0> translate<45.593000,-0.000000,17.399000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C12 100nF C0603K
#ifndef(pack_C13) #declare global_pack_C13=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<40.169200,-0.000000,23.584800>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C13 100nF C0603K
#ifndef(pack_C14) #declare global_pack_C14=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-315.000000,0> rotate<0,0,0> translate<59.309000,-0.000000,14.351000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C14 100nF C0603K
#ifndef(pack_C15) #declare global_pack_C15=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-315.000000,0> rotate<0,0,0> translate<51.562000,-0.000000,11.303000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C15 100nF C0603K
#ifndef(pack_C16) #declare global_pack_C16=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<76.962000,-1.500000,22.987000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C16 100nF C0603K
#ifndef(pack_C17) #declare global_pack_C17=yes; object {CAP_SMD_CHIP_TT_SCT_A("10uF")translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<63.119000,-0.000000,24.511000>translate<0,0.035000,0> }#end		//SMD Tantal Chip Bauform A  C17 10uF A/3216-18R
#ifndef(pack_C18) #declare global_pack_C18=yes; object {CAP_SMD_CHIP_TT_SCT_A("10uF")translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<40.259000,-1.500000,21.844000>translate<0,-0.035000,0> }#end		//SMD Tantal Chip Bauform A  C18 10uF A/3216-18R
#ifndef(pack_C19) #declare global_pack_C19=yes; object {CAP_SMD_CHIP_TT_SCT_B("22uF",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<53.975000,-1.500000,20.447000>translate<0,-0.035000,0> }#end		//SMD Tantal Chip Bauform B  C19 22uF B/3528-21R
#ifndef(pack_C20) #declare global_pack_C20=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<53.721000,-1.500000,18.161000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C20 100nF C0603K
#ifndef(pack_C21) #declare global_pack_C21=yes; object {CAP_SMD_CHIP_TT_SCT_B("22uF",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<43.942000,-1.500000,20.447000>translate<0,-0.035000,0> }#end		//SMD Tantal Chip Bauform B  C21 22uF B/3528-21R
#ifndef(pack_C22) #declare global_pack_C22=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<63.500000,-0.000000,13.335000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C22 100nF C0603
#ifndef(pack_C23) #declare global_pack_C23=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<43.942000,-1.500000,18.288000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C23 100nF C0603K
#ifndef(pack_C24) #declare global_pack_C24=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<75.057000,-1.500000,9.779000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C24 100nF C0603K
#ifndef(pack_C25) #declare global_pack_C25=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<73.025000,-1.500000,12.192000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C25 10nF C0603K
#ifndef(pack_C26) #declare global_pack_C26=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<75.057000,-1.500000,6.858000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C26 100nF C0603K
#ifndef(pack_C27) #declare global_pack_C27=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<73.025000,-1.500000,4.191000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C27 10nF C0603K
#ifndef(pack_C28) #declare global_pack_C28=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<63.627000,-1.500000,9.779000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C28 100nF C0603K
#ifndef(pack_C29) #declare global_pack_C29=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<65.659000,-1.500000,12.192000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C29 10nF C0603K
#ifndef(pack_C30) #declare global_pack_C30=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<70.739000,-1.500000,13.970000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C30 100nF C0603K
#ifndef(pack_C31) #declare global_pack_C31=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<76.581000,-1.500000,8.255000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C31 100nF C0603K
#ifndef(pack_C32) #declare global_pack_C32=yes; object {CAP_SMD_CHIP_TT_SCT_A("10uF")translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<60.960000,-1.500000,20.701000>translate<0,-0.035000,0> }#end		//SMD Tantal Chip Bauform A  C32 10uF A/3216-18R
#ifndef(pack_C33) #declare global_pack_C33=yes; object {CAP_SMD_CHIP_TT_SCT_A("10uF")translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<50.292000,-1.500000,19.431000>translate<0,-0.035000,0> }#end		//SMD Tantal Chip Bauform A  C33 10uF A/3216-18R
#ifndef(pack_C34) #declare global_pack_C34=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<40.005000,-1.500000,27.305000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C34 100nF C0603K
#ifndef(pack_C35) #declare global_pack_C35=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<68.453000,-0.000000,12.954000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C35 100nF C0603K
#ifndef(pack_C36) #declare global_pack_C36=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<56.007000,-0.000000,9.398000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C36 100nF C0603K
#ifndef(pack_C37) #declare global_pack_C37=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<47.625000,-0.000000,4.191000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C37 3.3nF C0603K
#ifndef(pack_C38) #declare global_pack_C38=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<50.673000,-0.000000,4.191000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C38 100pF C0603K
#ifndef(pack_C39) #declare global_pack_C39=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<49.022000,-0.000000,8.128000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C39 220pF C0603K
#ifndef(pack_C40) #declare global_pack_C40=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<56.769000,-0.000000,4.191000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C40 1nF C0603K
#ifndef(pack_C41) #declare global_pack_C41=yes; object {CAP_SMD_CHIP_TT_SCT_A("10uF")translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<59.309000,-0.000000,6.350000>translate<0,0.035000,0> }#end		//SMD Tantal Chip Bauform A  C41 10uF A/3216-18R
#ifndef(pack_C42) #declare global_pack_C42=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<58.293000,-1.500000,19.558000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C42 10nF C0603K
#ifndef(pack_C44) #declare global_pack_C44=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-45.000000,0> rotate<0,0,180> translate<45.466000,-1.500000,12.192000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C44 100nF C0603K
#ifndef(pack_C45) #declare global_pack_C45=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-225.000000,0> rotate<0,0,180> translate<47.117000,-1.500000,3.175000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C45 100nF C0603K
#ifndef(pack_C46) #declare global_pack_C46=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-135.000000,0> rotate<0,0,180> translate<60.833000,-1.500000,4.064000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C46 100nF C0603K
#ifndef(pack_C47) #declare global_pack_C47=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<43.053000,-0.000000,6.985000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C47 100nF C0603K
#ifndef(pack_C48) #declare global_pack_C48=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-45.000000,0> rotate<0,0,180> translate<58.547000,-1.500000,14.478000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C48 100nF C0603K
#ifndef(pack_C49) #declare global_pack_C49=yes; object {CAP_SMD_CHIP_0603(DarkWood)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<50.202100,-1.500000,16.091800>translate<0,-0.035000,0> }#end		//SMD Capacitor 0603 C49 100nF C0603K
#ifndef(pack_D1) #declare global_pack_D1=yes; object {SD_SOD80("",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<48.006000,-1.500000,19.304000>translate<0,-0.035000,0> }#end		//Diode SOD80-Outline D1  SOD80
#ifndef(pack_FBW) #declare global_pack_FBW=yes; object {QFP_SQFP_S_10X10_64("LPC2148",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-45.000000,0> rotate<0,0,0> translate<53.646600,-0.000000,20.447000>translate<0,0.035000,0> }#end		//SQFP-S-10X10-64 FBW LPC2148 SQFP-S-10X10-64
#ifndef(pack_GPS_CON) #declare global_pack_GPS_CON=yes; object {CON_SMD_MOLEX_53261_6()translate<0,-0,-1.5> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<65.151000,-1.500000,1.905000>translate<0,-0.035000,0> }#end		// molex 53261 6 pins GPS_CON  53261-06
#ifndef(pack_GUM_CON) #declare global_pack_GUM_CON=yes; object {CON_SMD_MOLEX_53261_6()translate<0,-0,-1.5> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<41.656000,-1.500000,1.651000>translate<0,-0.035000,0> }#end		// molex 53261 6 pins GUM_CON  53261-06
#ifndef(pack_GYRO_Z) #declare global_pack_GYRO_Z=yes; object {USER_ADXR_GYRO()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<71.120000,-0.000000,6.604000>translate<0,0.035000,0> }#end		//Analog device ADRX320 gyro  GYRO_Z ADXR BC-32
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_SMD_SOT23_5("LP2992",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<58.293000,-1.500000,22.479000>translate<0,-0.035000,0> }#end		//SOT23-5 IC1 LP2992 SOT23-5
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_SMD_SOT223("REG1117",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<52.578000,-1.500000,26.289000>translate<0,-0.035000,0> }#end		//SOT223 IC2 REG1117 SOT223
#ifndef(pack_IC3) #declare global_pack_IC3=yes; object {IC_SMD_SOT223("REG1117",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<45.339000,-1.500000,26.289000>translate<0,-0.035000,0> }#end		//SOT223 IC3 REG1117 SOT223
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {SLED_0805(Red,0.700000,0.000000)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<60.325000,-0.000000,1.143000>translate<0,0.035000,0> }#end		// SMD LED 0805 LED1  CHIP-LED0805
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {SLED_0805(Red,0.700000,0.000000)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<55.880000,-0.000000,1.143000>translate<0,0.035000,0> }#end		// SMD LED 0805 LED2  CHIP-LED0805
#ifndef(pack_LED3) #declare global_pack_LED3=yes; object {SLED_0805(Red,0.700000,0.000000)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<51.308000,-0.000000,1.143000>translate<0,0.035000,0> }#end		// SMD LED 0805 LED3  CHIP-LED0805
#ifndef(pack_OA1) #declare global_pack_OA1=yes; object {IC_SMD_TSSOP14("AD8554ARU",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<69.342000,-1.500000,8.255000>translate<0,-0.035000,0> }#end		//TSSOP14 OA1 AD8554ARU TSSOP14
#ifndef(pack_PWM_RC) #declare global_pack_PWM_RC=yes; object {CON_SMD_MOLEX_53261_10()translate<0,0,-1.5> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<33.020000,-0.000000,13.081000>translate<0,0.035000,0> }#end		// molex 53261 10 pins PWM/RC  53261-10
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_SMD_CHIP_0603("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<42.164000,-0.000000,23.622000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R1 10K R0603
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_SMD_CHIP_0603("394",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<75.184000,-1.500000,11.303000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R2 390k R0603
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_SMD_CHIP_0603("474",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<75.184000,-1.500000,13.335000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R3 470k R0603
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_SMD_CHIP_0603("221",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<64.897000,-0.000000,25.400000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R4 220R R0603
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_SMD_CHIP_0603("394",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<75.184000,-1.500000,5.207000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R5 390k R0603
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_SMD_CHIP_0603("474",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<75.184000,-1.500000,3.175000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R6 470k R0603
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_SMD_CHIP_0603("124",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<63.500000,-1.500000,15.367000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R7 120k R0603
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_SMD_CHIP_0603("394",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<63.500000,-1.500000,11.303000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R8 390k R0603
#ifndef(pack_R9) #declare global_pack_R9=yes; object {RES_SMD_CHIP_0603("474",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<63.500000,-1.500000,13.335000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R9 470k R0603
#ifndef(pack_R10) #declare global_pack_R10=yes; object {RES_SMD_CHIP_0603("124",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<67.691000,-1.500000,14.605000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R10 120K R0603
#ifndef(pack_R11) #declare global_pack_R11=yes; object {RES_SMD_CHIP_0603("124",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<70.739000,-1.500000,15.494000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R11 120K R0603
#ifndef(pack_R12) #declare global_pack_R12=yes; object {RES_SMD_CHIP_0603("492",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<75.946000,-1.500000,25.019000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R12 4.99k R0603
#ifndef(pack_R13) #declare global_pack_R13=yes; object {RES_SMD_CHIP_0603("105",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<69.342000,-1.500000,18.542000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R13 1M R0603
#ifndef(pack_R14) #declare global_pack_R14=yes; object {RES_SMD_CHIP_0603("492",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<75.946000,-1.500000,27.051000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R14 4.99k R0603
#ifndef(pack_R15) #declare global_pack_R15=yes; object {RES_SMD_CHIP_0603("105",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<73.025000,-1.500000,25.781000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R15 1M R0603
#ifndef(pack_R16) #declare global_pack_R16=yes; object {RES_SMD_CHIP_0603("492",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<74.422000,-1.500000,21.463000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R16 4.99k R0603
#ifndef(pack_R17) #declare global_pack_R17=yes; object {RES_SMD_CHIP_0603("105",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<71.247000,-1.500000,18.542000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R17 1M R0603
#ifndef(pack_R18) #declare global_pack_R18=yes; object {RES_SMD_CHIP_0603("492",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<76.327000,-1.500000,18.415000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R18 4.99k R0603
#ifndef(pack_R19) #declare global_pack_R19=yes; object {RES_SMD_CHIP_0603("105",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<73.787000,-1.500000,18.669000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R19 1M R0603
#ifndef(pack_R20) #declare global_pack_R20=yes; object {RES_SMD_CHIP_0603("492",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<69.342000,-1.500000,26.416000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R20 4.99k R0603
#ifndef(pack_R21) #declare global_pack_R21=yes; object {RES_SMD_CHIP_0603("105",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<67.437000,-1.500000,18.542000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R21 1M R0603
#ifndef(pack_R22) #declare global_pack_R22=yes; object {RES_SMD_CHIP_0603("492",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<64.897000,-1.500000,22.225000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R22 4.99k R0603
#ifndef(pack_R23) #declare global_pack_R23=yes; object {RES_SMD_CHIP_0603("105",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,180> translate<64.897000,-1.500000,19.685000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R23 1M R0603
#ifndef(pack_R24) #declare global_pack_R24=yes; object {RES_SMD_CHIP_0603("103",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<35.941000,-1.500000,27.305000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R24 10k R0603
#ifndef(pack_R25) #declare global_pack_R25=yes; object {RES_SMD_CHIP_0603("472",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<37.973000,-1.500000,27.305000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R25 4.7K R0603
#ifndef(pack_R26) #declare global_pack_R26=yes; object {RES_SMD_CHIP_0603("104",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<46.482000,-0.000000,6.731000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R26 100K R0603
#ifndef(pack_R27) #declare global_pack_R27=yes; object {RES_SMD_CHIP_0603("563",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<49.022000,-0.000000,6.223000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R27 56K R0603
#ifndef(pack_R28) #declare global_pack_R28=yes; object {RES_SMD_CHIP_0603("123",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<53.721000,-0.000000,4.191000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R28 12K R0603
#ifndef(pack_R29) #declare global_pack_R29=yes; object {RES_SMD_CHIP_0603("123",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<61.341000,-0.000000,8.382000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R29 12K R0603
#ifndef(pack_R30) #declare global_pack_R30=yes; object {RES_SMD_CHIP_0603("123",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<61.341000,-0.000000,5.334000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R30 12K R0603
#ifndef(pack_R31) #declare global_pack_R31=yes; object {RES_SMD_CHIP_0603("124",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<64.770000,-0.000000,8.763000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R31 120k R0603
#ifndef(pack_R32) #declare global_pack_R32=yes; object {RES_SMD_CHIP_0603("124",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<64.770000,-0.000000,5.461000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R32 120k R0603
#ifndef(pack_R33) #declare global_pack_R33=yes; object {RES_SMD_CHIP_0603("124",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<69.469000,-0.000000,1.778000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R33 120k R0603
#ifndef(pack_R34) #declare global_pack_R34=yes; object {RES_SMD_CHIP_0603("124",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<66.421000,-0.000000,1.778000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R34 120k R0603
#ifndef(pack_R35) #declare global_pack_R35=yes; object {RES_SMD_CHIP_0603("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<41.402000,-0.000000,6.985000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R35 10K R0603
#ifndef(pack_R36) #declare global_pack_R36=yes; object {RES_SMD_CHIP_0603("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<44.196000,-0.000000,23.622000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R36 10K R0603
#ifndef(pack_R37) #declare global_pack_R37=yes; object {RES_SMD_CHIP_0603("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<39.751000,-0.000000,6.985000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R37 10K R0603
#ifndef(pack_R38) #declare global_pack_R38=yes; object {RES_SMD_CHIP_0603("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<60.325000,-0.000000,0.127000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R38 10K R0603
#ifndef(pack_R39) #declare global_pack_R39=yes; object {RES_SMD_CHIP_0603("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<55.880000,-0.000000,0.127000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R39 10K R0603
#ifndef(pack_R40) #declare global_pack_R40=yes; object {RES_SMD_CHIP_0603("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<51.308000,-0.000000,0.127000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R40 10K R0603
#ifndef(pack_U_1) #declare global_pack_U_1=yes; object {USER_HMC1053()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<71.120000,-0.000000,24.384000>translate<0,0.035000,0> }#end		// HMC1053 magnetometer U$1 HMC1053 LCC16
#ifndef(pack_U_3) #declare global_pack_U_3=yes; object {SPC_CTS_CRYSTAL()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-315.000000,0> rotate<0,0,0> translate<47.101500,-0.000000,12.662900>translate<0,0.035000,0> }#end		//Quarz 5*3.2MM SMD U$3 14.764Mhz CTS_CRYSTAL
#ifndef(pack_U_4) #declare global_pack_U_4=yes; object {IC_SMD_TSSOP14("AD8554ARU",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<69.342000,-1.500000,22.733000>translate<0,-0.035000,0> }#end		//TSSOP14 U$4 AD8554ARU TSSOP14
#ifndef(pack_U_5) #declare global_pack_U_5=yes; object {USER_SMD_MICRO8("7509")translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<61.595000,-0.000000,28.575000>}#end		//Micro8 U$5 IRF7509 MICRO8
#ifndef(pack_U_7) #declare global_pack_U_7=yes; object {USER_ADXL320()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<63.373000,-0.000000,13.208000>translate<0,0.035000,0> }#end		// ADXL accelerometer U$7 ADXL320 LSCFP
#ifndef(pack_U_9) #declare global_pack_U_9=yes; object {USER_SMD_DF12("df12")translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<35.941000,-1.500000,13.081000>}#end		//DF12 gumstix connector U$9 BASIXHEADER DF12
#ifndef(pack_U_12) #declare global_pack_U_12=yes; object {IC_SMD_TSSOP8("AD8552RU",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<54.483000,-0.000000,6.858000>translate<0,0.035000,0> }#end		//TSSOP8 U$12 AD8552RU TSSOP8
#ifndef(pack_X1) #declare global_pack_X1=yes; object {CON_SMD_MOLEX_53261_6()translate<0,0,-1.5> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<41.656000,-0.000000,28.829000>translate<0,0.035000,0> }#end		// molex 53261 6 pins X1  53261-06
#ifndef(pack_X3) #declare global_pack_X3=yes; object {CON_SMD_MOLEX_53261_6()translate<0,0,-1.5> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<41.656000,-0.000000,1.651000>translate<0,0.035000,0> }#end		// molex 53261 6 pins X3  53261-06
#ifndef(pack_X6) #declare global_pack_X6=yes; object {USER_CON_MOLEX_53048_2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<33.528000,-0.000000,24.511000>}#end		//  molex 53048 2 pins X6  53048-02
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<54.812400,-1.537000,14.702300>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<55.166000,-1.537000,14.348700>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<55.519500,-1.537000,13.995200>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<55.873100,-1.537000,13.641600>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<56.226600,-1.537000,13.288100>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<56.580200,-1.537000,12.934500>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<56.933700,-1.537000,12.581000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<57.287300,-1.537000,12.227400>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<57.640800,-1.537000,11.873900>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<57.994400,-1.537000,11.520300>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<58.347900,-1.537000,11.166800>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<58.701500,-1.537000,10.813200>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<59.055000,-1.537000,10.459700>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<59.408600,-1.537000,10.106100>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<59.762100,-1.537000,9.752600>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<60.115700,-1.537000,9.399000>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<60.115700,-1.537000,6.782700>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<59.762100,-1.537000,6.429100>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<59.408600,-1.537000,6.075600>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<59.055000,-1.537000,5.722000>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<58.701500,-1.537000,5.368500>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<58.347900,-1.537000,5.014900>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<57.994400,-1.537000,4.661400>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<57.640800,-1.537000,4.307800>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<57.287300,-1.537000,3.954300>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<56.933700,-1.537000,3.600700>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<56.580200,-1.537000,3.247200>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<56.226600,-1.537000,2.893600>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<55.873100,-1.537000,2.540100>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<55.519500,-1.537000,2.186500>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<55.166000,-1.537000,1.833000>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<54.812400,-1.537000,1.479400>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<52.196100,-1.537000,1.479400>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<51.842500,-1.537000,1.833000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<51.489000,-1.537000,2.186500>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<51.135400,-1.537000,2.540100>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<50.781900,-1.537000,2.893600>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<50.428300,-1.537000,3.247200>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<50.074800,-1.537000,3.600700>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<49.721200,-1.537000,3.954300>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<49.367700,-1.537000,4.307800>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<49.014100,-1.537000,4.661400>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<48.660600,-1.537000,5.014900>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<48.307000,-1.537000,5.368500>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<47.953500,-1.537000,5.722000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<47.599900,-1.537000,6.075600>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<47.246400,-1.537000,6.429100>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<46.892800,-1.537000,6.782700>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<46.892800,-1.537000,9.399000>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<47.246400,-1.537000,9.752600>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<47.599900,-1.537000,10.106100>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<47.953500,-1.537000,10.459700>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<48.307000,-1.537000,10.813200>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<48.660600,-1.537000,11.166800>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<49.014100,-1.537000,11.520300>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<49.367700,-1.537000,11.873900>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<49.721200,-1.537000,12.227400>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<50.074800,-1.537000,12.581000>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<50.428300,-1.537000,12.934500>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<50.781900,-1.537000,13.288100>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<51.135400,-1.537000,13.641600>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<51.489000,-1.537000,13.995200>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<51.842500,-1.537000,14.348700>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<52.196100,-1.537000,14.702300>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<75.819000,0.000000,7.888000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<75.819000,0.000000,9.638000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<71.388000,0.000000,11.303000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<73.138000,0.000000,11.303000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<68.086000,0.000000,11.303000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<69.836000,0.000000,11.303000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<75.819000,0.000000,5.320000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<75.819000,0.000000,3.570000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.421000,0.000000,6.336000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.421000,0.000000,4.586000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.724000,-1.537000,5.955000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.724000,-1.537000,4.205000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<66.421000,0.000000,7.888000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<66.421000,0.000000,9.638000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<65.772000,-1.537000,17.653000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<64.022000,-1.537000,17.653000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<48.858600,0.000000,9.339900>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<50.096100,0.000000,10.577400>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<72.912000,-1.537000,16.637000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<74.662000,-1.537000,16.637000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-135.000000,0> texture{col_pds} translate<46.084600,0.000000,9.869600>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-135.000000,0> texture{col_pds} translate<44.847100,0.000000,11.107100>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<72.150000,-1.537000,27.813000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<73.900000,-1.537000,27.813000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<66.661000,0.000000,27.940000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<64.911000,0.000000,27.940000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<66.661000,0.000000,29.464000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<64.911000,0.000000,29.464000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<47.116900,0.000000,24.525100>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<47.116900,0.000000,26.275100>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<59.960200,0.000000,25.383700>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<61.197700,0.000000,24.146200>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-135.000000,0> texture{col_pds} translate<46.211700,0.000000,16.780200>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-135.000000,0> texture{col_pds} translate<44.974200,0.000000,18.017700>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<40.169200,0.000000,24.459800>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<40.169200,0.000000,22.709800>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<58.690200,0.000000,14.969700>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<59.927700,0.000000,13.732200>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<50.943200,0.000000,11.921700>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<52.180700,0.000000,10.684200>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<76.087000,-1.537000,22.987000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<77.837000,-1.537000,22.987000>}
object{TOOLS_PCB_SMD(1.950000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.119000,0.000000,25.886000>}
object{TOOLS_PCB_SMD(1.950000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.119000,0.000000,23.136000>}
object{TOOLS_PCB_SMD(1.950000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<40.259000,-1.537000,23.219000>}
object{TOOLS_PCB_SMD(1.950000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<40.259000,-1.537000,20.469000>}
object{TOOLS_PCB_SMD(1.950000,2.500000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.450000,-1.537000,20.447000>}
object{TOOLS_PCB_SMD(1.950000,2.500000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<55.500000,-1.537000,20.447000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<54.596000,-1.537000,18.161000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.846000,-1.537000,18.161000>}
object{TOOLS_PCB_SMD(1.950000,2.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<45.467000,-1.537000,20.447000>}
object{TOOLS_PCB_SMD(1.950000,2.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<42.417000,-1.537000,20.447000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.500000,0.000000,12.485000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.500000,0.000000,14.185000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<43.067000,-1.537000,18.288000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<44.817000,-1.537000,18.288000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<75.932000,-1.537000,9.779000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<74.182000,-1.537000,9.779000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<73.025000,-1.537000,13.067000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<73.025000,-1.537000,11.317000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<75.932000,-1.537000,6.858000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<74.182000,-1.537000,6.858000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<73.025000,-1.537000,3.316000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<73.025000,-1.537000,5.066000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<62.752000,-1.537000,9.779000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<64.502000,-1.537000,9.779000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<65.659000,-1.537000,13.067000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<65.659000,-1.537000,11.317000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<69.864000,-1.537000,13.970000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<71.614000,-1.537000,13.970000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<75.706000,-1.537000,8.255000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<77.456000,-1.537000,8.255000>}
object{TOOLS_PCB_SMD(1.950000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<60.960000,-1.537000,22.076000>}
object{TOOLS_PCB_SMD(1.950000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<60.960000,-1.537000,19.326000>}
object{TOOLS_PCB_SMD(1.950000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<50.292000,-1.537000,20.806000>}
object{TOOLS_PCB_SMD(1.950000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<50.292000,-1.537000,18.056000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<40.005000,-1.537000,28.180000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<40.005000,-1.537000,26.430000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<67.578000,0.000000,12.954000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<69.328000,0.000000,12.954000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<56.882000,0.000000,9.398000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<55.132000,0.000000,9.398000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<46.750000,0.000000,4.191000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<48.500000,0.000000,4.191000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<49.798000,0.000000,4.191000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<51.548000,0.000000,4.191000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<48.147000,0.000000,8.128000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<49.897000,0.000000,8.128000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<55.894000,0.000000,4.191000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<57.644000,0.000000,4.191000>}
object{TOOLS_PCB_SMD(1.950000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<59.309000,0.000000,4.975000>}
object{TOOLS_PCB_SMD(1.950000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<59.309000,0.000000,7.725000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<57.418000,-1.537000,19.558000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<59.168000,-1.537000,19.558000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-135.000000,0> texture{col_pds} translate<46.084800,-1.537000,11.573200>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-135.000000,0> texture{col_pds} translate<44.847300,-1.537000,12.810700>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<46.498300,-1.537000,3.793700>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<47.735800,-1.537000,2.556200>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<60.214300,-1.537000,3.445200>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<61.451800,-1.537000,4.682700>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<43.053000,0.000000,6.110000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<43.053000,0.000000,7.860000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-135.000000,0> texture{col_pds} translate<59.165800,-1.537000,13.859200>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-135.000000,0> texture{col_pds} translate<57.928300,-1.537000,15.096700>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<51.077100,-1.537000,16.091800>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<49.327100,-1.537000,16.091800>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<48.006000,-1.537000,17.604000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<48.006000,-1.537000,21.004000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<54.954700,0.000000,13.835500>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<55.308300,0.000000,14.189100>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<55.661800,0.000000,14.542600>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<56.015400,0.000000,14.896200>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<56.368900,0.000000,15.249700>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<56.722500,0.000000,15.603300>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<57.076000,0.000000,15.956800>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<57.429600,0.000000,16.310400>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<57.783100,0.000000,16.663900>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<58.136700,0.000000,17.017500>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<58.490200,0.000000,17.371000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<58.843800,0.000000,17.724600>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<59.197300,0.000000,18.078100>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<59.550900,0.000000,18.431700>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<59.904400,0.000000,18.785200>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<60.258000,0.000000,19.138800>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<60.258000,0.000000,21.755100>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<59.904400,0.000000,22.108700>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<59.550900,0.000000,22.462200>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<59.197300,0.000000,22.815800>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<58.843800,0.000000,23.169300>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<58.490200,0.000000,23.522900>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<58.136700,0.000000,23.876400>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<57.783100,0.000000,24.230000>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<57.429600,0.000000,24.583500>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<57.076000,0.000000,24.937100>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<56.722500,0.000000,25.290600>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<56.368900,0.000000,25.644200>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<56.015400,0.000000,25.997700>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<55.661800,0.000000,26.351300>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<55.308300,0.000000,26.704800>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<54.954700,0.000000,27.058400>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<52.338400,0.000000,27.058400>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<51.984800,0.000000,26.704800>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<51.631300,0.000000,26.351300>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<51.277700,0.000000,25.997700>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<50.924200,0.000000,25.644200>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<50.570600,0.000000,25.290600>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<50.217100,0.000000,24.937100>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<49.863500,0.000000,24.583500>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<49.510000,0.000000,24.230000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<49.156400,0.000000,23.876400>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<48.802900,0.000000,23.522900>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<48.449300,0.000000,23.169300>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<48.095800,0.000000,22.815800>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<47.742200,0.000000,22.462200>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<47.388700,0.000000,22.108700>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<47.035100,0.000000,21.755100>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<47.035100,0.000000,19.138800>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<47.388700,0.000000,18.785200>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<47.742200,0.000000,18.431700>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<48.095800,0.000000,18.078100>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<48.449300,0.000000,17.724600>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<48.802900,0.000000,17.371000>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<49.156400,0.000000,17.017500>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<49.510000,0.000000,16.663900>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<49.863500,0.000000,16.310400>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<50.217100,0.000000,15.956800>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<50.570600,0.000000,15.603300>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<50.924200,0.000000,15.249700>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<51.277700,0.000000,14.896200>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<51.631300,0.000000,14.542600>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<51.984800,0.000000,14.189100>}
object{TOOLS_PCB_SMD(1.600000,0.300000,0.037000,0) rotate<0,-45.000000,0> texture{col_pds} translate<52.338400,0.000000,13.835500>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<68.276000,-1.537000,4.405000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<67.026000,-1.537000,4.405000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<65.776000,-1.537000,4.405000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<64.526000,-1.537000,4.405000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<63.276000,-1.537000,4.405000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<62.026000,-1.537000,4.405000>}
object{TOOLS_PCB_SMD(2.100000,3.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<70.776000,-1.537000,1.280000>}
object{TOOLS_PCB_SMD(2.100000,3.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<59.526000,-1.537000,1.280000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<44.781000,-1.537000,4.151000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<43.531000,-1.537000,4.151000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<42.281000,-1.537000,4.151000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<41.031000,-1.537000,4.151000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<39.781000,-1.537000,4.151000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<38.531000,-1.537000,4.151000>}
object{TOOLS_PCB_SMD(2.100000,3.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<47.281000,-1.537000,1.026000>}
object{TOOLS_PCB_SMD(2.100000,3.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<36.031000,-1.537000,1.026000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<69.520000,0.000000,9.004000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<70.320000,0.000000,9.004000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<71.120000,0.000000,9.004000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<71.920000,0.000000,9.004000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<72.720000,0.000000,9.004000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<68.720000,0.000000,8.204000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<70.320000,0.000000,8.204000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<71.120000,0.000000,8.204000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<71.920000,0.000000,8.204000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<73.520000,0.000000,8.204000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<68.720000,0.000000,7.404000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<69.520000,0.000000,7.404000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<72.720000,0.000000,7.404000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<73.520000,0.000000,7.404000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<68.720000,0.000000,6.604000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<69.520000,0.000000,6.604000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<72.720000,0.000000,6.604000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<73.520000,0.000000,6.604000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<68.720000,0.000000,5.804000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<69.520000,0.000000,5.804000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<72.720000,0.000000,5.804000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<73.520000,0.000000,5.804000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<68.720000,0.000000,5.004000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<70.320000,0.000000,5.004000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<71.120000,0.000000,5.004000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<71.920000,0.000000,5.004000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<73.520000,0.000000,5.004000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<69.520000,0.000000,4.204000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<70.320000,0.000000,4.204000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<71.120000,0.000000,4.204000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<71.920000,0.000000,4.204000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<72.720000,0.000000,4.204000>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<57.343000,-1.537000,23.779100>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<58.293000,-1.537000,23.779100>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<59.243000,-1.537000,23.779100>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<59.243000,-1.537000,21.178900>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<57.343000,-1.537000,21.178900>}
object{TOOLS_PCB_SMD(1.498600,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<54.838600,-1.537000,23.139400>}
object{TOOLS_PCB_SMD(1.498600,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.552600,-1.537000,23.139400>}
object{TOOLS_PCB_SMD(1.498600,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.266600,-1.537000,23.139400>}
object{TOOLS_PCB_SMD(3.810000,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.578000,-1.537000,29.438600>}
object{TOOLS_PCB_SMD(1.498600,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<47.599600,-1.537000,23.139400>}
object{TOOLS_PCB_SMD(1.498600,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<45.313600,-1.537000,23.139400>}
object{TOOLS_PCB_SMD(1.498600,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<43.027600,-1.537000,23.139400>}
object{TOOLS_PCB_SMD(3.810000,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<45.339000,-1.537000,29.438600>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<61.375000,0.000000,1.143000>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<59.275000,0.000000,1.143000>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<56.930000,0.000000,1.143000>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<54.830000,0.000000,1.143000>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<52.358000,0.000000,1.143000>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<50.258000,0.000000,1.143000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,10.160000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,9.525000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,8.890000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,8.255000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,7.620000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,6.985000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,6.350000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,6.350000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,6.985000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,7.620000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,8.255000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,8.890000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,9.525000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,10.160000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.520000,0.000000,18.706000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.520000,0.000000,17.456000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.520000,0.000000,16.206000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.520000,0.000000,14.956000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.520000,0.000000,13.706000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.520000,0.000000,12.456000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.520000,0.000000,11.206000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.520000,0.000000,9.956000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.520000,0.000000,8.706000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.520000,0.000000,7.456000>}
object{TOOLS_PCB_SMD(2.100000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<32.395000,0.000000,21.206000>}
object{TOOLS_PCB_SMD(2.100000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<32.395000,0.000000,4.956000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<42.164000,0.000000,22.772000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<42.164000,0.000000,24.472000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<76.034000,-1.537000,11.303000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<74.334000,-1.537000,11.303000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<76.034000,-1.537000,13.335000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<74.334000,-1.537000,13.335000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<64.897000,0.000000,26.250000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<64.897000,0.000000,24.550000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<76.034000,-1.537000,5.207000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<74.334000,-1.537000,5.207000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<76.034000,-1.537000,3.175000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<74.334000,-1.537000,3.175000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<64.350000,-1.537000,15.367000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<62.650000,-1.537000,15.367000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<62.650000,-1.537000,11.303000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<64.350000,-1.537000,11.303000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<62.650000,-1.537000,13.335000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<64.350000,-1.537000,13.335000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<68.541000,-1.537000,14.605000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<66.841000,-1.537000,14.605000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<71.589000,-1.537000,15.494000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<69.889000,-1.537000,15.494000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<76.796000,-1.537000,25.019000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<75.096000,-1.537000,25.019000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<69.342000,-1.537000,19.392000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<69.342000,-1.537000,17.692000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<76.796000,-1.537000,27.051000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<75.096000,-1.537000,27.051000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<72.175000,-1.537000,25.781000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<73.875000,-1.537000,25.781000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<74.422000,-1.537000,20.613000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<74.422000,-1.537000,22.313000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<71.247000,-1.537000,19.392000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<71.247000,-1.537000,17.692000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<76.327000,-1.537000,17.565000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<76.327000,-1.537000,19.265000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<72.937000,-1.537000,18.669000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<74.637000,-1.537000,18.669000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<70.192000,-1.537000,26.416000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<68.492000,-1.537000,26.416000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<67.437000,-1.537000,19.392000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<67.437000,-1.537000,17.692000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<64.897000,-1.537000,23.075000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<64.897000,-1.537000,21.375000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<65.747000,-1.537000,19.685000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<64.047000,-1.537000,19.685000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.941000,-1.537000,26.455000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<35.941000,-1.537000,28.155000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<37.973000,-1.537000,28.155000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<37.973000,-1.537000,26.455000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<46.482000,0.000000,7.581000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<46.482000,0.000000,5.881000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<49.872000,0.000000,6.223000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<48.172000,0.000000,6.223000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<54.571000,0.000000,4.191000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.871000,0.000000,4.191000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<61.341000,0.000000,9.232000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<61.341000,0.000000,7.532000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<61.341000,0.000000,6.184000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<61.341000,0.000000,4.484000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<64.770000,0.000000,9.613000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<64.770000,0.000000,7.913000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<64.770000,0.000000,6.311000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<64.770000,0.000000,4.611000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<70.319000,0.000000,1.778000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<68.619000,0.000000,1.778000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<67.271000,0.000000,1.778000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<65.571000,0.000000,1.778000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<41.402000,0.000000,7.835000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<41.402000,0.000000,6.135000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<44.196000,0.000000,22.772000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<44.196000,0.000000,24.472000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<39.751000,0.000000,7.835000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<39.751000,0.000000,6.135000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<61.175000,0.000000,0.127000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<59.475000,0.000000,0.127000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<56.730000,0.000000,0.127000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<55.030000,0.000000,0.127000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.158000,0.000000,0.127000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.458000,0.000000,0.127000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<74.549000,0.000000,22.479000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<74.549000,0.000000,23.749000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<74.549000,0.000000,25.019000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<74.549000,0.000000,26.289000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<73.025000,0.000000,27.813000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<71.755000,0.000000,27.813000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<70.485000,0.000000,27.813000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<69.215000,0.000000,27.813000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<67.691000,0.000000,26.289000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<67.691000,0.000000,25.019000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<67.691000,0.000000,23.749000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<67.691000,0.000000,22.479000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<69.215000,0.000000,20.955000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<70.485000,0.000000,20.955000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<71.755000,0.000000,20.955000>}
object{TOOLS_PCB_SMD(0.635000,2.006600,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<73.025000,0.000000,20.955000>}
object{TOOLS_PCB_SMD(1.200000,0.900000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<45.015500,0.000000,13.193200>}
object{TOOLS_PCB_SMD(1.200000,0.900000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<47.631800,0.000000,10.576900>}
object{TOOLS_PCB_SMD(1.200000,0.900000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<49.187400,0.000000,12.132500>}
object{TOOLS_PCB_SMD(1.200000,0.900000,0.037000,0) rotate<0,-315.000000,0> texture{col_pds} translate<46.571100,0.000000,14.748800>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,24.638000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,24.003000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,23.368000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,22.733000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,22.098000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,21.463000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<72.059800,-1.537000,20.828000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,20.828000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,21.463000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,22.098000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,22.733000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,23.368000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,24.003000>}
object{TOOLS_PCB_SMD(0.304800,0.990600,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<66.624200,-1.537000,24.638000>}
object{TOOLS_PCB_SMD(0.381000,1.041400,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<59.474100,0.000000,29.552900>}
object{TOOLS_PCB_SMD(0.381000,1.041400,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<59.474100,0.000000,28.905200>}
object{TOOLS_PCB_SMD(0.381000,1.041400,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<59.474100,0.000000,28.244800>}
object{TOOLS_PCB_SMD(0.381000,1.041400,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<59.474100,0.000000,27.597100>}
object{TOOLS_PCB_SMD(0.381000,1.041400,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<63.715900,0.000000,27.597100>}
object{TOOLS_PCB_SMD(0.381000,1.041400,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<63.715900,0.000000,28.244800>}
object{TOOLS_PCB_SMD(0.381000,1.041400,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<63.715900,0.000000,28.905200>}
object{TOOLS_PCB_SMD(0.381000,1.041400,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<63.715900,0.000000,29.552900>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<61.573000,0.000000,14.183000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<61.573000,0.000000,13.533000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<61.573000,0.000000,12.883000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<61.573000,0.000000,12.233000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<62.398000,0.000000,11.408000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<63.048000,0.000000,11.408000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<63.698000,0.000000,11.408000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<64.348000,0.000000,11.408000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<65.173000,0.000000,12.233000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<65.173000,0.000000,12.883000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<65.173000,0.000000,13.533000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<65.173000,0.000000,14.183000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<64.348000,0.000000,15.008000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<63.698000,0.000000,15.008000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<63.048000,0.000000,15.008000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<62.398000,0.000000,15.008000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,20.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,19.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,19.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,18.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,18.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,17.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,17.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,16.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,16.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,15.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,15.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,14.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,14.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,13.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,13.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,12.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,12.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,11.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,11.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,10.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,10.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,9.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,9.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,8.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,8.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,7.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,7.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,6.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.141000,-1.537000,6.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<34.141000,-1.537000,5.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<37.741000,-1.537000,5.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,6.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,6.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,7.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,7.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,8.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,8.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,9.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,9.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,10.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,10.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,11.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,11.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,12.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,12.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,13.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,13.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,14.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,14.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,15.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,15.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,16.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,16.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,17.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,17.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,18.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,18.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,19.331000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,19.831000>}
object{TOOLS_PCB_SMD(0.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.741000,-1.537000,20.331000>}
object{TOOLS_PCB_SMD(0.350000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<51.558000,0.000000,7.833000>}
object{TOOLS_PCB_SMD(0.350000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<51.558000,0.000000,7.183000>}
object{TOOLS_PCB_SMD(0.350000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<51.558000,0.000000,6.533000>}
object{TOOLS_PCB_SMD(0.350000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<51.558000,0.000000,5.883000>}
object{TOOLS_PCB_SMD(0.350000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<57.408000,0.000000,5.883000>}
object{TOOLS_PCB_SMD(0.350000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<57.408000,0.000000,6.533000>}
object{TOOLS_PCB_SMD(0.350000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<57.408000,0.000000,7.183000>}
object{TOOLS_PCB_SMD(0.350000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<57.408000,0.000000,7.833000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<44.781000,0.000000,26.329000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<43.531000,0.000000,26.329000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<42.281000,0.000000,26.329000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<41.031000,0.000000,26.329000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<39.781000,0.000000,26.329000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<38.531000,0.000000,26.329000>}
object{TOOLS_PCB_SMD(2.100000,3.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<47.281000,0.000000,29.454000>}
object{TOOLS_PCB_SMD(2.100000,3.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<36.031000,0.000000,29.454000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<38.531000,0.000000,4.151000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<39.781000,0.000000,4.151000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.031000,0.000000,4.151000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<42.281000,0.000000,4.151000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<43.531000,0.000000,4.151000>}
object{TOOLS_PCB_SMD(0.800000,2.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<44.781000,0.000000,4.151000>}
object{TOOLS_PCB_SMD(2.100000,3.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<36.031000,0.000000,1.026000>}
object{TOOLS_PCB_SMD(2.100000,3.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<47.281000,0.000000,1.026000>}
#ifndef(global_pack_X6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.008000,0.500000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<34.778000,0,25.136000> texture{col_thl}}
#ifndef(global_pack_X6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.008000,0.500000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<34.778000,0,23.886000> texture{col_thl}}
object{TOOLS_PCB_SMD(0.635000,2.540000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<69.596000,0.000000,15.240000>}
object{TOOLS_PCB_SMD(7.620000,2.540000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<74.676000,0.000000,15.240000>}
object{TOOLS_PCB_SMD(0.635000,2.540000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<67.056000,0.000000,15.240000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<78.359000,0.000000,10.160000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<78.359000,0.000000,18.288000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<78.359000,0.000000,11.430000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<78.486000,0.000000,6.985000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<78.359000,0.000000,17.018000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<78.359000,0.000000,22.479000>}
//Pads/Vias
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<75.819000,0,21.844000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<74.676000,0,8.255000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<77.343000,0,10.160000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<53.086000,0,18.796000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<53.086000,0,17.907000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<51.943000,0,18.796000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<51.943000,0,17.907000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<41.783000,0,1.905000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<42.291000,0,27.559000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<59.309000,0,15.621000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<62.103000,0,21.590000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<44.196000,0,8.001000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<43.307000,0,27.559000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<48.133000,0,26.543000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<54.356000,0,23.876000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<46.863000,0,27.432000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<54.737000,0,24.638000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<41.656000,0,28.194000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<76.962000,0,3.556000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<68.961000,0,23.749000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<73.025000,0,29.083000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<62.103000,0,23.114000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<58.420000,0,29.591000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<66.421000,0,3.429000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<42.545000,0,2.540000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<33.147000,0,23.876000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<32.512000,0,23.114000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<31.369000,0,23.114000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<36.322000,0,23.876000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<35.814000,0,23.114000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<36.703000,0,23.114000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<38.227000,0,20.828000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<37.465000,0,20.828000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<41.402000,0,18.796000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<42.037000,0,18.796000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<42.037000,0,18.161000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<41.402000,0,18.161000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<40.767000,0,18.796000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<49.530000,0,18.669000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<50.673000,0,17.780000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<41.021000,0,27.559000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<58.420000,0,25.654000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<32.639000,0,17.272000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<31.750000,0,17.272000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<32.639000,0,20.320000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<31.750000,0,20.320000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<34.798000,0,23.876000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<32.004000,0,23.876000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<33.655000,0,23.114000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<52.959000,0,13.335000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<72.898000,0,17.653000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<63.754000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<57.658000,0,27.178000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<57.023000,0,30.226000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<57.785000,0,26.289000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<76.962000,0,6.096000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<77.343000,0,11.430000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<77.343000,0,6.985000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<75.692000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<76.581000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<69.596000,0,22.606000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<75.438000,0,17.653000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<76.835000,0,26.289000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<66.421000,0,26.289000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<46.990000,0,16.002000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<47.752000,0,15.494000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<53.594000,0,10.414000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<48.514000,0,14.986000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<36.195000,0,25.146000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<33.274000,0,25.146000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<32.385000,0,25.146000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<45.720000,0,26.162000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<32.258000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<32.385000,-1.535000,25.146000>}
box{<0,0,-0.508000><0.127000,0.035000,0.508000> rotate<0,0.000000,0> translate<32.258000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<32.385000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<32.512000,-1.535000,25.146000>}
box{<0,0,-0.508000><0.127000,0.035000,0.508000> rotate<0,0.000000,0> translate<32.385000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<32.385000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<32.512000,-1.535000,25.146000>}
box{<0,0,-0.508000><0.127000,0.035000,0.508000> rotate<0,0.000000,0> translate<32.385000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.639000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.650000,-1.535000,20.331000>}
box{<0,0,-0.152400><0.015556,0.035000,0.152400> rotate<0,-44.997030,0> translate<32.639000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.639000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.825000,-1.535000,17.331000>}
box{<0,0,-0.152400><0.195133,0.035000,0.152400> rotate<0,-17.598090,0> translate<32.639000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<32.512000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.274000,-1.535000,25.146000>}
box{<0,0,-0.508000><0.762000,0.035000,0.508000> rotate<0,0.000000,0> translate<32.512000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.639000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.130000,-1.535000,20.320000>}
box{<0,0,-0.152400><1.491000,0.035000,0.152400> rotate<0,0.000000,0> translate<32.639000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,5.831000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,6.328000>}
box{<0,0,-0.101600><0.497000,0.035000,0.101600> rotate<0,90.000000,0> translate<34.141000,-1.535000,6.328000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,6.836000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,6.831000>}
box{<0,0,-0.101600><0.005000,0.035000,0.101600> rotate<0,-90.000000,0> translate<34.141000,-1.535000,6.831000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,6.331000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,6.836000>}
box{<0,0,-0.101600><0.505000,0.035000,0.101600> rotate<0,90.000000,0> translate<34.141000,-1.535000,6.836000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.825000,-1.535000,17.331000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.141000,-1.535000,17.331000>}
box{<0,0,-0.152400><1.316000,0.035000,0.152400> rotate<0,0.000000,0> translate<32.825000,-1.535000,17.331000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.130000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.141000,-1.535000,20.331000>}
box{<0,0,-0.152400><0.015556,0.035000,0.152400> rotate<0,-44.997030,0> translate<34.130000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,6.328000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.144000,-1.535000,6.331000>}
box{<0,0,-0.101600><0.004243,0.035000,0.101600> rotate<0,-44.997030,0> translate<34.141000,-1.535000,6.328000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,6.331000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.144000,-1.535000,6.331000>}
box{<0,0,-0.101600><0.003000,0.035000,0.101600> rotate<0,0.000000,0> translate<34.141000,-1.535000,6.331000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.144000,-1.535000,6.331000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.163000,-1.535000,6.350000>}
box{<0,0,-0.101600><0.026870,0.035000,0.101600> rotate<0,-44.997030,0> translate<34.144000,-1.535000,6.331000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,6.836000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.163000,-1.535000,6.858000>}
box{<0,0,-0.101600><0.031113,0.035000,0.101600> rotate<0,-44.997030,0> translate<34.141000,-1.535000,6.836000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.778000,-0.000000,25.136000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.788000,-0.000000,25.136000>}
box{<0,0,-0.203200><0.010000,0.035000,0.203200> rotate<0,0.000000,0> translate<34.778000,-0.000000,25.136000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.778000,-1.535000,25.136000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.788000,-1.535000,25.136000>}
box{<0,0,-0.508000><0.010000,0.035000,0.508000> rotate<0,0.000000,0> translate<34.778000,-1.535000,25.136000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.798000,-0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.798000,-0.000000,22.987000>}
box{<0,0,-0.203200><0.508000,0.035000,0.203200> rotate<0,-90.000000,0> translate<34.798000,-0.000000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.762000 translate<31.496000,-0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.762000 translate<34.798000,-0.000000,23.495000>}
box{<0,0,-0.762000><3.302000,0.035000,0.762000> rotate<0,0.000000,0> translate<31.496000,-0.000000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.798000,-0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.798000,-0.000000,23.876000>}
box{<0,0,-0.203200><0.381000,0.035000,0.203200> rotate<0,90.000000,0> translate<34.798000,-0.000000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.274000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.798000,-1.535000,25.146000>}
box{<0,0,-0.508000><1.524000,0.035000,0.508000> rotate<0,0.000000,0> translate<33.274000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.788000,-1.535000,25.136000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.798000,-1.535000,25.146000>}
box{<0,0,-0.508000><0.014142,0.035000,0.508000> rotate<0,-44.997030,0> translate<34.788000,-1.535000,25.136000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.798000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.925000,-1.535000,25.146000>}
box{<0,0,-0.508000><0.127000,0.035000,0.508000> rotate<0,0.000000,0> translate<34.798000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.925000,-1.535000,25.273000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.925000,-1.535000,25.146000>}
box{<0,0,-0.101600><0.127000,0.035000,0.101600> rotate<0,-90.000000,0> translate<34.925000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.798000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.925000,-1.535000,25.273000>}
box{<0,0,-0.101600><0.179605,0.035000,0.101600> rotate<0,-44.997030,0> translate<34.798000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.925000,-1.535000,25.273000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.925000,-1.535000,27.432000>}
box{<0,0,-0.101600><2.159000,0.035000,0.101600> rotate<0,90.000000,0> translate<34.925000,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,7.831000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.095000,-1.535000,7.831000>}
box{<0,0,-0.101600><0.954000,0.035000,0.101600> rotate<0,0.000000,0> translate<34.141000,-1.535000,7.831000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.788000,-0.000000,25.136000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.179000,-0.000000,25.527000>}
box{<0,0,-0.203200><0.552958,0.035000,0.203200> rotate<0,-44.997030,0> translate<34.788000,-0.000000,25.136000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.141000,-1.535000,15.331000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.215000,-1.535000,15.331000>}
box{<0,0,-0.101600><1.074000,0.035000,0.101600> rotate<0,0.000000,0> translate<34.141000,-1.535000,15.331000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.095000,-1.535000,7.831000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.306000,-1.535000,7.620000>}
box{<0,0,-0.101600><0.298399,0.035000,0.101600> rotate<0,44.997030,0> translate<35.095000,-1.535000,7.831000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.306000,-1.535000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.306000,-1.535000,7.620000>}
box{<0,0,-0.101600><2.286000,0.035000,0.101600> rotate<0,90.000000,0> translate<35.306000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.520000,-0.000000,17.456000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.520000,-0.000000,17.486000>}
box{<0,0,-0.101600><0.030000,0.035000,0.101600> rotate<0,90.000000,0> translate<35.520000,-0.000000,17.486000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.520000,-0.000000,18.706000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.523000,-0.000000,18.706000>}
box{<0,0,-0.101600><0.003000,0.035000,0.101600> rotate<0,0.000000,0> translate<35.520000,-0.000000,18.706000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.520000,-0.000000,13.706000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.530000,-0.000000,13.716000>}
box{<0,0,-0.101600><0.014142,0.035000,0.101600> rotate<0,-44.997030,0> translate<35.520000,-0.000000,13.706000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.520000,-0.000000,14.956000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.550000,-0.000000,14.986000>}
box{<0,0,-0.101600><0.042426,0.035000,0.101600> rotate<0,-44.997030,0> translate<35.520000,-0.000000,14.956000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.520000,-0.000000,17.486000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.560000,-0.000000,17.526000>}
box{<0,0,-0.101600><0.056569,0.035000,0.101600> rotate<0,-44.997030,0> translate<35.520000,-0.000000,17.486000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.523000,-0.000000,18.706000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.560000,-0.000000,18.669000>}
box{<0,0,-0.101600><0.052326,0.035000,0.101600> rotate<0,44.997030,0> translate<35.523000,-0.000000,18.706000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<34.925000,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.648000,-1.535000,28.155000>}
box{<0,0,-0.101600><1.022476,0.035000,0.101600> rotate<0,-44.997030,0> translate<34.925000,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.215000,-1.535000,15.331000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.687000,-1.535000,14.859000>}
box{<0,0,-0.101600><0.667509,0.035000,0.101600> rotate<0,44.997030,0> translate<35.215000,-1.535000,15.331000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.687000,-1.535000,5.588000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.687000,-1.535000,14.859000>}
box{<0,0,-0.101600><9.271000,0.035000,0.101600> rotate<0,90.000000,0> translate<35.687000,-1.535000,14.859000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.648000,-1.535000,28.155000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.941000,-1.535000,28.155000>}
box{<0,0,-0.101600><0.293000,0.035000,0.101600> rotate<0,0.000000,0> translate<35.648000,-1.535000,28.155000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.560000,-0.000000,18.669000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.068000,-0.000000,18.669000>}
box{<0,0,-0.101600><0.508000,0.035000,0.101600> rotate<0,0.000000,0> translate<35.560000,-0.000000,18.669000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.798000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<36.195000,-1.535000,25.146000>}
box{<0,0,-0.508000><1.397000,0.035000,0.508000> rotate<0,0.000000,0> translate<34.798000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.520000,-0.000000,16.206000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.272000,-0.000000,16.206000>}
box{<0,0,-0.101600><0.752000,0.035000,0.101600> rotate<0,0.000000,0> translate<35.520000,-0.000000,16.206000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.530000,-0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.322000,-0.000000,13.716000>}
box{<0,0,-0.101600><0.792000,0.035000,0.101600> rotate<0,0.000000,0> translate<35.530000,-0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.550000,-0.000000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.322000,-0.000000,14.986000>}
box{<0,0,-0.101600><0.772000,0.035000,0.101600> rotate<0,0.000000,0> translate<35.550000,-0.000000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.560000,-0.000000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.322000,-0.000000,17.526000>}
box{<0,0,-0.101600><0.762000,0.035000,0.101600> rotate<0,0.000000,0> translate<35.560000,-0.000000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.068000,-0.000000,18.669000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.322000,-0.000000,18.923000>}
box{<0,0,-0.101600><0.359210,0.035000,0.101600> rotate<0,-44.997030,0> translate<36.068000,-0.000000,18.669000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.322000,-0.000000,18.923000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.322000,-0.000000,21.717000>}
box{<0,0,-0.101600><2.794000,0.035000,0.101600> rotate<0,90.000000,0> translate<36.322000,-0.000000,21.717000> }
cylinder{<0,0,0><0,0.035000,0>0.762000 translate<31.496000,-0.000000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.762000 translate<36.419000,-0.000000,25.527000>}
box{<0,0,-0.762000><4.923000,0.035000,0.762000> rotate<0,0.000000,0> translate<31.496000,-0.000000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.179000,-0.000000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.419000,-0.000000,25.527000>}
box{<0,0,-0.203200><1.240000,0.035000,0.203200> rotate<0,0.000000,0> translate<35.179000,-0.000000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.762000 translate<34.798000,-0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.762000 translate<36.449000,-0.000000,23.495000>}
box{<0,0,-0.762000><1.651000,0.035000,0.762000> rotate<0,0.000000,0> translate<34.798000,-0.000000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.830000,-0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.830000,-0.000000,21.463000>}
box{<0,0,-0.101600><1.143000,0.035000,0.101600> rotate<0,90.000000,0> translate<36.830000,-0.000000,21.463000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.322000,-0.000000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.957000,-0.000000,18.161000>}
box{<0,0,-0.101600><0.898026,0.035000,0.101600> rotate<0,-44.997030,0> translate<36.322000,-0.000000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.830000,-0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.957000,-0.000000,20.193000>}
box{<0,0,-0.101600><0.179605,0.035000,0.101600> rotate<0,44.997030,0> translate<36.830000,-0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.957000,-0.000000,18.161000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.957000,-0.000000,20.193000>}
box{<0,0,-0.101600><2.032000,0.035000,0.101600> rotate<0,90.000000,0> translate<36.957000,-0.000000,20.193000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.687000,-1.535000,5.588000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.084000,-1.535000,4.191000>}
box{<0,0,-0.101600><1.975656,0.035000,0.101600> rotate<0,44.997030,0> translate<35.687000,-1.535000,5.588000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.272000,-0.000000,16.206000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.592000,-0.000000,17.526000>}
box{<0,0,-0.101600><1.866762,0.035000,0.101600> rotate<0,-44.997030,0> translate<36.272000,-0.000000,16.206000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.592000,-0.000000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.592000,-0.000000,19.304000>}
box{<0,0,-0.101600><1.778000,0.035000,0.101600> rotate<0,90.000000,0> translate<37.592000,-0.000000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.719000,-1.535000,20.331000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.741000,-1.535000,20.331000>}
box{<0,0,-0.152400><0.022000,0.035000,0.152400> rotate<0,0.000000,0> translate<37.719000,-1.535000,20.331000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.741000,-1.535000,19.831000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.827000,-1.535000,19.831000>}
box{<0,0,-0.101600><0.086000,0.035000,0.101600> rotate<0,0.000000,0> translate<37.741000,-1.535000,19.831000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.827000,-1.535000,19.831000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.846000,-1.535000,19.812000>}
box{<0,0,-0.101600><0.026870,0.035000,0.101600> rotate<0,44.997030,0> translate<37.827000,-1.535000,19.831000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.941000,-1.535000,26.455000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.934000,-1.535000,26.455000>}
box{<0,0,-0.101600><1.993000,0.035000,0.101600> rotate<0,0.000000,0> translate<35.941000,-1.535000,26.455000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.934000,-1.535000,26.455000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.973000,-1.535000,26.416000>}
box{<0,0,-0.101600><0.055154,0.035000,0.101600> rotate<0,44.997030,0> translate<37.934000,-1.535000,26.455000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.973000,-1.535000,26.455000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.973000,-1.535000,26.416000>}
box{<0,0,-0.101600><0.039000,0.035000,0.101600> rotate<0,-90.000000,0> translate<37.973000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.973000,-1.535000,28.155000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.012000,-1.535000,28.194000>}
box{<0,0,-0.101600><0.055154,0.035000,0.101600> rotate<0,-44.997030,0> translate<37.973000,-1.535000,28.155000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.322000,-0.000000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.227000,-0.000000,16.891000>}
box{<0,0,-0.101600><2.694077,0.035000,0.101600> rotate<0,-44.997030,0> translate<36.322000,-0.000000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.227000,-0.000000,16.891000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.227000,-0.000000,19.304000>}
box{<0,0,-0.101600><2.413000,0.035000,0.101600> rotate<0,90.000000,0> translate<38.227000,-0.000000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<35.306000,-1.535000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.354000,-1.535000,2.286000>}
box{<0,0,-0.101600><4.310523,0.035000,0.101600> rotate<0,44.997030,0> translate<35.306000,-1.535000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.354000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.354000,-1.535000,25.136000>}
box{<0,0,-0.508000><0.010000,0.035000,0.508000> rotate<0,-90.000000,0> translate<38.354000,-1.535000,25.136000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<36.195000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.354000,-1.535000,25.146000>}
box{<0,0,-0.508000><2.159000,0.035000,0.508000> rotate<0,0.000000,0> translate<36.195000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.354000,-1.535000,25.136000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.364000,-1.535000,25.136000>}
box{<0,0,-0.508000><0.010000,0.035000,0.508000> rotate<0,0.000000,0> translate<38.354000,-1.535000,25.136000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.084000,-1.535000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.481000,-1.535000,4.191000>}
box{<0,0,-0.101600><1.397000,0.035000,0.101600> rotate<0,0.000000,0> translate<37.084000,-1.535000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.481000,-1.535000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.521000,-1.535000,4.151000>}
box{<0,0,-0.101600><0.056569,0.035000,0.101600> rotate<0,44.997030,0> translate<38.481000,-1.535000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.521000,-1.535000,4.151000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.531000,-1.535000,4.151000>}
box{<0,0,-0.101600><0.010000,0.035000,0.101600> rotate<0,0.000000,0> translate<38.521000,-1.535000,4.151000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.531000,-0.000000,4.151000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.531000,-0.000000,8.432000>}
box{<0,0,-0.101600><4.281000,0.035000,0.101600> rotate<0,90.000000,0> translate<38.531000,-0.000000,8.432000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.322000,-0.000000,21.717000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.531000,-0.000000,23.926000>}
box{<0,0,-0.101600><3.123998,0.035000,0.101600> rotate<0,-44.997030,0> translate<36.322000,-0.000000,21.717000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.531000,-0.000000,26.339000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.531000,-0.000000,26.329000>}
box{<0,0,-0.101600><0.010000,0.035000,0.101600> rotate<0,-90.000000,0> translate<38.531000,-0.000000,26.329000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.531000,-0.000000,23.926000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.531000,-0.000000,26.339000>}
box{<0,0,-0.101600><2.413000,0.035000,0.101600> rotate<0,90.000000,0> translate<38.531000,-0.000000,26.339000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.531000,-0.000000,26.339000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.608000,-0.000000,26.416000>}
box{<0,0,-0.101600><0.108894,0.035000,0.101600> rotate<0,-44.997030,0> translate<38.531000,-0.000000,26.339000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.608000,-0.000000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.608000,-0.000000,27.178000>}
box{<0,0,-0.101600><0.762000,0.035000,0.101600> rotate<0,90.000000,0> translate<38.608000,-0.000000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.322000,-0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.735000,-0.000000,16.129000>}
box{<0,0,-0.101600><3.412497,0.035000,0.101600> rotate<0,-44.997030,0> translate<36.322000,-0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.735000,-0.000000,16.129000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.735000,-0.000000,19.050000>}
box{<0,0,-0.101600><2.921000,0.035000,0.101600> rotate<0,90.000000,0> translate<38.735000,-0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.846000,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.735000,-1.535000,19.812000>}
box{<0,0,-0.101600><0.889000,0.035000,0.101600> rotate<0,0.000000,0> translate<37.846000,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.531000,-0.000000,8.432000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.862000,-0.000000,8.763000>}
box{<0,0,-0.101600><0.468105,0.035000,0.101600> rotate<0,-44.997030,0> translate<38.531000,-0.000000,8.432000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.741000,-1.535000,17.331000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.930000,-1.535000,17.331000>}
box{<0,0,-0.101600><1.189000,0.035000,0.101600> rotate<0,0.000000,0> translate<37.741000,-1.535000,17.331000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.735000,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.116000,-1.535000,19.431000>}
box{<0,0,-0.101600><0.538815,0.035000,0.101600> rotate<0,44.997030,0> translate<38.735000,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.116000,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.116000,-1.535000,19.431000>}
box{<0,0,-0.101600><1.397000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.116000,-1.535000,19.431000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.592000,-0.000000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.116000,-0.000000,20.828000>}
box{<0,0,-0.101600><2.155261,0.035000,0.101600> rotate<0,-44.997030,0> translate<37.592000,-0.000000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.830000,-0.000000,21.463000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.116000,-0.000000,23.749000>}
box{<0,0,-0.101600><3.232892,0.035000,0.101600> rotate<0,-44.997030,0> translate<36.830000,-0.000000,21.463000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.116000,-0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.116000,-0.000000,25.019000>}
box{<0,0,-0.101600><1.270000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.116000,-0.000000,25.019000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.930000,-1.535000,17.331000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.370000,-1.535000,16.891000>}
box{<0,0,-0.101600><0.622254,0.035000,0.101600> rotate<0,44.997030,0> translate<38.930000,-1.535000,17.331000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.370000,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.370000,-1.535000,16.891000>}
box{<0,0,-0.101600><9.525000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.370000,-1.535000,16.891000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.227000,-0.000000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.370000,-0.000000,20.447000>}
box{<0,0,-0.101600><1.616446,0.035000,0.101600> rotate<0,-44.997030,0> translate<38.227000,-0.000000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,4.181000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,6.135000>}
box{<0,0,-0.101600><1.954000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.751000,-0.000000,6.135000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.370000,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-1.535000,6.985000>}
box{<0,0,-0.101600><0.538815,0.035000,0.101600> rotate<0,44.997030,0> translate<39.370000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-1.535000,6.985000>}
box{<0,0,-0.101600><2.667000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.751000,-1.535000,6.985000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.735000,-0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,20.066000>}
box{<0,0,-0.101600><1.436841,0.035000,0.101600> rotate<0,-44.997030,0> translate<38.735000,-0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.116000,-0.000000,25.019000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,25.654000>}
box{<0,0,-0.101600><0.898026,0.035000,0.101600> rotate<0,-44.997030,0> translate<39.116000,-0.000000,25.019000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,26.299000>}
box{<0,0,-0.101600><0.645000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.751000,-0.000000,26.299000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,27.559000>}
box{<0,0,-0.101600><1.143000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.751000,-0.000000,27.559000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,4.181000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-0.000000,4.151000>}
box{<0,0,-0.101600><0.042426,0.035000,0.101600> rotate<0,44.997030,0> translate<39.751000,-0.000000,4.181000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-1.535000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-1.535000,4.161000>}
box{<0,0,-0.101600><0.042426,0.035000,0.101600> rotate<0,44.997030,0> translate<39.751000,-1.535000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-1.535000,4.151000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-1.535000,4.161000>}
box{<0,0,-0.101600><0.010000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.781000,-1.535000,4.161000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-1.535000,4.288000>}
box{<0,0,-0.101600><0.042426,0.035000,0.101600> rotate<0,44.997030,0> translate<39.751000,-1.535000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-1.535000,4.151000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-1.535000,4.288000>}
box{<0,0,-0.101600><0.137000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.781000,-1.535000,4.288000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,26.299000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-0.000000,26.329000>}
box{<0,0,-0.101600><0.042426,0.035000,0.101600> rotate<0,-44.997030,0> translate<39.751000,-0.000000,26.299000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-0.000000,26.386000>}
box{<0,0,-0.101600><0.042426,0.035000,0.101600> rotate<0,44.997030,0> translate<39.751000,-0.000000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-0.000000,26.329000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.781000,-0.000000,26.386000>}
box{<0,0,-0.101600><0.057000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.781000,-0.000000,26.386000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.116000,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.878000,-1.535000,17.272000>}
box{<0,0,-0.101600><1.077631,0.035000,0.101600> rotate<0,44.997030,0> translate<39.116000,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.878000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.878000,-1.535000,17.272000>}
box{<0,0,-0.101600><9.652000,0.035000,0.101600> rotate<0,90.000000,0> translate<39.878000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<37.973000,-1.535000,26.455000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.966000,-1.535000,26.455000>}
box{<0,0,-0.101600><1.993000,0.035000,0.101600> rotate<0,0.000000,0> translate<37.973000,-1.535000,26.455000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.354000,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.005000,-1.535000,2.286000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<38.354000,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.966000,-1.535000,26.455000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.005000,-1.535000,26.416000>}
box{<0,0,-0.101600><0.055154,0.035000,0.101600> rotate<0,44.997030,0> translate<39.966000,-1.535000,26.455000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.005000,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.005000,-1.535000,26.430000>}
box{<0,0,-0.101600><0.014000,0.035000,0.101600> rotate<0,90.000000,0> translate<40.005000,-1.535000,26.430000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.012000,-1.535000,28.194000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.005000,-1.535000,28.194000>}
box{<0,0,-0.101600><1.993000,0.035000,0.101600> rotate<0,0.000000,0> translate<38.012000,-1.535000,28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.005000,-1.535000,28.180000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.005000,-1.535000,28.194000>}
box{<0,0,-0.101600><0.014000,0.035000,0.101600> rotate<0,90.000000,0> translate<40.005000,-1.535000,28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.132000,-0.000000,24.511000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.169200,-0.000000,24.473800>}
box{<0,0,-0.101600><0.052609,0.035000,0.101600> rotate<0,44.997030,0> translate<40.132000,-0.000000,24.511000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.169200,-0.000000,24.459800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.169200,-0.000000,24.473800>}
box{<0,0,-0.101600><0.014000,0.035000,0.101600> rotate<0,90.000000,0> translate<40.169200,-0.000000,24.473800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.169200,-0.000000,22.709800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.171000,-0.000000,22.733000>}
box{<0,0,-0.101600><0.023270,0.035000,0.101600> rotate<0,-85.557879,0> translate<40.169200,-0.000000,22.709800> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.259000,-1.535000,20.193000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.259000,-1.535000,20.469000>}
box{<0,0,-0.508000><0.276000,0.035000,0.508000> rotate<0,90.000000,0> translate<40.259000,-1.535000,20.469000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.259000,-1.535000,23.241000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.259000,-1.535000,23.219000>}
box{<0,0,-0.508000><0.022000,0.035000,0.508000> rotate<0,-90.000000,0> translate<40.259000,-1.535000,23.219000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.364000,-1.535000,25.136000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.259000,-1.535000,23.241000>}
box{<0,0,-0.508000><2.679935,0.035000,0.508000> rotate<0,44.997030,0> translate<38.364000,-1.535000,25.136000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.608000,-0.000000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.259000,-0.000000,28.829000>}
box{<0,0,-0.101600><2.334867,0.035000,0.101600> rotate<0,-44.997030,0> translate<38.608000,-0.000000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.259000,-1.535000,23.219000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.281000,-1.535000,23.241000>}
box{<0,0,-0.508000><0.031113,0.035000,0.508000> rotate<0,-44.997030,0> translate<40.259000,-1.535000,23.219000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.005000,-1.535000,26.430000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.298000,-1.535000,26.162000>}
box{<0,0,-0.101600><0.397081,0.035000,0.101600> rotate<0,42.445599,0> translate<40.005000,-1.535000,26.430000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,27.559000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.386000,-0.000000,28.194000>}
box{<0,0,-0.101600><0.898026,0.035000,0.101600> rotate<0,-44.997030,0> translate<39.751000,-0.000000,27.559000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.005000,-1.535000,28.180000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.425000,-1.535000,28.155000>}
box{<0,0,-0.101600><0.420743,0.035000,0.101600> rotate<0,3.406219,0> translate<40.005000,-1.535000,28.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.640000,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.640000,-1.535000,14.136000>}
box{<0,0,-0.203200><3.468000,0.035000,0.203200> rotate<0,90.000000,0> translate<40.640000,-1.535000,14.136000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.005000,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-1.535000,3.302000>}
box{<0,0,-0.101600><1.436841,0.035000,0.101600> rotate<0,-44.997030,0> translate<40.005000,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,2.667000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,4.161000>}
box{<0,0,-0.101600><1.494000,0.035000,0.101600> rotate<0,90.000000,0> translate<41.021000,-0.000000,4.161000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-1.535000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-1.535000,4.191000>}
box{<0,0,-0.101600><0.889000,0.035000,0.101600> rotate<0,90.000000,0> translate<41.021000,-1.535000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,4.161000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,5.754000>}
box{<0,0,-0.101600><1.593000,0.035000,0.101600> rotate<0,90.000000,0> translate<41.021000,-0.000000,5.754000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.862000,-0.000000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,8.763000>}
box{<0,0,-0.101600><2.159000,0.035000,0.101600> rotate<0,0.000000,0> translate<38.862000,-0.000000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.132000,-0.000000,24.511000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,25.400000>}
box{<0,0,-0.101600><1.257236,0.035000,0.101600> rotate<0,-44.997030,0> translate<40.132000,-0.000000,24.511000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,26.339000>}
box{<0,0,-0.101600><0.939000,0.035000,0.101600> rotate<0,90.000000,0> translate<41.021000,-0.000000,26.339000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.425000,-1.535000,28.155000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-1.535000,27.559000>}
box{<0,0,-0.101600><0.842871,0.035000,0.101600> rotate<0,44.997030,0> translate<40.425000,-1.535000,28.155000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,26.339000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,27.559000>}
box{<0,0,-0.101600><1.220000,0.035000,0.101600> rotate<0,90.000000,0> translate<41.021000,-0.000000,27.559000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,4.161000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.031000,-0.000000,4.151000>}
box{<0,0,-0.101600><0.014142,0.035000,0.101600> rotate<0,44.997030,0> translate<41.021000,-0.000000,4.161000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.031000,-1.535000,4.181000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.031000,-1.535000,4.151000>}
box{<0,0,-0.101600><0.030000,0.035000,0.101600> rotate<0,-90.000000,0> translate<41.031000,-1.535000,4.151000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-1.535000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.031000,-1.535000,4.181000>}
box{<0,0,-0.101600><0.014142,0.035000,0.101600> rotate<0,44.997030,0> translate<41.021000,-1.535000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,26.339000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.031000,-0.000000,26.329000>}
box{<0,0,-0.101600><0.014142,0.035000,0.101600> rotate<0,44.997030,0> translate<41.021000,-0.000000,26.339000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,6.135000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,6.096000>}
box{<0,0,-0.101600><0.039000,0.035000,0.101600> rotate<0,-90.000000,0> translate<41.402000,-0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,5.754000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,6.135000>}
box{<0,0,-0.101600><0.538815,0.035000,0.101600> rotate<0,-44.997030,0> translate<41.021000,-0.000000,5.754000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,7.835000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,6.184000>}
box{<0,0,-0.101600><2.334867,0.035000,0.101600> rotate<0,44.997030,0> translate<39.751000,-0.000000,7.835000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,6.135000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,6.184000>}
box{<0,0,-0.101600><0.049000,0.035000,0.101600> rotate<0,90.000000,0> translate<41.402000,-0.000000,6.184000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,7.835000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,7.747000>}
box{<0,0,-0.101600><0.088000,0.035000,0.101600> rotate<0,-90.000000,0> translate<41.402000,-0.000000,7.747000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,8.382000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,7.835000>}
box{<0,0,-0.101600><0.547000,0.035000,0.101600> rotate<0,-90.000000,0> translate<41.402000,-0.000000,7.835000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,8.382000>}
box{<0,0,-0.101600><0.538815,0.035000,0.101600> rotate<0,44.997030,0> translate<41.021000,-0.000000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.386000,-0.000000,28.194000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.656000,-0.000000,28.194000>}
box{<0,0,-0.101600><1.270000,0.035000,0.101600> rotate<0,0.000000,0> translate<40.386000,-0.000000,28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.021000,-0.000000,2.667000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.783000,-0.000000,1.905000>}
box{<0,0,-0.101600><1.077631,0.035000,0.101600> rotate<0,44.997030,0> translate<41.021000,-0.000000,2.667000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.171000,-0.000000,22.733000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.164000,-0.000000,22.733000>}
box{<0,0,-0.101600><1.993000,0.035000,0.101600> rotate<0,0.000000,0> translate<40.171000,-0.000000,22.733000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.164000,-0.000000,22.733000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.164000,-0.000000,22.772000>}
box{<0,0,-0.101600><0.039000,0.035000,0.101600> rotate<0,90.000000,0> translate<42.164000,-0.000000,22.772000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.164000,-0.000000,24.472000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.164000,-0.000000,26.212000>}
box{<0,0,-0.101600><1.740000,0.035000,0.101600> rotate<0,90.000000,0> translate<42.164000,-0.000000,26.212000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.281000,-1.535000,4.151000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.281000,-1.535000,4.181000>}
box{<0,0,-0.101600><0.030000,0.035000,0.101600> rotate<0,90.000000,0> translate<42.281000,-1.535000,4.181000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,4.161000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,2.794000>}
box{<0,0,-0.101600><1.367000,0.035000,0.101600> rotate<0,-90.000000,0> translate<42.291000,-0.000000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.281000,-0.000000,4.151000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,4.161000>}
box{<0,0,-0.101600><0.014142,0.035000,0.101600> rotate<0,-44.997030,0> translate<42.281000,-0.000000,4.151000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.281000,-1.535000,4.181000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-1.535000,4.191000>}
box{<0,0,-0.101600><0.014142,0.035000,0.101600> rotate<0,-44.997030,0> translate<42.281000,-1.535000,4.181000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,4.161000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,4.865000>}
box{<0,0,-0.101600><0.704000,0.035000,0.101600> rotate<0,90.000000,0> translate<42.291000,-0.000000,4.865000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.878000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-1.535000,5.207000>}
box{<0,0,-0.101600><3.412497,0.035000,0.101600> rotate<0,44.997030,0> translate<39.878000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-1.535000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-1.535000,5.207000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,90.000000,0> translate<42.291000,-1.535000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.164000,-0.000000,26.212000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,26.339000>}
box{<0,0,-0.101600><0.179605,0.035000,0.101600> rotate<0,-44.997030,0> translate<42.164000,-0.000000,26.212000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.281000,-0.000000,26.329000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,26.339000>}
box{<0,0,-0.101600><0.014142,0.035000,0.101600> rotate<0,-44.997030,0> translate<42.281000,-0.000000,26.329000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,26.339000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,27.559000>}
box{<0,0,-0.101600><1.220000,0.035000,0.101600> rotate<0,90.000000,0> translate<42.291000,-0.000000,27.559000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.164000,-0.000000,24.472000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.330000,-0.000000,24.472000>}
box{<0,0,-0.101600><0.166000,0.035000,0.101600> rotate<0,0.000000,0> translate<42.164000,-0.000000,24.472000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.545000,-0.000000,2.540000>}
box{<0,0,-0.101600><0.359210,0.035000,0.101600> rotate<0,44.997030,0> translate<42.291000,-0.000000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.164000,-0.000000,22.733000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.545000,-0.000000,22.733000>}
box{<0,0,-0.101600><0.381000,0.035000,0.101600> rotate<0,0.000000,0> translate<42.164000,-0.000000,22.733000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.402000,-0.000000,7.835000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.014000,-0.000000,7.835000>}
box{<0,0,-0.101600><1.612000,0.035000,0.101600> rotate<0,0.000000,0> translate<41.402000,-0.000000,7.835000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.545000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.053000,-1.535000,2.540000>}
box{<0,0,-0.101600><0.508000,0.035000,0.101600> rotate<0,0.000000,0> translate<42.545000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.291000,-0.000000,4.865000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.053000,-0.000000,6.110000>}
box{<0,0,-0.101600><1.459681,0.035000,0.101600> rotate<0,-58.527496,0> translate<42.291000,-0.000000,4.865000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.053000,-0.000000,7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.053000,-0.000000,7.860000>}
box{<0,0,-0.101600><0.014000,0.035000,0.101600> rotate<0,-90.000000,0> translate<43.053000,-0.000000,7.860000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.014000,-0.000000,7.835000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.053000,-0.000000,7.874000>}
box{<0,0,-0.101600><0.055154,0.035000,0.101600> rotate<0,-44.997030,0> translate<43.014000,-0.000000,7.835000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.027600,-1.535000,23.139400>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.053000,-1.535000,23.164800>}
box{<0,0,-0.508000><0.035921,0.035000,0.508000> rotate<0,-44.997030,0> translate<43.027600,-1.535000,23.139400> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.053000,-1.535000,23.241000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.053000,-1.535000,23.164800>}
box{<0,0,-0.508000><0.076200,0.035000,0.508000> rotate<0,-90.000000,0> translate<43.053000,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.281000,-1.535000,23.241000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.053000,-1.535000,23.241000>}
box{<0,0,-0.508000><2.772000,0.035000,0.508000> rotate<0,0.000000,0> translate<40.281000,-1.535000,23.241000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.053000,-0.000000,7.860000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.219000,-0.000000,8.001000>}
box{<0,0,-0.101600><0.217800,0.035000,0.101600> rotate<0,-40.341830,0> translate<43.053000,-0.000000,7.860000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.783000,-1.535000,1.905000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.434000,-1.535000,1.905000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<41.783000,-1.535000,1.905000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.545000,-0.000000,22.733000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.434000,-0.000000,21.844000>}
box{<0,0,-0.101600><1.257236,0.035000,0.101600> rotate<0,44.997030,0> translate<42.545000,-0.000000,22.733000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.531000,-1.535000,4.094000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.531000,-1.535000,4.151000>}
box{<0,0,-0.101600><0.057000,0.035000,0.101600> rotate<0,90.000000,0> translate<43.531000,-1.535000,4.151000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.531000,-0.000000,25.176000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.531000,-0.000000,26.329000>}
box{<0,0,-0.101600><1.153000,0.035000,0.101600> rotate<0,90.000000,0> translate<43.531000,-0.000000,26.329000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.307000,-0.000000,27.559000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.531000,-0.000000,27.335000>}
box{<0,0,-0.101600><0.316784,0.035000,0.101600> rotate<0,44.997030,0> translate<43.307000,-0.000000,27.559000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.531000,-0.000000,26.329000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.531000,-0.000000,27.335000>}
box{<0,0,-0.101600><1.006000,0.035000,0.101600> rotate<0,90.000000,0> translate<43.531000,-0.000000,27.335000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.053000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.561000,-1.535000,3.048000>}
box{<0,0,-0.101600><0.718420,0.035000,0.101600> rotate<0,-44.997030,0> translate<43.053000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.531000,-1.535000,4.094000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.561000,-1.535000,4.064000>}
box{<0,0,-0.101600><0.042426,0.035000,0.101600> rotate<0,44.997030,0> translate<43.531000,-1.535000,4.094000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.561000,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.561000,-1.535000,4.064000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,90.000000,0> translate<43.561000,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.656000,-1.535000,28.194000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.561000,-1.535000,28.194000>}
box{<0,0,-0.101600><1.905000,0.035000,0.101600> rotate<0,0.000000,0> translate<41.656000,-1.535000,28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.561000,-1.535000,28.194000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.688000,-1.535000,28.067000>}
box{<0,0,-0.101600><0.179605,0.035000,0.101600> rotate<0,44.997030,0> translate<43.561000,-1.535000,28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<42.330000,-0.000000,24.472000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.030000,-0.000000,22.772000>}
box{<0,0,-0.101600><2.404163,0.035000,0.101600> rotate<0,44.997030,0> translate<42.330000,-0.000000,24.472000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.037000,-0.000000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.143100,-0.000000,18.796000>}
box{<0,0,-0.203200><2.106100,0.035000,0.203200> rotate<0,0.000000,0> translate<42.037000,-0.000000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.219000,-0.000000,8.001000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.196000,-0.000000,8.001000>}
box{<0,0,-0.101600><0.977000,0.035000,0.101600> rotate<0,0.000000,0> translate<43.219000,-0.000000,8.001000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.030000,-0.000000,22.772000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.196000,-0.000000,22.772000>}
box{<0,0,-0.101600><0.166000,0.035000,0.101600> rotate<0,0.000000,0> translate<44.030000,-0.000000,22.772000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.531000,-0.000000,25.176000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.196000,-0.000000,24.511000>}
box{<0,0,-0.101600><0.940452,0.035000,0.101600> rotate<0,44.997030,0> translate<43.531000,-0.000000,25.176000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.196000,-0.000000,24.472000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.196000,-0.000000,24.511000>}
box{<0,0,-0.101600><0.039000,0.035000,0.101600> rotate<0,90.000000,0> translate<44.196000,-0.000000,24.511000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.143100,-0.000000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.778100,-0.000000,18.161000>}
box{<0,0,-0.203200><0.898026,0.035000,0.203200> rotate<0,44.997030,0> translate<44.143100,-0.000000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.781000,-1.535000,4.151000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.791000,-1.535000,4.151000>}
box{<0,0,-0.101600><0.010000,0.035000,0.101600> rotate<0,0.000000,0> translate<44.781000,-1.535000,4.151000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.781000,-0.000000,26.329000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.791000,-0.000000,26.329000>}
box{<0,0,-0.101600><0.010000,0.035000,0.101600> rotate<0,0.000000,0> translate<44.781000,-0.000000,26.329000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.640000,-1.535000,14.136000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.817000,-1.535000,18.288000>}
box{<0,0,-0.203200><5.889519,0.035000,0.203200> rotate<0,-44.825065,0> translate<40.640000,-1.535000,14.136000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.434000,-1.535000,1.905000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-1.535000,3.302000>}
box{<0,0,-0.101600><1.975656,0.035000,0.101600> rotate<0,-44.997030,0> translate<43.434000,-1.535000,1.905000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.791000,-1.535000,4.151000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-1.535000,4.191000>}
box{<0,0,-0.101600><0.056569,0.035000,0.101600> rotate<0,-44.997030,0> translate<44.791000,-1.535000,4.151000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-1.535000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-1.535000,4.191000>}
box{<0,0,-0.101600><0.889000,0.035000,0.101600> rotate<0,90.000000,0> translate<44.831000,-1.535000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,18.161000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,18.160900>}
box{<0,0,-0.101600><0.000100,0.035000,0.101600> rotate<0,-90.000000,0> translate<44.831000,-0.000000,18.160900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.778100,-0.000000,18.161000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.831000,-0.000000,18.161000>}
box{<0,0,-0.203200><0.052900,0.035000,0.203200> rotate<0,0.000000,0> translate<44.778100,-0.000000,18.161000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.434000,-0.000000,21.844000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,21.844000>}
box{<0,0,-0.101600><1.397000,0.035000,0.101600> rotate<0,0.000000,0> translate<43.434000,-0.000000,21.844000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.781000,-0.000000,26.329000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,26.279000>}
box{<0,0,-0.101600><0.070711,0.035000,0.101600> rotate<0,44.997030,0> translate<44.781000,-0.000000,26.329000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.791000,-0.000000,26.329000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,26.289000>}
box{<0,0,-0.101600><0.056569,0.035000,0.101600> rotate<0,44.997030,0> translate<44.791000,-0.000000,26.329000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,26.289000>}
box{<0,0,-0.101600><0.762000,0.035000,0.101600> rotate<0,90.000000,0> translate<44.831000,-0.000000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.259000,-0.000000,28.829000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,28.829000>}
box{<0,0,-0.101600><4.572000,0.035000,0.101600> rotate<0,0.000000,0> translate<40.259000,-0.000000,28.829000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.577000,-1.535000,13.081000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.847300,-1.535000,12.810700>}
box{<0,0,-0.101600><0.382262,0.035000,0.101600> rotate<0,44.997030,0> translate<44.577000,-1.535000,13.081000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.847100,-0.000000,11.107100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.917600,-0.000000,11.089400>}
box{<0,0,-0.101600><0.072688,0.035000,0.101600> rotate<0,14.092666,0> translate<44.847100,-0.000000,11.107100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.917600,-0.000000,11.089400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.958000,-0.000000,11.049000>}
box{<0,0,-0.101600><0.057134,0.035000,0.101600> rotate<0,44.997030,0> translate<44.917600,-0.000000,11.089400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,18.160900>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.974200,-0.000000,18.017700>}
box{<0,0,-0.101600><0.202515,0.035000,0.101600> rotate<0,44.997030,0> translate<44.831000,-0.000000,18.160900> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.958000,-0.000000,11.049000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.015500,-0.000000,11.106500>}
box{<0,0,-0.101600><0.081317,0.035000,0.101600> rotate<0,-44.997030,0> translate<44.958000,-0.000000,11.049000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.015500,-0.000000,11.106500>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.015500,-0.000000,13.193200>}
box{<0,0,-0.101600><2.086700,0.035000,0.101600> rotate<0,90.000000,0> translate<45.015500,-0.000000,13.193200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,21.844000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.212000,-0.000000,22.225000>}
box{<0,0,-0.101600><0.538815,0.035000,0.101600> rotate<0,-44.997030,0> translate<44.831000,-0.000000,21.844000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.212000,-0.000000,25.146000>}
box{<0,0,-0.101600><0.538815,0.035000,0.101600> rotate<0,44.997030,0> translate<44.831000,-0.000000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.212000,-0.000000,22.225000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.212000,-0.000000,25.146000>}
box{<0,0,-0.101600><2.921000,0.035000,0.101600> rotate<0,90.000000,0> translate<45.212000,-0.000000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.015500,-0.000000,13.193200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.284300,-0.000000,13.462000>}
box{<0,0,-0.101600><0.380141,0.035000,0.101600> rotate<0,-44.997030,0> translate<45.015500,-0.000000,13.193200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.720000,-0.000000,26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.720000,-0.000000,23.876000>}
box{<0,0,-0.101600><2.286000,0.035000,0.101600> rotate<0,-90.000000,0> translate<45.720000,-0.000000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<40.298000,-1.535000,26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.720000,-1.535000,26.162000>}
box{<0,0,-0.101600><5.422000,0.035000,0.101600> rotate<0,0.000000,0> translate<40.298000,-1.535000,26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.307000,-1.535000,27.559000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.847000,-1.535000,27.559000>}
box{<0,0,-0.101600><2.540000,0.035000,0.101600> rotate<0,0.000000,0> translate<43.307000,-1.535000,27.559000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.847000,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.022000,-1.535000,11.684000>}
box{<0,0,-0.101600><0.175000,0.035000,0.101600> rotate<0,0.000000,0> translate<45.847000,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.084800,-1.535000,11.573200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.101000,-1.535000,11.624800>}
box{<0,0,-0.101600><0.054083,0.035000,0.101600> rotate<0,-72.565348,0> translate<46.084800,-1.535000,11.573200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.101000,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.101000,-1.535000,11.624800>}
box{<0,0,-0.101600><0.059200,0.035000,0.101600> rotate<0,-90.000000,0> translate<46.101000,-1.535000,11.624800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.022000,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.101000,-1.535000,11.684000>}
box{<0,0,-0.101600><0.079000,0.035000,0.101600> rotate<0,0.000000,0> translate<46.022000,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.720000,-0.000000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.101000,-0.000000,23.495000>}
box{<0,0,-0.101600><0.538815,0.035000,0.101600> rotate<0,44.997030,0> translate<45.720000,-0.000000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.101000,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.118100,-1.535000,11.684000>}
box{<0,0,-0.101600><0.017100,0.035000,0.101600> rotate<0,0.000000,0> translate<46.101000,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.211700,-0.000000,16.780200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.227900,-0.000000,16.764000>}
box{<0,0,-0.101600><0.022910,0.035000,0.101600> rotate<0,44.997030,0> translate<46.211700,-0.000000,16.780200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.227900,-0.000000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.228000,-0.000000,16.764000>}
box{<0,0,-0.101600><0.000100,0.035000,0.101600> rotate<0,0.000000,0> translate<46.227900,-0.000000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.228000,-0.000000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.228000,-0.000000,16.917500>}
box{<0,0,-0.101600><0.153500,0.035000,0.101600> rotate<0,90.000000,0> translate<46.228000,-0.000000,16.917500> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,28.829000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.228000,-0.000000,27.432000>}
box{<0,0,-0.101600><1.975656,0.035000,0.101600> rotate<0,44.997030,0> translate<44.831000,-0.000000,28.829000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.482000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.482000,-1.535000,3.937000>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,90.000000,0> translate<46.482000,-1.535000,3.937000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.482000,-0.000000,4.445000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.482000,-0.000000,5.881000>}
box{<0,0,-0.101600><1.436000,0.035000,0.101600> rotate<0,90.000000,0> translate<46.482000,-0.000000,5.881000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.482000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.498300,-1.535000,3.793700>}
box{<0,0,-0.127000><0.023052,0.035000,0.127000> rotate<0,44.997030,0> translate<46.482000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.831000,-0.000000,18.161000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.764500,-0.000000,18.161000>}
box{<0,0,-0.101600><1.933500,0.035000,0.101600> rotate<0,0.000000,0> translate<44.831000,-0.000000,18.161000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.482000,-0.000000,4.445000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.775000,-0.000000,4.152000>}
box{<0,0,-0.101600><0.414365,0.035000,0.101600> rotate<0,44.997030,0> translate<46.482000,-0.000000,4.445000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.750000,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.775000,-0.000000,4.152000>}
box{<0,0,-0.101600><0.046325,0.035000,0.101600> rotate<0,57.335303,0> translate<46.750000,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.775000,-0.000000,4.152000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.863000,-0.000000,4.064000>}
box{<0,0,-0.101600><0.124451,0.035000,0.101600> rotate<0,44.997030,0> translate<46.775000,-0.000000,4.152000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.847000,-1.535000,27.559000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.863000,-1.535000,26.543000>}
box{<0,0,-0.101600><1.436841,0.035000,0.101600> rotate<0,44.997030,0> translate<45.847000,-1.535000,27.559000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.228000,-0.000000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.863000,-0.000000,27.432000>}
box{<0,0,-0.101600><0.635000,0.035000,0.101600> rotate<0,0.000000,0> translate<46.228000,-0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.990000,-1.535000,12.130200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.990000,-1.535000,16.002000>}
box{<0,0,-0.101600><3.871800,0.035000,0.101600> rotate<0,90.000000,0> translate<46.990000,-1.535000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.990000,-0.000000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.990000,-0.000000,16.265300>}
box{<0,0,-0.101600><0.263300,0.035000,0.101600> rotate<0,90.000000,0> translate<46.990000,-0.000000,16.265300> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.482000,-0.000000,7.581000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.029000,-0.000000,8.128000>}
box{<0,0,-0.101600><0.773575,0.035000,0.101600> rotate<0,-44.997030,0> translate<46.482000,-0.000000,7.581000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.116900,-0.000000,26.288900>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.116900,-0.000000,26.275100>}
box{<0,0,-0.101600><0.013800,0.035000,0.101600> rotate<0,-90.000000,0> translate<47.116900,-0.000000,26.275100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.117000,-0.000000,24.550000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.117000,-0.000000,24.511000>}
box{<0,0,-0.101600><0.039000,0.035000,0.101600> rotate<0,-90.000000,0> translate<47.117000,-0.000000,24.511000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.116900,-0.000000,24.525100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.117000,-0.000000,24.550000>}
box{<0,0,-0.101600><0.024900,0.035000,0.101600> rotate<0,-89.763973,0> translate<47.116900,-0.000000,24.525100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.116900,-0.000000,26.288900>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.117000,-0.000000,26.289000>}
box{<0,0,-0.101600><0.000141,0.035000,0.101600> rotate<0,-44.997030,0> translate<47.116900,-0.000000,26.288900> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.764500,-0.000000,18.161000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.388700,-0.000000,18.785200>}
box{<0,0,-0.101600><0.882752,0.035000,0.101600> rotate<0,-44.997030,0> translate<46.764500,-0.000000,18.161000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.101000,-0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.416600,-0.000000,23.495000>}
box{<0,0,-0.101600><1.315600,0.035000,0.101600> rotate<0,0.000000,0> translate<46.101000,-0.000000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.892800,-1.535000,9.399000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.528800,-1.535000,8.763000>}
box{<0,0,-0.101600><0.899440,0.035000,0.101600> rotate<0,44.997030,0> translate<46.892800,-1.535000,9.399000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.035100,-0.000000,19.138800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.581300,-0.000000,19.685000>}
box{<0,0,-0.101600><0.772443,0.035000,0.101600> rotate<0,-44.997030,0> translate<47.035100,-0.000000,19.138800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.482000,-1.535000,3.937000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.591800,-1.535000,3.937000>}
box{<0,0,-0.127000><1.109800,0.035000,0.127000> rotate<0,0.000000,0> translate<46.482000,-1.535000,3.937000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<47.599600,-1.535000,21.615400>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<47.599600,-1.535000,23.139400>}
box{<0,0,-0.711200><1.524000,0.035000,0.711200> rotate<0,90.000000,0> translate<47.599600,-1.535000,23.139400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.022000,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.599900,-1.535000,10.106100>}
box{<0,0,-0.101600><2.231488,0.035000,0.101600> rotate<0,44.997030,0> translate<46.022000,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.591800,-1.535000,3.937000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.625000,-1.535000,3.937000>}
box{<0,0,-0.101600><0.033200,0.035000,0.101600> rotate<0,0.000000,0> translate<47.591800,-1.535000,3.937000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.625000,-1.535000,3.937000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.625000,-1.535000,3.979300>}
box{<0,0,-0.101600><0.042300,0.035000,0.101600> rotate<0,90.000000,0> translate<47.625000,-1.535000,3.979300> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.228000,-0.000000,16.917500>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.742200,-0.000000,18.431700>}
box{<0,0,-0.101600><2.141402,0.035000,0.101600> rotate<0,-44.997030,0> translate<46.228000,-0.000000,16.917500> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.528800,-1.535000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.752000,-1.535000,8.763000>}
box{<0,0,-0.101600><0.223200,0.035000,0.101600> rotate<0,0.000000,0> translate<47.528800,-1.535000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.752000,-1.535000,12.075400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.752000,-1.535000,15.494000>}
box{<0,0,-0.101600><3.418600,0.035000,0.101600> rotate<0,90.000000,0> translate<47.752000,-1.535000,15.494000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.752000,-0.000000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.752000,-0.000000,16.320100>}
box{<0,0,-0.101600><0.826100,0.035000,0.101600> rotate<0,90.000000,0> translate<47.752000,-0.000000,16.320100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.117000,-0.000000,24.511000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.814800,-0.000000,24.511000>}
box{<0,0,-0.101600><0.697800,0.035000,0.101600> rotate<0,0.000000,0> translate<47.117000,-0.000000,24.511000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.735800,-1.535000,2.556200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.879000,-1.535000,2.734800>}
box{<0,0,-0.127000><0.228920,0.035000,0.127000> rotate<0,-51.274266,0> translate<47.735800,-1.535000,2.556200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.879000,-1.535000,2.734800>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.879000,-1.535000,3.517200>}
box{<0,0,-0.127000><0.782400,0.035000,0.127000> rotate<0,90.000000,0> translate<47.879000,-1.535000,3.517200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.879000,-1.535000,3.517200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.879000,-1.535000,3.556000>}
box{<0,0,-0.101600><0.038800,0.035000,0.101600> rotate<0,90.000000,0> translate<47.879000,-1.535000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.196000,-1.535000,8.001000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.879000,-1.535000,8.001000>}
box{<0,0,-0.101600><3.683000,0.035000,0.101600> rotate<0,0.000000,0> translate<44.196000,-1.535000,8.001000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.879000,-1.535000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.908700,-1.535000,3.556000>}
box{<0,0,-0.101600><0.029700,0.035000,0.101600> rotate<0,0.000000,0> translate<47.879000,-1.535000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.116000,-0.000000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.006000,-0.000000,20.828000>}
box{<0,0,-0.101600><8.890000,0.035000,0.101600> rotate<0,0.000000,0> translate<39.116000,-0.000000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<48.006000,-1.535000,21.004000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<48.055000,-1.535000,21.004000>}
box{<0,0,-0.711200><0.049000,0.035000,0.711200> rotate<0,0.000000,0> translate<48.006000,-1.535000,21.004000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.416600,-0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.095800,-0.000000,22.815800>}
box{<0,0,-0.101600><0.960534,0.035000,0.101600> rotate<0,44.997030,0> translate<47.416600,-0.000000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.581300,-0.000000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,19.685000>}
box{<0,0,-0.101600><0.551700,0.035000,0.101600> rotate<0,0.000000,0> translate<47.581300,-0.000000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.370000,-0.000000,20.447000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,20.447000>}
box{<0,0,-0.101600><8.763000,0.035000,0.101600> rotate<0,0.000000,0> translate<39.370000,-0.000000,20.447000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<47.599600,-1.535000,21.615400>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<48.133000,-1.535000,21.082000>}
box{<0,0,-0.711200><0.754342,0.035000,0.711200> rotate<0,44.997030,0> translate<47.599600,-1.535000,21.615400> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<48.055000,-1.535000,21.004000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<48.133000,-1.535000,21.082000>}
box{<0,0,-0.711200><0.110309,0.035000,0.711200> rotate<0,-44.997030,0> translate<48.055000,-1.535000,21.004000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,25.273000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,24.899800>}
box{<0,0,-0.101600><0.373200,0.035000,0.101600> rotate<0,-90.000000,0> translate<48.133000,-0.000000,24.899800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.117000,-0.000000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,25.273000>}
box{<0,0,-0.101600><1.436841,0.035000,0.101600> rotate<0,44.997030,0> translate<47.117000,-0.000000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,26.162000>}
box{<0,0,-0.101600><0.381000,0.035000,0.101600> rotate<0,-90.000000,0> translate<48.133000,-0.000000,26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.863000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-1.535000,26.543000>}
box{<0,0,-0.101600><1.270000,0.035000,0.101600> rotate<0,0.000000,0> translate<46.863000,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.029000,-0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.147000,-0.000000,8.128000>}
box{<0,0,-0.101600><1.118000,0.035000,0.101600> rotate<0,0.000000,0> translate<47.029000,-0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.172000,-0.000000,6.223000>}
box{<0,0,-0.101600><0.132853,0.035000,0.101600> rotate<0,72.924166,0> translate<48.133000,-0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.172000,-0.000000,6.389000>}
box{<0,0,-0.101600><0.055154,0.035000,0.101600> rotate<0,-44.997030,0> translate<48.133000,-0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.147000,-0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.172000,-0.000000,6.389000>}
box{<0,0,-0.101600><1.739180,0.035000,0.101600> rotate<0,89.170483,0> translate<48.147000,-0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.752000,-1.535000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.260000,-1.535000,9.271000>}
box{<0,0,-0.101600><0.718420,0.035000,0.101600> rotate<0,-44.997030,0> translate<47.752000,-1.535000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.599900,-1.535000,10.106100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.260000,-1.535000,9.446000>}
box{<0,0,-0.101600><0.933522,0.035000,0.101600> rotate<0,44.997030,0> translate<47.599900,-1.535000,10.106100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.260000,-1.535000,9.271000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.260000,-1.535000,9.446000>}
box{<0,0,-0.101600><0.175000,0.035000,0.101600> rotate<0,90.000000,0> translate<48.260000,-1.535000,9.446000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.751000,-0.000000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.260000,-0.000000,20.066000>}
box{<0,0,-0.101600><8.509000,0.035000,0.101600> rotate<0,0.000000,0> translate<39.751000,-0.000000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.990000,-1.535000,12.130200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.307000,-1.535000,10.813200>}
box{<0,0,-0.101600><1.862519,0.035000,0.101600> rotate<0,44.997030,0> translate<46.990000,-1.535000,12.130200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.387000,-1.535000,12.147400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.387000,-1.535000,14.986000>}
box{<0,0,-0.101600><2.838600,0.035000,0.101600> rotate<0,90.000000,0> translate<48.387000,-1.535000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.742200,-0.000000,18.431700>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.387000,-0.000000,19.076500>}
box{<0,0,-0.101600><0.911885,0.035000,0.101600> rotate<0,-44.997030,0> translate<47.742200,-0.000000,18.431700> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.387000,-0.000000,19.431000>}
box{<0,0,-0.101600><0.359210,0.035000,0.101600> rotate<0,44.997030,0> translate<48.133000,-0.000000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.387000,-0.000000,19.076500>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.387000,-0.000000,19.431000>}
box{<0,0,-0.101600><0.354500,0.035000,0.101600> rotate<0,90.000000,0> translate<48.387000,-0.000000,19.431000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.990000,-0.000000,16.265300>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.449300,-0.000000,17.724600>}
box{<0,0,-0.101600><2.063762,0.035000,0.101600> rotate<0,-44.997030,0> translate<46.990000,-0.000000,16.265300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.475000,-0.000000,3.468000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.500000,-0.000000,4.191000>}
box{<0,0,-0.203200><0.723432,0.035000,0.203200> rotate<0,-88.013798,0> translate<48.475000,-0.000000,3.468000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.387000,-1.535000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.514000,-1.535000,14.986000>}
box{<0,0,-0.101600><0.127000,0.035000,0.101600> rotate<0,0.000000,0> translate<48.387000,-1.535000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.514000,-0.000000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.514000,-0.000000,16.375100>}
box{<0,0,-0.101600><1.389100,0.035000,0.101600> rotate<0,90.000000,0> translate<48.514000,-0.000000,16.375100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.625000,-1.535000,3.979300>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.660600,-1.535000,5.014900>}
box{<0,0,-0.101600><1.464560,0.035000,0.101600> rotate<0,-44.997030,0> translate<47.625000,-1.535000,3.979300> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.752000,-1.535000,12.075400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.660600,-1.535000,11.166800>}
box{<0,0,-0.101600><1.284954,0.035000,0.101600> rotate<0,44.997030,0> translate<47.752000,-1.535000,12.075400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.768000,-0.000000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.768000,-0.000000,24.972000>}
box{<0,0,-0.101600><0.555000,0.035000,0.101600> rotate<0,-90.000000,0> translate<48.768000,-0.000000,24.972000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.768000,-0.000000,25.527000>}
box{<0,0,-0.101600><0.898026,0.035000,0.101600> rotate<0,44.997030,0> translate<48.133000,-0.000000,26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.752000,-0.000000,16.320100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.802900,-0.000000,17.371000>}
box{<0,0,-0.101600><1.486197,0.035000,0.101600> rotate<0,-44.997030,0> translate<47.752000,-0.000000,16.320100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.814800,-0.000000,24.511000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.802900,-0.000000,23.522900>}
box{<0,0,-0.101600><1.397384,0.035000,0.101600> rotate<0,44.997030,0> translate<47.814800,-0.000000,24.511000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.908700,-1.535000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.014100,-1.535000,4.661400>}
box{<0,0,-0.101600><1.563272,0.035000,0.101600> rotate<0,-44.997030,0> translate<47.908700,-1.535000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.387000,-1.535000,12.147400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.014100,-1.535000,11.520300>}
box{<0,0,-0.101600><0.886853,0.035000,0.101600> rotate<0,44.997030,0> translate<48.387000,-1.535000,12.147400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.022000,-0.000000,26.132200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.022000,-0.000000,29.337000>}
box{<0,0,-0.101600><3.204800,0.035000,0.101600> rotate<0,90.000000,0> translate<49.022000,-0.000000,29.337000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.475000,-0.000000,3.468000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.149000,-0.000000,2.794000>}
box{<0,0,-0.203200><0.953180,0.035000,0.203200> rotate<0,44.997030,0> translate<48.475000,-0.000000,3.468000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-0.000000,11.489100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-0.000000,12.065000>}
box{<0,0,-0.101600><0.575900,0.035000,0.101600> rotate<0,90.000000,0> translate<49.149000,-0.000000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-0.000000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-0.000000,12.094100>}
box{<0,0,-0.101600><0.029100,0.035000,0.101600> rotate<0,90.000000,0> translate<49.149000,-0.000000,12.094100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-0.000000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.153700,-0.000000,12.065000>}
box{<0,0,-0.101600><0.004700,0.035000,0.101600> rotate<0,0.000000,0> translate<49.149000,-0.000000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.514000,-0.000000,16.375100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.156400,-0.000000,17.017500>}
box{<0,0,-0.101600><0.908491,0.035000,0.101600> rotate<0,-44.997030,0> translate<48.514000,-0.000000,16.375100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,24.899800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.156400,-0.000000,23.876400>}
box{<0,0,-0.101600><1.447306,0.035000,0.101600> rotate<0,44.997030,0> translate<48.133000,-0.000000,24.899800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-0.000000,12.094100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.187400,-0.000000,12.132500>}
box{<0,0,-0.101600><0.054306,0.035000,0.101600> rotate<0,-44.997030,0> translate<49.149000,-0.000000,12.094100> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.327100,-1.535000,16.091800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.389300,-1.535000,16.129000>}
box{<0,0,-0.152400><0.072475,0.035000,0.152400> rotate<0,-30.880371,0> translate<49.327100,-1.535000,16.091800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.768000,-0.000000,24.972000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.510000,-0.000000,24.230000>}
box{<0,0,-0.101600><1.049346,0.035000,0.101600> rotate<0,44.997030,0> translate<48.768000,-0.000000,24.972000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.389300,-1.535000,16.129000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.657000,-1.535000,16.129000>}
box{<0,0,-0.152400><0.267700,0.035000,0.152400> rotate<0,0.000000,0> translate<49.389300,-1.535000,16.129000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.657000,-1.535000,13.705800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.657000,-1.535000,16.129000>}
box{<0,0,-0.152400><2.423200,0.035000,0.152400> rotate<0,90.000000,0> translate<49.657000,-1.535000,16.129000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.284300,-0.000000,13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.784000,-0.000000,13.462000>}
box{<0,0,-0.101600><4.499700,0.035000,0.101600> rotate<0,0.000000,0> translate<45.284300,-0.000000,13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.784000,-0.000000,13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.812700,-0.000000,13.462000>}
box{<0,0,-0.101600><0.028700,0.035000,0.101600> rotate<0,0.000000,0> translate<49.784000,-0.000000,13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.798000,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.823000,-0.000000,6.262000>}
box{<0,0,-0.101600><2.071151,0.035000,0.101600> rotate<0,-89.302496,0> translate<49.798000,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.784000,-0.000000,13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.843500,-0.000000,13.462000>}
box{<0,0,-0.101600><0.059500,0.035000,0.101600> rotate<0,0.000000,0> translate<49.784000,-0.000000,13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.823000,-0.000000,6.262000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.911000,-0.000000,6.350000>}
box{<0,0,-0.101600><0.124451,0.035000,0.101600> rotate<0,-44.997030,0> translate<49.823000,-0.000000,6.262000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.872000,-0.000000,6.223000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.911000,-0.000000,6.350000>}
box{<0,0,-0.101600><0.132853,0.035000,0.101600> rotate<0,-72.924166,0> translate<49.872000,-0.000000,6.223000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.022000,-0.000000,29.337000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.911000,-0.000000,30.226000>}
box{<0,0,-0.101600><1.257236,0.035000,0.101600> rotate<0,-44.997030,0> translate<49.022000,-0.000000,29.337000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.911000,-0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.094000,-0.000000,6.533000>}
box{<0,0,-0.101600><0.258801,0.035000,0.101600> rotate<0,-44.997030,0> translate<49.911000,-0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-0.000000,11.489100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.096100,-0.000000,10.577400>}
box{<0,0,-0.101600><1.314608,0.035000,0.101600> rotate<0,43.906062,0> translate<49.149000,-0.000000,11.489100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.022000,-0.000000,26.132200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.217100,-0.000000,24.937100>}
box{<0,0,-0.101600><1.690127,0.035000,0.101600> rotate<0,44.997030,0> translate<49.022000,-0.000000,26.132200> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<50.266600,-1.535000,23.139400>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<50.266600,-1.535000,20.980400>}
box{<0,0,-0.711200><2.159000,0.035000,0.711200> rotate<0,-90.000000,0> translate<50.266600,-1.535000,20.980400> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<50.292000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<50.292000,-1.535000,20.806000>}
box{<0,0,-0.711200><0.149000,0.035000,0.711200> rotate<0,-90.000000,0> translate<50.292000,-1.535000,20.806000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<50.266600,-1.535000,20.980400>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<50.292000,-1.535000,20.955000>}
box{<0,0,-0.711200><0.035921,0.035000,0.711200> rotate<0,44.997030,0> translate<50.266600,-1.535000,20.980400> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<50.266600,-1.535000,23.139400>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<50.292000,-1.535000,23.164800>}
box{<0,0,-0.508000><0.035921,0.035000,0.508000> rotate<0,-44.997030,0> translate<50.266600,-1.535000,23.139400> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<50.292000,-1.535000,25.019000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<50.292000,-1.535000,23.164800>}
box{<0,0,-0.508000><1.854200,0.035000,0.508000> rotate<0,-90.000000,0> translate<50.292000,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<50.292000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<50.292000,-1.535000,25.019000>}
box{<0,0,-0.508000><0.127000,0.035000,0.508000> rotate<0,-90.000000,0> translate<50.292000,-1.535000,25.019000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.354000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<50.292000,-1.535000,25.146000>}
box{<0,0,-0.508000><11.938000,0.035000,0.508000> rotate<0,0.000000,0> translate<38.354000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.657000,-1.535000,13.705800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.428300,-1.535000,12.934500>}
box{<0,0,-0.152400><1.090783,0.035000,0.152400> rotate<0,44.997030,0> translate<49.657000,-1.535000,13.705800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.879000,-1.535000,8.001000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.546000,-1.535000,10.668000>}
box{<0,0,-0.101600><3.771708,0.035000,0.101600> rotate<0,-44.997030,0> translate<47.879000,-1.535000,8.001000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.721200,-1.535000,12.227400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.546000,-1.535000,11.402600>}
box{<0,0,-0.101600><1.166443,0.035000,0.101600> rotate<0,44.997030,0> translate<49.721200,-1.535000,12.227400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.546000,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.546000,-1.535000,11.402600>}
box{<0,0,-0.101600><0.734600,0.035000,0.101600> rotate<0,90.000000,0> translate<50.546000,-1.535000,11.402600> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.927000,-0.000000,11.937900>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.927000,-0.000000,13.131300>}
box{<0,0,-0.101600><1.193400,0.035000,0.101600> rotate<0,90.000000,0> translate<50.927000,-0.000000,13.131300> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.927000,-0.000000,11.937900>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.943200,-0.000000,11.921700>}
box{<0,0,-0.101600><0.022910,0.035000,0.101600> rotate<0,44.997030,0> translate<50.927000,-0.000000,11.937900> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.054000,-1.535000,15.137200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.054000,-1.535000,16.093700>}
box{<0,0,-0.152400><0.956500,0.035000,0.152400> rotate<0,90.000000,0> translate<51.054000,-1.535000,16.093700> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.054000,-1.535000,16.093700>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.054000,-1.535000,16.129000>}
box{<0,0,-0.152400><0.035300,0.035000,0.152400> rotate<0,90.000000,0> translate<51.054000,-1.535000,16.129000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.054000,-1.535000,16.093700>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.077100,-1.535000,16.091800>}
box{<0,0,-0.152400><0.023178,0.035000,0.152400> rotate<0,4.701745,0> translate<51.054000,-1.535000,16.093700> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.246400,-1.535000,6.429100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.181000,-1.535000,10.363700>}
box{<0,0,-0.101600><5.564365,0.035000,0.101600> rotate<0,-44.997030,0> translate<47.246400,-1.535000,6.429100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.181000,-1.535000,10.363700>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.181000,-1.535000,10.414000>}
box{<0,0,-0.101600><0.050300,0.035000,0.101600> rotate<0,90.000000,0> translate<51.181000,-1.535000,10.414000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.843500,-0.000000,13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.277700,-0.000000,14.896200>}
box{<0,0,-0.101600><2.028265,0.035000,0.101600> rotate<0,-44.997030,0> translate<49.843500,-0.000000,13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.897000,-0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.308000,-0.000000,8.128000>}
box{<0,0,-0.101600><1.411000,0.035000,0.101600> rotate<0,0.000000,0> translate<49.897000,-0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.523000,-0.000000,2.833000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.548000,-0.000000,4.191000>}
box{<0,0,-0.203200><1.358230,0.035000,0.203200> rotate<0,-88.939467,0> translate<51.523000,-0.000000,2.833000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,4.195000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,5.883000>}
box{<0,0,-0.101600><1.688000,0.035000,0.101600> rotate<0,90.000000,0> translate<51.558000,-0.000000,5.883000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.094000,-0.000000,6.533000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,6.533000>}
box{<0,0,-0.101600><1.464000,0.035000,0.101600> rotate<0,0.000000,0> translate<50.094000,-0.000000,6.533000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,7.183000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,7.235000>}
box{<0,0,-0.101600><0.052000,0.035000,0.101600> rotate<0,90.000000,0> translate<51.558000,-0.000000,7.235000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,7.243000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,7.833000>}
box{<0,0,-0.101600><0.590000,0.035000,0.101600> rotate<0,90.000000,0> translate<51.558000,-0.000000,7.833000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,7.833000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,7.870000>}
box{<0,0,-0.101600><0.037000,0.035000,0.101600> rotate<0,90.000000,0> translate<51.558000,-0.000000,7.870000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.149000,-0.000000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.562000,-0.000000,2.794000>}
box{<0,0,-0.203200><2.413000,0.035000,0.203200> rotate<0,0.000000,0> translate<49.149000,-0.000000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.523000,-0.000000,2.833000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.562000,-0.000000,2.794000>}
box{<0,0,-0.203200><0.055154,0.035000,0.203200> rotate<0,44.997030,0> translate<51.523000,-0.000000,2.833000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.548000,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.562000,-0.000000,4.191000>}
box{<0,0,-0.101600><0.014000,0.035000,0.101600> rotate<0,0.000000,0> translate<51.548000,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,4.195000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.562000,-0.000000,4.191000>}
box{<0,0,-0.101600><0.005657,0.035000,0.101600> rotate<0,44.997030,0> translate<51.558000,-0.000000,4.195000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,7.235000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.562000,-0.000000,7.239000>}
box{<0,0,-0.101600><0.005657,0.035000,0.101600> rotate<0,-44.997030,0> translate<51.558000,-0.000000,7.235000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,7.243000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.562000,-0.000000,7.239000>}
box{<0,0,-0.101600><0.005657,0.035000,0.101600> rotate<0,44.997030,0> translate<51.558000,-0.000000,7.243000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.308000,-0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.562000,-0.000000,7.874000>}
box{<0,0,-0.101600><0.359210,0.035000,0.101600> rotate<0,44.997030,0> translate<51.308000,-0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,7.870000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.562000,-0.000000,7.874000>}
box{<0,0,-0.101600><0.005657,0.035000,0.101600> rotate<0,-44.997030,0> translate<51.558000,-0.000000,7.870000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.153700,-0.000000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.631300,-0.000000,14.542600>}
box{<0,0,-0.101600><3.503856,0.035000,0.101600> rotate<0,-44.997030,0> translate<49.153700,-0.000000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.054000,-1.535000,15.137200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.842500,-1.535000,14.348700>}
box{<0,0,-0.152400><1.115107,0.035000,0.152400> rotate<0,44.997030,0> translate<51.054000,-1.535000,15.137200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.927000,-0.000000,13.131300>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.984800,-0.000000,14.189100>}
box{<0,0,-0.101600><1.495955,0.035000,0.101600> rotate<0,-44.997030,0> translate<50.927000,-0.000000,13.131300> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.277700,-0.000000,14.896200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.002500,-0.000000,15.621000>}
box{<0,0,-0.101600><1.025022,0.035000,0.101600> rotate<0,-44.997030,0> translate<51.277700,-0.000000,14.896200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.489000,-1.535000,13.995200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.022200,-1.535000,13.462000>}
box{<0,0,-0.101600><0.754059,0.035000,0.101600> rotate<0,44.997030,0> translate<51.489000,-1.535000,13.995200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.784000,-0.000000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.070000,-0.000000,29.464000>}
box{<0,0,-0.101600><3.232892,0.035000,0.101600> rotate<0,-44.997030,0> translate<49.784000,-0.000000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.489000,-1.535000,13.995200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.149200,-1.535000,13.335000>}
box{<0,0,-0.101600><0.933664,0.035000,0.101600> rotate<0,44.997030,0> translate<51.489000,-1.535000,13.995200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.558000,-0.000000,7.183000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.634000,-0.000000,7.183000>}
box{<0,0,-0.101600><1.076000,0.035000,0.101600> rotate<0,0.000000,0> translate<51.558000,-0.000000,7.183000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.002500,-0.000000,15.621000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.705000,-0.000000,15.621000>}
box{<0,0,-0.101600><0.702500,0.035000,0.101600> rotate<0,0.000000,0> translate<52.002500,-0.000000,15.621000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.006000,-0.000000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.705000,-0.000000,25.527000>}
box{<0,0,-0.101600><6.645390,0.035000,0.101600> rotate<0,-44.997030,0> translate<48.006000,-0.000000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.984800,-0.000000,26.704800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.705000,-0.000000,25.984600>}
box{<0,0,-0.101600><1.018517,0.035000,0.101600> rotate<0,44.997030,0> translate<51.984800,-0.000000,26.704800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.705000,-0.000000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.705000,-0.000000,25.984600>}
box{<0,0,-0.101600><0.457600,0.035000,0.101600> rotate<0,90.000000,0> translate<52.705000,-0.000000,25.984600> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.863000,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.705000,-1.535000,27.432000>}
box{<0,0,-0.101600><5.842000,0.035000,0.101600> rotate<0,0.000000,0> translate<46.863000,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.871000,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.959000,-0.000000,4.191000>}
box{<0,0,-0.101600><0.088000,0.035000,0.101600> rotate<0,0.000000,0> translate<52.871000,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.634000,-0.000000,7.183000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.959000,-0.000000,6.858000>}
box{<0,0,-0.101600><0.459619,0.035000,0.101600> rotate<0,44.997030,0> translate<52.634000,-0.000000,7.183000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.959000,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.959000,-0.000000,6.858000>}
box{<0,0,-0.101600><2.667000,0.035000,0.101600> rotate<0,90.000000,0> translate<52.959000,-0.000000,6.858000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.149200,-1.535000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.959000,-1.535000,13.335000>}
box{<0,0,-0.101600><0.809800,0.035000,0.101600> rotate<0,0.000000,0> translate<52.149200,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.688000,-1.535000,28.067000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.213000,-1.535000,28.067000>}
box{<0,0,-0.101600><9.525000,0.035000,0.101600> rotate<0,0.000000,0> translate<43.688000,-1.535000,28.067000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.959000,-0.000000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-0.000000,13.716000>}
box{<0,0,-0.101600><0.538815,0.035000,0.101600> rotate<0,-44.997030,0> translate<52.959000,-0.000000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-0.000000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-0.000000,13.716000>}
box{<0,0,-0.101600><1.270000,0.035000,0.101600> rotate<0,-90.000000,0> translate<53.340000,-0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.705000,-0.000000,15.621000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-0.000000,14.986000>}
box{<0,0,-0.101600><0.898026,0.035000,0.101600> rotate<0,44.997030,0> translate<52.705000,-0.000000,15.621000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.133000,-0.000000,20.447000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-0.000000,25.654000>}
box{<0,0,-0.101600><7.363810,0.035000,0.101600> rotate<0,-44.997030,0> translate<48.133000,-0.000000,20.447000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.338400,-0.000000,27.058400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-0.000000,26.056800>}
box{<0,0,-0.101600><1.416476,0.035000,0.101600> rotate<0,44.997030,0> translate<52.338400,-0.000000,27.058400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-0.000000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-0.000000,26.056800>}
box{<0,0,-0.101600><0.402800,0.035000,0.101600> rotate<0,90.000000,0> translate<53.340000,-0.000000,26.056800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.388700,-0.000000,22.108700>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.594000,-0.000000,15.903400>}
box{<0,0,-0.101600><8.775619,0.035000,0.101600> rotate<0,44.997030,0> translate<47.388700,-0.000000,22.108700> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.594000,-0.000000,10.414000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.594000,-0.000000,15.903400>}
box{<0,0,-0.101600><5.489400,0.035000,0.101600> rotate<0,90.000000,0> translate<53.594000,-0.000000,15.903400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.260000,-0.000000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.594000,-0.000000,25.400000>}
box{<0,0,-0.101600><7.543415,0.035000,0.101600> rotate<0,-44.997030,0> translate<48.260000,-0.000000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.594000,-0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<54.003500,-0.000000,25.400000>}
box{<0,0,-0.101600><0.409500,0.035000,0.101600> rotate<0,0.000000,0> translate<53.594000,-0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.705000,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<54.356000,-1.535000,25.781000>}
box{<0,0,-0.101600><2.334867,0.035000,0.101600> rotate<0,44.997030,0> translate<52.705000,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.213000,-1.535000,28.067000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<54.737000,-1.535000,26.543000>}
box{<0,0,-0.101600><2.155261,0.035000,0.101600> rotate<0,44.997030,0> translate<53.213000,-1.535000,28.067000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.838600,-1.535000,22.885400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.838600,-1.535000,23.139400>}
box{<0,0,-0.203200><0.254000,0.035000,0.203200> rotate<0,90.000000,0> translate<54.838600,-1.535000,23.139400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.838600,-1.535000,22.885400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.118000,-1.535000,22.606000>}
box{<0,0,-0.203200><0.395131,0.035000,0.203200> rotate<0,44.997030,0> translate<54.838600,-1.535000,22.885400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<54.003500,-0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<55.308300,-0.000000,26.704800>}
box{<0,0,-0.101600><1.845266,0.035000,0.101600> rotate<0,-44.997030,0> translate<54.003500,-0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<54.571000,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<55.880000,-0.000000,4.191000>}
box{<0,0,-0.101600><1.309000,0.035000,0.101600> rotate<0,0.000000,0> translate<54.571000,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<55.880000,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<55.880000,-0.000000,5.334000>}
box{<0,0,-0.101600><1.143000,0.035000,0.101600> rotate<0,90.000000,0> translate<55.880000,-0.000000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<55.880000,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<55.894000,-0.000000,4.191000>}
box{<0,0,-0.101600><0.014000,0.035000,0.101600> rotate<0,0.000000,0> translate<55.880000,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<55.880000,-0.000000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.429000,-0.000000,5.883000>}
box{<0,0,-0.101600><0.776403,0.035000,0.101600> rotate<0,-44.997030,0> translate<55.880000,-0.000000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<54.356000,-0.000000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.515000,-0.000000,21.717000>}
box{<0,0,-0.101600><3.053287,0.035000,0.101600> rotate<0,44.997030,0> translate<54.356000,-0.000000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<54.737000,-0.000000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.896000,-0.000000,22.479000>}
box{<0,0,-0.101600><3.053287,0.035000,0.101600> rotate<0,44.997030,0> translate<54.737000,-0.000000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.911000,-0.000000,30.226000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.023000,-0.000000,30.226000>}
box{<0,0,-0.101600><7.112000,0.035000,0.101600> rotate<0,0.000000,0> translate<49.911000,-0.000000,30.226000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.015400,-0.000000,25.997700>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.195700,-0.000000,27.178000>}
box{<0,0,-0.101600><1.669196,0.035000,0.101600> rotate<0,-44.997030,0> translate<56.015400,-0.000000,25.997700> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.070000,-0.000000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.277000,-0.000000,29.464000>}
box{<0,0,-0.101600><5.207000,0.035000,0.101600> rotate<0,0.000000,0> translate<52.070000,-0.000000,29.464000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.343000,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.343000,-1.535000,23.779100>}
box{<0,0,-0.304800><1.112900,0.035000,0.304800> rotate<0,-90.000000,0> translate<57.343000,-1.535000,23.779100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.343000,-1.535000,25.019000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.343000,-1.535000,24.892000>}
box{<0,0,-0.304800><0.127000,0.035000,0.304800> rotate<0,-90.000000,0> translate<57.343000,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.292000,-1.535000,25.019000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.343000,-1.535000,25.019000>}
box{<0,0,-0.304800><7.051000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.292000,-1.535000,25.019000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.404000,-0.000000,6.529000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.404000,-0.000000,6.477000>}
box{<0,0,-0.101600><0.052000,0.035000,0.101600> rotate<0,-90.000000,0> translate<57.404000,-0.000000,6.477000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.404000,-0.000000,6.529000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.404000,-0.000000,7.179000>}
box{<0,0,-0.101600><0.650000,0.035000,0.101600> rotate<0,90.000000,0> translate<57.404000,-0.000000,7.179000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.882000,-0.000000,9.398000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.404000,-0.000000,9.398000>}
box{<0,0,-0.101600><0.522000,0.035000,0.101600> rotate<0,0.000000,0> translate<56.882000,-0.000000,9.398000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.429000,-0.000000,5.883000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.408000,-0.000000,5.883000>}
box{<0,0,-0.101600><0.979000,0.035000,0.101600> rotate<0,0.000000,0> translate<56.429000,-0.000000,5.883000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.404000,-0.000000,6.529000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.408000,-0.000000,6.533000>}
box{<0,0,-0.101600><0.005657,0.035000,0.101600> rotate<0,-44.997030,0> translate<57.404000,-0.000000,6.529000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.404000,-0.000000,7.179000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.408000,-0.000000,7.183000>}
box{<0,0,-0.101600><0.005657,0.035000,0.101600> rotate<0,-44.997030,0> translate<57.404000,-0.000000,7.179000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.408000,-0.000000,7.870000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.408000,-0.000000,7.833000>}
box{<0,0,-0.101600><0.037000,0.035000,0.101600> rotate<0,-90.000000,0> translate<57.408000,-0.000000,7.833000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.404000,-0.000000,9.398000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.408000,-0.000000,7.870000>}
box{<0,0,-0.101600><1.528005,0.035000,0.101600> rotate<0,89.844082,0> translate<57.404000,-0.000000,9.398000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.580200,-1.535000,12.934500>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.488700,-1.535000,13.843000>}
box{<0,0,-0.101600><1.284813,0.035000,0.101600> rotate<0,-44.997030,0> translate<56.580200,-1.535000,12.934500> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.488700,-1.535000,13.843000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.531000,-1.535000,13.843000>}
box{<0,0,-0.101600><0.042300,0.035000,0.101600> rotate<0,0.000000,0> translate<57.488700,-1.535000,13.843000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.531000,-1.535000,13.843000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.531000,-1.535000,13.876200>}
box{<0,0,-0.101600><0.033200,0.035000,0.101600> rotate<0,90.000000,0> translate<57.531000,-1.535000,13.876200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.531000,-1.535000,13.876200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.531000,-1.535000,14.605000>}
box{<0,0,-0.127000><0.728800,0.035000,0.127000> rotate<0,90.000000,0> translate<57.531000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.343000,-1.535000,21.178900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.627900,-1.535000,21.178900>}
box{<0,0,-0.203200><0.284900,0.035000,0.203200> rotate<0,0.000000,0> translate<57.343000,-1.535000,21.178900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.619000,-0.000000,2.833000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.644000,-0.000000,4.191000>}
box{<0,0,-0.203200><1.358230,0.035000,0.203200> rotate<0,-88.939467,0> translate<57.619000,-0.000000,2.833000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.562000,-0.000000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.658000,-0.000000,2.794000>}
box{<0,0,-0.203200><6.096000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.562000,-0.000000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.619000,-0.000000,2.833000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.658000,-0.000000,2.794000>}
box{<0,0,-0.203200><0.055154,0.035000,0.203200> rotate<0,44.997030,0> translate<57.619000,-0.000000,2.833000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.195700,-0.000000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.658000,-0.000000,27.178000>}
box{<0,0,-0.101600><0.462300,0.035000,0.101600> rotate<0,0.000000,0> translate<57.195700,-0.000000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.722500,-0.000000,25.290600>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.720900,-0.000000,26.289000>}
box{<0,0,-0.101600><1.411951,0.035000,0.101600> rotate<0,-44.997030,0> translate<56.722500,-0.000000,25.290600> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.720900,-0.000000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.785000,-0.000000,26.289000>}
box{<0,0,-0.101600><0.064100,0.035000,0.101600> rotate<0,0.000000,0> translate<57.720900,-0.000000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.531000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.912000,-1.535000,14.986000>}
box{<0,0,-0.127000><0.538815,0.035000,0.127000> rotate<0,-44.997030,0> translate<57.531000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.912000,-1.535000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.912000,-1.535000,15.113000>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,90.000000,0> translate<57.912000,-1.535000,15.113000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.912000,-1.535000,15.113000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.912000,-1.535000,15.240000>}
box{<0,0,-0.101600><0.127000,0.035000,0.101600> rotate<0,90.000000,0> translate<57.912000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.118000,-1.535000,22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.912000,-1.535000,22.606000>}
box{<0,0,-0.203200><2.794000,0.035000,0.203200> rotate<0,0.000000,0> translate<55.118000,-1.535000,22.606000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.912000,-1.535000,15.113000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.928300,-1.535000,15.096700>}
box{<0,0,-0.127000><0.023052,0.035000,0.127000> rotate<0,44.997030,0> translate<57.912000,-1.535000,15.113000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.785000,-1.535000,28.194000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.039000,-1.535000,28.448000>}
box{<0,0,-0.101600><0.359210,0.035000,0.101600> rotate<0,-44.997030,0> translate<57.785000,-1.535000,28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.277000,-0.000000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.039000,-0.000000,30.226000>}
box{<0,0,-0.101600><1.077631,0.035000,0.101600> rotate<0,-44.997030,0> translate<57.277000,-0.000000,29.464000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.408000,-0.000000,6.533000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.110000,-0.000000,6.533000>}
box{<0,0,-0.101600><0.702000,0.035000,0.101600> rotate<0,0.000000,0> translate<57.408000,-0.000000,6.533000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.896000,-0.000000,22.479000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.153500,-0.000000,22.479000>}
box{<0,0,-0.101600><1.257500,0.035000,0.101600> rotate<0,0.000000,0> translate<56.896000,-0.000000,22.479000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.658000,-0.000000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.293000,-0.000000,2.794000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<57.658000,-0.000000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.293000,-0.000000,14.739800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.293000,-0.000000,14.732000>}
box{<0,0,-0.101600><0.007800,0.035000,0.101600> rotate<0,-90.000000,0> translate<58.293000,-0.000000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.076000,-0.000000,15.956800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.293000,-0.000000,14.739800>}
box{<0,0,-0.101600><1.721098,0.035000,0.101600> rotate<0,44.997030,0> translate<57.076000,-0.000000,15.956800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.912000,-1.535000,22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.293000,-1.535000,22.987000>}
box{<0,0,-0.203200><0.538815,0.035000,0.203200> rotate<0,-44.997030,0> translate<57.912000,-1.535000,22.606000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.293000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.293000,-1.535000,23.779100>}
box{<0,0,-0.203200><0.792100,0.035000,0.203200> rotate<0,90.000000,0> translate<58.293000,-1.535000,23.779100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.293000,-0.000000,14.732000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.419900,-0.000000,14.732000>}
box{<0,0,-0.101600><0.126900,0.035000,0.101600> rotate<0,0.000000,0> translate<58.293000,-0.000000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.429600,-0.000000,24.583500>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.420000,-0.000000,25.573900>}
box{<0,0,-0.101600><1.400637,0.035000,0.101600> rotate<0,-44.997030,0> translate<57.429600,-0.000000,24.583500> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.420000,-0.000000,25.573900>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.420000,-0.000000,25.654000>}
box{<0,0,-0.101600><0.080100,0.035000,0.101600> rotate<0,90.000000,0> translate<58.420000,-0.000000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.496200,-0.000000,28.905200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.547000,-0.000000,27.813000>}
box{<0,0,-0.203200><1.093381,0.035000,0.203200> rotate<0,87.331235,0> translate<58.496200,-0.000000,28.905200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.508900,-0.000000,27.597100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.547000,-0.000000,27.813000>}
box{<0,0,-0.203200><0.219236,0.035000,0.203200> rotate<0,-79.986741,0> translate<58.508900,-0.000000,27.597100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.343000,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.674000,-1.535000,24.892000>}
box{<0,0,-0.101600><1.331000,0.035000,0.101600> rotate<0,0.000000,0> translate<57.343000,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.419900,-0.000000,14.732000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.690200,-0.000000,14.969700>}
box{<0,0,-0.101600><0.359949,0.035000,0.101600> rotate<0,-41.325452,0> translate<58.419900,-0.000000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.994400,-1.535000,4.661400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.718800,-1.535000,3.937000>}
box{<0,0,-0.101600><1.024456,0.035000,0.101600> rotate<0,44.997030,0> translate<57.994400,-1.535000,4.661400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.801000,-1.535000,2.480900>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.801000,-1.535000,2.413000>}
box{<0,0,-0.127000><0.067900,0.035000,0.127000> rotate<0,-90.000000,0> translate<58.801000,-1.535000,2.413000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.515000,-0.000000,21.717000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.805700,-0.000000,21.717000>}
box{<0,0,-0.101600><2.290700,0.035000,0.101600> rotate<0,0.000000,0> translate<56.515000,-0.000000,21.717000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.718800,-1.535000,3.937000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.814900,-1.535000,3.937000>}
box{<0,0,-0.101600><0.096100,0.035000,0.101600> rotate<0,0.000000,0> translate<58.718800,-1.535000,3.937000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.153500,-0.000000,22.479000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.843800,-0.000000,23.169300>}
box{<0,0,-0.101600><0.976232,0.035000,0.101600> rotate<0,-44.997030,0> translate<58.153500,-0.000000,22.479000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.293000,-0.000000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.928000,-0.000000,3.429000>}
box{<0,0,-0.203200><0.898026,0.035000,0.203200> rotate<0,-44.997030,0> translate<58.293000,-0.000000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.627900,-1.535000,21.178900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.928000,-1.535000,22.479000>}
box{<0,0,-0.203200><1.838619,0.035000,0.203200> rotate<0,-44.997030,0> translate<57.627900,-1.535000,21.178900> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.722500,-0.000000,15.603300>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.990800,-0.000000,13.335000>}
box{<0,0,-0.101600><3.207861,0.035000,0.101600> rotate<0,44.997030,0> translate<56.722500,-0.000000,15.603300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.168000,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.182000,-1.535000,19.558000>}
box{<0,0,-0.203200><0.014000,0.035000,0.203200> rotate<0,0.000000,0> translate<59.168000,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.182000,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.243000,-1.535000,19.619000>}
box{<0,0,-0.203200><0.086267,0.035000,0.203200> rotate<0,-44.997030,0> translate<59.182000,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.243000,-1.535000,19.619000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.243000,-1.535000,21.178900>}
box{<0,0,-0.203200><1.559900,0.035000,0.203200> rotate<0,90.000000,0> translate<59.243000,-1.535000,21.178900> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.243000,-1.535000,24.323000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.243000,-1.535000,23.779100>}
box{<0,0,-0.101600><0.543900,0.035000,0.101600> rotate<0,-90.000000,0> translate<59.243000,-1.535000,23.779100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.674000,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.243000,-1.535000,24.323000>}
box{<0,0,-0.101600><0.804688,0.035000,0.101600> rotate<0,44.997030,0> translate<58.674000,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.110000,-0.000000,6.533000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.309000,-0.000000,5.334000>}
box{<0,0,-0.101600><1.695642,0.035000,0.101600> rotate<0,44.997030,0> translate<58.110000,-0.000000,6.533000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.309000,-0.000000,4.975000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.309000,-0.000000,5.334000>}
box{<0,0,-0.101600><0.359000,0.035000,0.101600> rotate<0,90.000000,0> translate<59.309000,-0.000000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.690200,-0.000000,14.969700>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.309000,-0.000000,15.553100>}
box{<0,0,-0.101600><0.850452,0.035000,0.101600> rotate<0,-43.310496,0> translate<58.690200,-0.000000,14.969700> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.309000,-0.000000,15.553100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.309000,-0.000000,15.621000>}
box{<0,0,-0.101600><0.067900,0.035000,0.101600> rotate<0,90.000000,0> translate<59.309000,-0.000000,15.621000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.420000,-0.000000,29.591000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.436000,-0.000000,29.591000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<58.420000,-0.000000,29.591000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.508900,-0.000000,27.597100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.474100,-0.000000,27.597100>}
box{<0,0,-0.203200><0.965200,0.035000,0.203200> rotate<0,0.000000,0> translate<58.508900,-0.000000,27.597100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.496200,-0.000000,28.905200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.474100,-0.000000,28.905200>}
box{<0,0,-0.203200><0.977900,0.035000,0.203200> rotate<0,0.000000,0> translate<58.496200,-0.000000,28.905200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.436000,-0.000000,29.591000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.474100,-0.000000,29.552900>}
box{<0,0,-0.127000><0.053882,0.035000,0.127000> rotate<0,44.997030,0> translate<59.436000,-0.000000,29.591000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.990800,-0.000000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.495100,-0.000000,13.335000>}
box{<0,0,-0.101600><0.504300,0.035000,0.101600> rotate<0,0.000000,0> translate<58.990800,-0.000000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.136700,-0.000000,23.876400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.533300,-0.000000,25.273000>}
box{<0,0,-0.101600><1.975091,0.035000,0.101600> rotate<0,-44.997030,0> translate<58.136700,-0.000000,23.876400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.805700,-0.000000,21.717000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.550900,-0.000000,22.462200>}
box{<0,0,-0.101600><1.053872,0.035000,0.101600> rotate<0,-44.997030,0> translate<58.805700,-0.000000,21.717000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.814900,-1.535000,3.937000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,3.937000>}
box{<0,0,-0.127000><0.875100,0.035000,0.127000> rotate<0,0.000000,0> translate<58.814900,-1.535000,3.937000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.495100,-0.000000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.927700,-0.000000,13.732200>}
box{<0,0,-0.101600><0.587291,0.035000,0.101600> rotate<0,-42.554384,0> translate<59.495100,-0.000000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.533300,-0.000000,25.273000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.944000,-0.000000,25.273000>}
box{<0,0,-0.101600><0.410700,0.035000,0.101600> rotate<0,0.000000,0> translate<59.533300,-0.000000,25.273000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.944000,-0.000000,25.273000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.944000,-0.000000,25.332100>}
box{<0,0,-0.101600><0.059100,0.035000,0.101600> rotate<0,90.000000,0> translate<59.944000,-0.000000,25.332100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.944000,-0.000000,25.332100>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.960200,-0.000000,25.383700>}
box{<0,0,-0.101600><0.054083,0.035000,0.101600> rotate<0,-72.565348,0> translate<59.944000,-0.000000,25.332100> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.690000,-1.535000,3.937000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.198000,-1.535000,3.429000>}
box{<0,0,-0.127000><0.718420,0.035000,0.127000> rotate<0,44.997030,0> translate<59.690000,-1.535000,3.937000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.198000,-1.535000,3.429000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.198100,-1.535000,3.429000>}
box{<0,0,-0.127000><0.000100,0.035000,0.127000> rotate<0,0.000000,0> translate<60.198000,-1.535000,3.429000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<58.801000,-1.535000,2.480900>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.214300,-1.535000,3.445200>}
box{<0,0,-0.127000><1.710933,0.035000,0.127000> rotate<0,-34.303604,0> translate<58.801000,-1.535000,2.480900> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.198100,-1.535000,3.429000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.214300,-1.535000,3.445200>}
box{<0,0,-0.127000><0.022910,0.035000,0.127000> rotate<0,-44.997030,0> translate<60.198100,-1.535000,3.429000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.309000,-0.000000,7.725000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<60.855000,-0.000000,9.271000>}
box{<0,0,-0.101600><2.186374,0.035000,0.101600> rotate<0,-44.997030,0> translate<59.309000,-0.000000,7.725000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,22.479000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,22.076000>}
box{<0,0,-0.203200><0.403000,0.035000,0.203200> rotate<0,-90.000000,0> translate<60.960000,-1.535000,22.076000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.928000,-1.535000,22.479000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,22.479000>}
box{<0,0,-0.203200><2.032000,0.035000,0.203200> rotate<0,0.000000,0> translate<58.928000,-1.535000,22.479000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.039000,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.087000,-1.535000,28.448000>}
box{<0,0,-0.101600><3.048000,0.035000,0.101600> rotate<0,0.000000,0> translate<58.039000,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.087000,-0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.146100,-0.000000,24.130000>}
box{<0,0,-0.101600><0.059100,0.035000,0.101600> rotate<0,0.000000,0> translate<61.087000,-0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.146100,-0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.197700,-0.000000,24.146200>}
box{<0,0,-0.101600><0.054083,0.035000,0.101600> rotate<0,-17.428713,0> translate<61.146100,-0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.197700,-0.000000,24.146200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.213900,-0.000000,24.130000>}
box{<0,0,-0.101600><0.022910,0.035000,0.101600> rotate<0,44.997030,0> translate<61.197700,-0.000000,24.146200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.904400,-0.000000,22.108700>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.214000,-0.000000,23.418300>}
box{<0,0,-0.101600><1.852054,0.035000,0.101600> rotate<0,-44.997030,0> translate<59.904400,-0.000000,22.108700> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.213900,-0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.214000,-0.000000,24.130000>}
box{<0,0,-0.101600><0.000100,0.035000,0.101600> rotate<0,0.000000,0> translate<61.213900,-0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.214000,-0.000000,23.418300>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.214000,-0.000000,24.130000>}
box{<0,0,-0.101600><0.711700,0.035000,0.101600> rotate<0,90.000000,0> translate<61.214000,-0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.658000,-1.535000,29.083000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.214000,-1.535000,29.083000>}
box{<0,0,-0.101600><3.556000,0.035000,0.101600> rotate<0,0.000000,0> translate<57.658000,-1.535000,29.083000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.341000,-0.000000,6.184000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.341000,-0.000000,7.532000>}
box{<0,0,-0.101600><1.348000,0.035000,0.101600> rotate<0,90.000000,0> translate<61.341000,-0.000000,7.532000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.341000,-0.000000,9.271000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.341000,-0.000000,9.232000>}
box{<0,0,-0.101600><0.039000,0.035000,0.101600> rotate<0,-90.000000,0> translate<61.341000,-0.000000,9.232000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<60.855000,-0.000000,9.271000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.341000,-0.000000,9.271000>}
box{<0,0,-0.101600><0.486000,0.035000,0.101600> rotate<0,0.000000,0> translate<60.855000,-0.000000,9.271000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-1.535000,22.479000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.849000,-1.535000,21.590000>}
box{<0,0,-0.203200><1.257236,0.035000,0.203200> rotate<0,44.997030,0> translate<60.960000,-1.535000,22.479000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.474100,-0.000000,28.244800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.052200,-0.000000,28.244800>}
box{<0,0,-0.203200><2.578100,0.035000,0.203200> rotate<0,0.000000,0> translate<59.474100,-0.000000,28.244800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.849000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.103000,-1.535000,21.590000>}
box{<0,0,-0.203200><0.254000,0.035000,0.203200> rotate<0,0.000000,0> translate<61.849000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.087000,-0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<62.103000,-0.000000,23.114000>}
box{<0,0,-0.101600><1.436841,0.035000,0.101600> rotate<0,44.997030,0> translate<61.087000,-0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.103000,-0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-0.000000,21.717000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,-44.997030,0> translate<62.103000,-0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.052200,-0.000000,28.244800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.611000,-0.000000,27.686000>}
box{<0,0,-0.203200><0.790263,0.035000,0.203200> rotate<0,44.997030,0> translate<62.052200,-0.000000,28.244800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.611000,-0.000000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.611000,-0.000000,27.686000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,90.000000,0> translate<62.611000,-0.000000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.611000,-1.535000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.650000,-1.535000,11.303000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,0.000000,0> translate<62.611000,-1.535000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.650000,-1.535000,9.867000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.650000,-1.535000,11.303000>}
box{<0,0,-0.127000><1.436000,0.035000,0.127000> rotate<0,90.000000,0> translate<62.650000,-1.535000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.611000,-1.535000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.650000,-1.535000,11.342000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,-44.997030,0> translate<62.611000,-1.535000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.650000,-1.535000,11.342000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.650000,-1.535000,13.335000>}
box{<0,0,-0.127000><1.993000,0.035000,0.127000> rotate<0,90.000000,0> translate<62.650000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.650000,-1.535000,9.867000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.738000,-1.535000,9.779000>}
box{<0,0,-0.127000><0.124451,0.035000,0.127000> rotate<0,44.997030,0> translate<62.650000,-1.535000,9.867000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.611000,-0.000000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.738000,-0.000000,26.289000>}
box{<0,0,-0.203200><0.179605,0.035000,0.203200> rotate<0,44.997030,0> translate<62.611000,-0.000000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.738000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.752000,-1.535000,9.779000>}
box{<0,0,-0.127000><0.014000,0.035000,0.127000> rotate<0,0.000000,0> translate<62.738000,-1.535000,9.779000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.865000,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.865000,-1.535000,24.638000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,90.000000,0> translate<62.865000,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.738000,-0.000000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-0.000000,26.289000>}
box{<0,0,-0.203200><0.127000,0.035000,0.203200> rotate<0,0.000000,0> translate<62.738000,-0.000000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.087000,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<62.865000,-1.535000,26.670000>}
box{<0,0,-0.101600><2.514472,0.035000,0.101600> rotate<0,44.997030,0> translate<61.087000,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<62.865000,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<62.865000,-1.535000,26.670000>}
box{<0,0,-0.101600><2.032000,0.035000,0.101600> rotate<0,90.000000,0> translate<62.865000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<62.398000,-0.000000,11.408000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.048000,-0.000000,11.408000>}
box{<0,0,-0.101600><0.650000,0.035000,0.101600> rotate<0,0.000000,0> translate<62.398000,-0.000000,11.408000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.119000,-0.000000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.119000,-0.000000,9.709200>}
box{<0,0,-0.101600><7.423200,0.035000,0.101600> rotate<0,90.000000,0> translate<63.119000,-0.000000,9.709200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.103000,-0.000000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.119000,-0.000000,23.136000>}
box{<0,0,-0.127000><1.016238,0.035000,0.127000> rotate<0,-1.240381,0> translate<62.103000,-0.000000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-0.000000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.119000,-0.000000,25.886000>}
box{<0,0,-0.203200><0.476366,0.035000,0.203200> rotate<0,57.774065,0> translate<62.865000,-0.000000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.865000,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.246000,-1.535000,16.637000>}
box{<0,0,-0.127000><0.538815,0.035000,0.127000> rotate<0,44.997030,0> translate<62.865000,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.119000,-0.000000,25.886000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.522000,-0.000000,26.289000>}
box{<0,0,-0.203200><0.569928,0.035000,0.203200> rotate<0,-44.997030,0> translate<63.119000,-0.000000,25.886000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.627000,-0.000000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.627000,-0.000000,9.908200>}
box{<0,0,-0.101600><1.653200,0.035000,0.101600> rotate<0,90.000000,0> translate<63.627000,-0.000000,9.908200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.048000,-0.000000,11.408000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.698000,-0.000000,11.408000>}
box{<0,0,-0.101600><0.650000,0.035000,0.101600> rotate<0,0.000000,0> translate<63.048000,-0.000000,11.408000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,28.232100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,28.244800>}
box{<0,0,-0.203200><0.012700,0.035000,0.203200> rotate<0,90.000000,0> translate<63.715900,-0.000000,28.244800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,28.244800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,28.905200>}
box{<0,0,-0.203200><0.660400,0.035000,0.203200> rotate<0,90.000000,0> translate<63.715900,-0.000000,28.905200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,28.905200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,28.917900>}
box{<0,0,-0.203200><0.012700,0.035000,0.203200> rotate<0,90.000000,0> translate<63.715900,-0.000000,28.917900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,28.994100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,29.552900>}
box{<0,0,-0.203200><0.558800,0.035000,0.203200> rotate<0,90.000000,0> translate<63.715900,-0.000000,29.552900> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.754000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.754000,-1.535000,25.146000>}
box{<0,0,-0.127000><4.191000,0.035000,0.127000> rotate<0,90.000000,0> translate<63.754000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.214000,-1.535000,29.083000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.754000,-1.535000,26.543000>}
box{<0,0,-0.101600><3.592102,0.035000,0.101600> rotate<0,44.997030,0> translate<61.214000,-1.535000,29.083000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.754000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.754000,-1.535000,26.543000>}
box{<0,0,-0.101600><1.397000,0.035000,0.101600> rotate<0,90.000000,0> translate<63.754000,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,27.597100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.754000,-0.000000,27.559000>}
box{<0,0,-0.203200><0.053882,0.035000,0.203200> rotate<0,44.997030,0> translate<63.715900,-0.000000,27.597100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,28.232100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.754000,-0.000000,28.194000>}
box{<0,0,-0.203200><0.053882,0.035000,0.203200> rotate<0,44.997030,0> translate<63.715900,-0.000000,28.232100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.754000,-0.000000,27.559000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.754000,-0.000000,28.194000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,90.000000,0> translate<63.754000,-0.000000,28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,28.917900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.754000,-0.000000,28.956000>}
box{<0,0,-0.203200><0.053882,0.035000,0.203200> rotate<0,-44.997030,0> translate<63.715900,-0.000000,28.917900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,28.994100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.754000,-0.000000,28.956000>}
box{<0,0,-0.203200><0.053882,0.035000,0.203200> rotate<0,44.997030,0> translate<63.715900,-0.000000,28.994100> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.627000,-0.000000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.881000,-0.000000,8.001000>}
box{<0,0,-0.101600><0.359210,0.035000,0.101600> rotate<0,44.997030,0> translate<63.627000,-0.000000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.008000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.047000,-1.535000,17.741000>}
box{<0,0,-0.101600><0.055154,0.035000,0.101600> rotate<0,44.997030,0> translate<64.008000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.022000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.047000,-1.535000,17.741000>}
box{<0,0,-0.101600><0.091482,0.035000,0.101600> rotate<0,-74.135741,0> translate<64.022000,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.008000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.047000,-1.535000,17.819000>}
box{<0,0,-0.101600><0.055154,0.035000,0.101600> rotate<0,-44.997030,0> translate<64.008000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.047000,-1.535000,17.819000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.047000,-1.535000,19.685000>}
box{<0,0,-0.101600><1.866000,0.035000,0.101600> rotate<0,90.000000,0> translate<64.047000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.230000,-0.000000,21.717000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.262000,-0.000000,21.717000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,0.000000,0> translate<62.230000,-0.000000,21.717000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.350000,-1.535000,13.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.350000,-1.535000,13.335000>}
box{<0,0,-0.127000><0.215000,0.035000,0.127000> rotate<0,90.000000,0> translate<64.350000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.350000,-1.535000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.389000,-1.535000,11.303000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.350000,-1.535000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.389000,-1.535000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.403000,-1.535000,11.317000>}
box{<0,0,-0.127000><0.019799,0.035000,0.127000> rotate<0,-44.997030,0> translate<64.389000,-1.535000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.350000,-1.535000,13.120000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.403000,-1.535000,13.067000>}
box{<0,0,-0.127000><0.074953,0.035000,0.127000> rotate<0,44.997030,0> translate<64.350000,-1.535000,13.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.502000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.516000,-1.535000,9.779000>}
box{<0,0,-0.127000><0.014000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.502000,-1.535000,9.779000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.047000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.643000,-1.535000,20.281000>}
box{<0,0,-0.127000><0.842871,0.035000,0.127000> rotate<0,-44.997030,0> translate<64.047000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.643000,-1.535000,20.281000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.643000,-1.535000,21.336000>}
box{<0,0,-0.127000><1.055000,0.035000,0.127000> rotate<0,90.000000,0> translate<64.643000,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.119000,-0.000000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.770000,-0.000000,0.635000>}
box{<0,0,-0.101600><2.334867,0.035000,0.101600> rotate<0,44.997030,0> translate<63.119000,-0.000000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.770000,-0.000000,6.311000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.770000,-0.000000,7.913000>}
box{<0,0,-0.101600><1.602000,0.035000,0.101600> rotate<0,90.000000,0> translate<64.770000,-0.000000,7.913000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.881000,-0.000000,8.001000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.770000,-0.000000,8.001000>}
box{<0,0,-0.101600><0.889000,0.035000,0.101600> rotate<0,0.000000,0> translate<63.881000,-0.000000,8.001000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.770000,-0.000000,7.913000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.770000,-0.000000,8.001000>}
box{<0,0,-0.101600><0.088000,0.035000,0.101600> rotate<0,90.000000,0> translate<64.770000,-0.000000,8.001000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.715900,-0.000000,29.552900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.808100,-0.000000,29.552900>}
box{<0,0,-0.203200><1.092200,0.035000,0.203200> rotate<0,0.000000,0> translate<63.715900,-0.000000,29.552900> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.643000,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.858000,-1.535000,21.336000>}
box{<0,0,-0.127000><0.215000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.643000,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.858000,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.897000,-1.535000,21.375000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,-44.997030,0> translate<64.858000,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.897000,-1.535000,21.375000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.897000,-1.535000,21.463000>}
box{<0,0,-0.127000><0.088000,0.035000,0.127000> rotate<0,90.000000,0> translate<64.897000,-1.535000,21.463000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.262000,-0.000000,21.717000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.897000,-0.000000,22.352000>}
box{<0,0,-0.127000><0.898026,0.035000,0.127000> rotate<0,-44.997030,0> translate<64.262000,-0.000000,21.717000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.897000,-0.000000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.897000,-0.000000,24.550000>}
box{<0,0,-0.127000><2.198000,0.035000,0.127000> rotate<0,90.000000,0> translate<64.897000,-0.000000,24.550000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.897000,-0.000000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.897000,-0.000000,26.250000>}
box{<0,0,-0.203200><0.039000,0.035000,0.203200> rotate<0,-90.000000,0> translate<64.897000,-0.000000,26.250000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.522000,-0.000000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.897000,-0.000000,26.289000>}
box{<0,0,-0.203200><1.375000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.522000,-0.000000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.897000,-0.000000,29.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.897000,-0.000000,27.940000>}
box{<0,0,-0.203200><1.510000,0.035000,0.203200> rotate<0,-90.000000,0> translate<64.897000,-0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.808100,-0.000000,29.552900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.897000,-0.000000,29.464000>}
box{<0,0,-0.203200><0.125724,0.035000,0.203200> rotate<0,44.997030,0> translate<64.808100,-0.000000,29.552900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.897000,-0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.911000,-0.000000,27.940000>}
box{<0,0,-0.203200><0.014000,0.035000,0.203200> rotate<0,0.000000,0> translate<64.897000,-0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.897000,-0.000000,29.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.911000,-0.000000,29.464000>}
box{<0,0,-0.203200><0.019799,0.035000,0.203200> rotate<0,-44.997030,0> translate<64.897000,-0.000000,29.450000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.897000,-0.000000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.911000,-0.000000,29.464000>}
box{<0,0,-0.203200><0.014000,0.035000,0.203200> rotate<0,0.000000,0> translate<64.897000,-0.000000,29.464000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.897000,-1.535000,23.075000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.936000,-1.535000,23.114000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,-44.997030,0> translate<64.897000,-1.535000,23.075000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<63.246000,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.024000,-1.535000,16.637000>}
box{<0,0,-0.127000><1.778000,0.035000,0.127000> rotate<0,0.000000,0> translate<63.246000,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.936000,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.278000,-1.535000,23.114000>}
box{<0,0,-0.127000><0.342000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.936000,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.278000,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.278000,-1.535000,25.146000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,90.000000,0> translate<65.278000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.516000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.405000,-1.535000,8.890000>}
box{<0,0,-0.127000><1.257236,0.035000,0.127000> rotate<0,44.997030,0> translate<64.516000,-1.535000,9.779000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<65.571000,-0.000000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<65.571000,-0.000000,2.579000>}
box{<0,0,-0.101600><0.801000,0.035000,0.101600> rotate<0,90.000000,0> translate<65.571000,-0.000000,2.579000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.403000,-1.535000,11.317000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,11.317000>}
box{<0,0,-0.127000><1.256000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.403000,-1.535000,11.317000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,11.317000>}
box{<0,0,-0.127000><1.538000,0.035000,0.127000> rotate<0,90.000000,0> translate<65.659000,-1.535000,11.317000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.403000,-1.535000,13.067000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,13.067000>}
box{<0,0,-0.127000><1.256000,0.035000,0.127000> rotate<0,0.000000,0> translate<64.403000,-1.535000,13.067000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,17.741000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,19.597000>}
box{<0,0,-0.127000><1.856000,0.035000,0.127000> rotate<0,90.000000,0> translate<65.659000,-1.535000,19.597000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,19.862800>}
box{<0,0,-0.127000><0.177800,0.035000,0.127000> rotate<0,90.000000,0> translate<65.659000,-1.535000,19.862800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.024000,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.747000,-1.535000,17.360000>}
box{<0,0,-0.127000><1.022476,0.035000,0.127000> rotate<0,-44.997030,0> translate<65.024000,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,19.597000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.747000,-1.535000,19.685000>}
box{<0,0,-0.127000><0.124451,0.035000,0.127000> rotate<0,-44.997030,0> translate<65.659000,-1.535000,19.597000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.747000,-1.535000,19.685000>}
box{<0,0,-0.127000><0.088000,0.035000,0.127000> rotate<0,0.000000,0> translate<65.659000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,13.067000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.772000,-1.535000,13.067000>}
box{<0,0,-0.127000><0.113000,0.035000,0.127000> rotate<0,0.000000,0> translate<65.659000,-1.535000,13.067000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,17.741000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.772000,-1.535000,17.653000>}
box{<0,0,-0.127000><0.143224,0.035000,0.127000> rotate<0,37.907568,0> translate<65.659000,-1.535000,17.741000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.747000,-1.535000,17.360000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.772000,-1.535000,17.653000>}
box{<0,0,-0.127000><0.294065,0.035000,0.127000> rotate<0,-85.117476,0> translate<65.747000,-1.535000,17.360000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.772000,-1.535000,13.067000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.786000,-1.535000,13.081000>}
box{<0,0,-0.127000><0.019799,0.035000,0.127000> rotate<0,-44.997030,0> translate<65.772000,-1.535000,13.067000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.913000,-1.535000,9.525000>}
box{<0,0,-0.127000><0.359210,0.035000,0.127000> rotate<0,44.997030,0> translate<65.659000,-1.535000,9.779000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-0.000000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-0.000000,24.638000>}
box{<0,0,-0.127000><4.064000,0.035000,0.127000> rotate<0,90.000000,0> translate<66.040000,-0.000000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.786000,-1.535000,13.081000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,-1.535000,13.081000>}
box{<0,0,-0.127000><0.508000,0.035000,0.127000> rotate<0,0.000000,0> translate<65.786000,-1.535000,13.081000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.770000,-0.000000,4.611000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.382000,-0.000000,4.611000>}
box{<0,0,-0.101600><1.612000,0.035000,0.101600> rotate<0,0.000000,0> translate<64.770000,-0.000000,4.611000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.770000,-0.000000,9.613000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.382000,-0.000000,9.613000>}
box{<0,0,-0.101600><1.612000,0.035000,0.101600> rotate<0,0.000000,0> translate<64.770000,-0.000000,9.613000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<64.770000,-0.000000,0.635000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,0.635000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<64.770000,-0.000000,0.635000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<65.571000,-0.000000,2.579000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,3.429000>}
box{<0,0,-0.101600><1.202082,0.035000,0.101600> rotate<0,-44.997030,0> translate<65.571000,-0.000000,2.579000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.382000,-0.000000,4.611000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,4.572000>}
box{<0,0,-0.101600><0.055154,0.035000,0.101600> rotate<0,44.997030,0> translate<66.382000,-0.000000,4.611000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,3.429000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,4.572000>}
box{<0,0,-0.101600><1.143000,0.035000,0.101600> rotate<0,90.000000,0> translate<66.421000,-0.000000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,4.586000>}
box{<0,0,-0.101600><0.014000,0.035000,0.101600> rotate<0,90.000000,0> translate<66.421000,-0.000000,4.586000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,7.888000>}
box{<0,0,-0.101600><0.014000,0.035000,0.101600> rotate<0,90.000000,0> translate<66.421000,-0.000000,7.888000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,9.652000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,9.638000>}
box{<0,0,-0.101600><0.014000,0.035000,0.101600> rotate<0,-90.000000,0> translate<66.421000,-0.000000,9.638000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.382000,-0.000000,9.613000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,9.652000>}
box{<0,0,-0.101600><0.055154,0.035000,0.101600> rotate<0,-44.997030,0> translate<66.382000,-0.000000,9.613000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<63.754000,-0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,18.415000>}
box{<0,0,-0.101600><3.683000,0.035000,0.101600> rotate<0,43.599941,0> translate<63.754000,-0.000000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-0.000000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,-0.000000,25.019000>}
box{<0,0,-0.127000><0.538815,0.035000,0.127000> rotate<0,-44.997030,0> translate<66.040000,-0.000000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.278000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,-1.535000,26.289000>}
box{<0,0,-0.127000><1.616446,0.035000,0.127000> rotate<0,-44.997030,0> translate<65.278000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,6.336000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.534000,-0.000000,6.336000>}
box{<0,0,-0.101600><0.113000,0.035000,0.101600> rotate<0,0.000000,0> translate<66.421000,-0.000000,6.336000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.534000,-0.000000,6.336000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.548000,-0.000000,6.350000>}
box{<0,0,-0.101600><0.019799,0.035000,0.101600> rotate<0,-44.997030,0> translate<66.534000,-0.000000,6.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.405000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,8.890000>}
box{<0,0,-0.127000><1.219200,0.035000,0.127000> rotate<0,0.000000,0> translate<65.405000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.913000,-1.535000,9.525000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,9.525000>}
box{<0,0,-0.127000><0.711200,0.035000,0.127000> rotate<0,0.000000,0> translate<65.913000,-1.535000,9.525000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,-1.535000,13.081000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,12.750800>}
box{<0,0,-0.127000><0.466973,0.035000,0.127000> rotate<0,44.997030,0> translate<66.294000,-1.535000,13.081000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,12.750800>}
box{<0,0,-0.127000><2.590800,0.035000,0.127000> rotate<0,90.000000,0> translate<66.624200,-1.535000,12.750800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<65.659000,-1.535000,19.862800>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,20.828000>}
box{<0,0,-0.127000><1.364999,0.035000,0.127000> rotate<0,-44.997030,0> translate<65.659000,-1.535000,19.862800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<64.897000,-1.535000,21.463000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,21.463000>}
box{<0,0,-0.127000><1.727200,0.035000,0.127000> rotate<0,0.000000,0> translate<64.897000,-1.535000,21.463000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.548000,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,22.098000>}
box{<0,0,-0.127000><0.076200,0.035000,0.127000> rotate<0,0.000000,0> translate<66.548000,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.661000,-0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.675000,-0.000000,27.954000>}
box{<0,0,-0.203200><0.019799,0.035000,0.203200> rotate<0,-44.997030,0> translate<66.661000,-0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.675000,-0.000000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.675000,-0.000000,27.954000>}
box{<0,0,-0.203200><1.510000,0.035000,0.203200> rotate<0,-90.000000,0> translate<66.675000,-0.000000,27.954000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.661000,-0.000000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.675000,-0.000000,29.464000>}
box{<0,0,-0.203200><0.014000,0.035000,0.203200> rotate<0,0.000000,0> translate<66.661000,-0.000000,29.464000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.056000,-0.000000,7.874000>}
box{<0,0,-0.101600><0.635000,0.035000,0.101600> rotate<0,0.000000,0> translate<66.421000,-0.000000,7.874000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.056000,-0.000000,18.415000>}
box{<0,0,-0.101600><0.635000,0.035000,0.101600> rotate<0,0.000000,0> translate<66.421000,-0.000000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,0.635000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.183000,-0.000000,1.397000>}
box{<0,0,-0.101600><1.077631,0.035000,0.101600> rotate<0,-44.997030,0> translate<66.421000,-0.000000,0.635000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.183000,-0.000000,1.397000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.183000,-0.000000,1.690000>}
box{<0,0,-0.101600><0.293000,0.035000,0.101600> rotate<0,90.000000,0> translate<67.183000,-0.000000,1.690000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.183000,-0.000000,1.690000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.271000,-0.000000,1.778000>}
box{<0,0,-0.101600><0.124451,0.035000,0.101600> rotate<0,-44.997030,0> translate<67.183000,-0.000000,1.690000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.548000,-0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.310000,-0.000000,6.350000>}
box{<0,0,-0.101600><0.762000,0.035000,0.101600> rotate<0,0.000000,0> translate<66.548000,-0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.437000,-1.535000,19.392000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.437000,-1.535000,19.431000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,90.000000,0> translate<67.437000,-1.535000,19.431000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,22.733000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.437000,-1.535000,22.733000>}
box{<0,0,-0.127000><0.812800,0.035000,0.127000> rotate<0,0.000000,0> translate<66.624200,-1.535000,22.733000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.056000,-0.000000,7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.526000,-0.000000,7.404000>}
box{<0,0,-0.101600><0.664680,0.035000,0.101600> rotate<0,44.997030,0> translate<67.056000,-0.000000,7.874000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.310000,-0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.564000,-0.000000,6.604000>}
box{<0,0,-0.101600><0.359210,0.035000,0.101600> rotate<0,-44.997030,0> translate<67.310000,-0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.040000,-0.000000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.691000,-0.000000,18.923000>}
box{<0,0,-0.127000><2.334867,0.035000,0.127000> rotate<0,44.997030,0> translate<66.040000,-0.000000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.691000,-0.000000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.691000,-0.000000,22.479000>}
box{<0,0,-0.127000><2.667000,0.035000,0.127000> rotate<0,90.000000,0> translate<67.691000,-0.000000,22.479000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,-0.000000,25.019000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.691000,-0.000000,25.019000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<66.421000,-0.000000,25.019000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.421000,-0.000000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.691000,-0.000000,26.289000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<66.421000,-0.000000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.437000,-1.535000,19.431000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.818000,-1.535000,19.812000>}
box{<0,0,-0.127000><0.538815,0.035000,0.127000> rotate<0,-44.997030,0> translate<67.437000,-1.535000,19.431000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.818000,-1.535000,22.098000>}
box{<0,0,-0.127000><1.193800,0.035000,0.127000> rotate<0,0.000000,0> translate<66.624200,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.818000,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.818000,-1.535000,22.098000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,90.000000,0> translate<67.818000,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.691000,-0.000000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.072000,-0.000000,19.431000>}
box{<0,0,-0.127000><0.538815,0.035000,0.127000> rotate<0,44.997030,0> translate<67.691000,-0.000000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,9.638000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<68.086000,-0.000000,9.638000>}
box{<0,0,-0.101600><1.665000,0.035000,0.101600> rotate<0,0.000000,0> translate<66.421000,-0.000000,9.638000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.929000,-0.000000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<68.086000,-0.000000,11.303000>}
box{<0,0,-0.101600><1.157000,0.035000,0.101600> rotate<0,0.000000,0> translate<66.929000,-0.000000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.818000,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.199000,-1.535000,22.098000>}
box{<0,0,-0.127000><0.381000,0.035000,0.127000> rotate<0,0.000000,0> translate<67.818000,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.437000,-1.535000,22.733000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.453000,-1.535000,23.749000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,-44.997030,0> translate<67.437000,-1.535000,22.733000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.453000,-1.535000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.492000,-1.535000,26.328000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,-44.997030,0> translate<68.453000,-1.535000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.492000,-1.535000,26.328000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.492000,-1.535000,26.416000>}
box{<0,0,-0.127000><0.088000,0.035000,0.127000> rotate<0,90.000000,0> translate<68.492000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.453000,-1.535000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,26.162000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,44.997030,0> translate<68.453000,-1.535000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,26.162000>}
box{<0,0,-0.127000><0.762000,0.035000,0.127000> rotate<0,90.000000,0> translate<68.580000,-1.535000,26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.271000,-0.000000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<68.619000,-0.000000,1.778000>}
box{<0,0,-0.101600><1.348000,0.035000,0.101600> rotate<0,0.000000,0> translate<67.271000,-0.000000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.564000,-0.000000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<68.720000,-0.000000,6.604000>}
box{<0,0,-0.101600><1.156000,0.035000,0.101600> rotate<0,0.000000,0> translate<67.564000,-0.000000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<67.526000,-0.000000,7.404000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<68.720000,-0.000000,7.404000>}
box{<0,0,-0.101600><1.194000,0.035000,0.101600> rotate<0,0.000000,0> translate<67.526000,-0.000000,7.404000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.720000,-0.000000,5.804000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.745500,-0.000000,5.778500>}
box{<0,0,-0.152400><0.036062,0.035000,0.152400> rotate<0,44.997030,0> translate<68.720000,-0.000000,5.804000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.720000,-0.000000,7.404000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.745500,-0.000000,7.429500>}
box{<0,0,-0.152400><0.036062,0.035000,0.152400> rotate<0,-44.997030,0> translate<68.720000,-0.000000,7.404000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.691000,-0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.961000,-0.000000,23.749000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<67.691000,-0.000000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.453000,-1.535000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.961000,-1.535000,23.749000>}
box{<0,0,-0.127000><0.508000,0.035000,0.127000> rotate<0,0.000000,0> translate<68.453000,-1.535000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<66.421000,-0.000000,4.586000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<68.975000,-0.000000,4.586000>}
box{<0,0,-0.101600><2.554000,0.035000,0.101600> rotate<0,0.000000,0> translate<66.421000,-0.000000,4.586000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.720000,-0.000000,5.004000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.056500,-0.000000,4.667500>}
box{<0,0,-0.152400><0.475883,0.035000,0.152400> rotate<0,44.997030,0> translate<68.720000,-0.000000,5.004000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<68.975000,-0.000000,4.586000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<69.056500,-0.000000,4.667500>}
box{<0,0,-0.101600><0.115258,0.035000,0.101600> rotate<0,-44.997030,0> translate<68.975000,-0.000000,4.586000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<69.056500,-0.000000,4.667500>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<69.088000,-0.000000,4.699000>}
box{<0,0,-0.101600><0.044548,0.035000,0.101600> rotate<0,-44.997030,0> translate<69.056500,-0.000000,4.667500> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<68.086000,-0.000000,9.638000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<69.120000,-0.000000,8.604000>}
box{<0,0,-0.101600><1.462297,0.035000,0.101600> rotate<0,44.997030,0> translate<68.086000,-0.000000,9.638000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.720000,-0.000000,8.204000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.120000,-0.000000,8.604000>}
box{<0,0,-0.152400><0.565685,0.035000,0.152400> rotate<0,-44.997030,0> translate<68.720000,-0.000000,8.204000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.215000,-0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.215000,-0.000000,22.225000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<69.215000,-0.000000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.961000,-0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.215000,-0.000000,23.749000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<68.961000,-0.000000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.215000,-0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.215000,-0.000000,27.813000>}
box{<0,0,-0.127000><4.064000,0.035000,0.127000> rotate<0,90.000000,0> translate<69.215000,-0.000000,27.813000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.437000,-1.535000,17.692000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.303000,-1.535000,17.692000>}
box{<0,0,-0.127000><1.866000,0.035000,0.127000> rotate<0,0.000000,0> translate<67.437000,-1.535000,17.692000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,8.636000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,-90.000000,0> translate<69.342000,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.624200,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,8.890000>}
box{<0,0,-0.127000><2.717800,0.035000,0.127000> rotate<0,0.000000,0> translate<66.624200,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,13.970000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,90.000000,0> translate<69.342000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.541000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,14.605000>}
box{<0,0,-0.127000><0.801000,0.035000,0.127000> rotate<0,0.000000,0> translate<68.541000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,14.605000>}
box{<0,0,-0.127000><0.635000,0.035000,0.127000> rotate<0,90.000000,0> translate<69.342000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,15.494000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<69.342000,-1.535000,15.494000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.303000,-1.535000,17.692000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,17.653000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,44.997030,0> translate<69.303000,-1.535000,17.692000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,17.653000>}
box{<0,0,-0.127000><2.159000,0.035000,0.127000> rotate<0,90.000000,0> translate<69.342000,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,17.692000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,90.000000,0> translate<69.342000,-1.535000,17.692000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,19.392000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,21.336000>}
box{<0,0,-0.127000><1.944000,0.035000,0.127000> rotate<0,90.000000,0> translate<69.342000,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.720000,-0.000000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.520000,-0.000000,6.604000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,0.000000,0> translate<68.720000,-0.000000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,4.191500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,4.191000>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,-90.000000,0> translate<69.532500,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.056500,-0.000000,4.667500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,4.191500>}
box{<0,0,-0.152400><0.673166,0.035000,0.152400> rotate<0,44.997030,0> translate<69.056500,-0.000000,4.667500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.520000,-0.000000,4.204000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,4.191500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,44.997030,0> translate<69.520000,-0.000000,4.204000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.745500,-0.000000,5.778500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,5.778500>}
box{<0,0,-0.152400><0.787000,0.035000,0.152400> rotate<0,0.000000,0> translate<68.745500,-0.000000,5.778500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,5.791500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,5.778500>}
box{<0,0,-0.152400><0.013000,0.035000,0.152400> rotate<0,-90.000000,0> translate<69.532500,-0.000000,5.778500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.520000,-0.000000,5.804000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,5.791500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,44.997030,0> translate<69.520000,-0.000000,5.804000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.520000,-0.000000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,6.604000>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,0.000000,0> translate<69.520000,-0.000000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.520000,-0.000000,7.404000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,7.416500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,-44.997030,0> translate<69.520000,-0.000000,7.404000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,7.429500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,7.416500>}
box{<0,0,-0.152400><0.013000,0.035000,0.152400> rotate<0,-90.000000,0> translate<69.532500,-0.000000,7.416500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.745500,-0.000000,7.429500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,7.429500>}
box{<0,0,-0.152400><0.787000,0.035000,0.152400> rotate<0,0.000000,0> translate<68.745500,-0.000000,7.429500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.120000,-0.000000,8.604000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,9.016500>}
box{<0,0,-0.152400><0.583363,0.035000,0.152400> rotate<0,-44.997030,0> translate<69.120000,-0.000000,8.604000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.520000,-0.000000,9.004000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,9.016500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,-44.997030,0> translate<69.520000,-0.000000,9.004000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,9.016500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.532500,-0.000000,9.017000>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,90.000000,0> translate<69.532500,-0.000000,9.017000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.215000,-0.000000,22.225000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.596000,-0.000000,22.606000>}
box{<0,0,-0.127000><0.538815,0.035000,0.127000> rotate<0,-44.997030,0> translate<69.215000,-0.000000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.199000,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.596000,-1.535000,23.495000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,-44.997030,0> translate<68.199000,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.580000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.596000,-1.535000,24.384000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<68.580000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.596000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.596000,-1.535000,24.384000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<69.596000,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.215000,-0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.723000,-0.000000,23.749000>}
box{<0,0,-0.127000><0.508000,0.035000,0.127000> rotate<0,0.000000,0> translate<69.215000,-0.000000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<57.023000,-1.535000,30.226000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<69.723000,-1.535000,30.226000>}
box{<0,0,-0.101600><12.700000,0.035000,0.101600> rotate<0,0.000000,0> translate<57.023000,-1.535000,30.226000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.836000,-0.000000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.836000,-0.000000,11.670000>}
box{<0,0,-0.152400><0.367000,0.035000,0.152400> rotate<0,90.000000,0> translate<69.836000,-0.000000,11.670000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.836000,-0.000000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.850000,-0.000000,11.303000>}
box{<0,0,-0.152400><0.014000,0.035000,0.152400> rotate<0,0.000000,0> translate<69.836000,-0.000000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.864000,-1.535000,13.970000>}
box{<0,0,-0.127000><0.522000,0.035000,0.127000> rotate<0,0.000000,0> translate<69.342000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.889000,-1.535000,15.494000>}
box{<0,0,-0.127000><0.547000,0.035000,0.127000> rotate<0,0.000000,0> translate<69.342000,-1.535000,15.494000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.596000,-1.535000,22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.104000,-1.535000,23.114000>}
box{<0,0,-0.127000><0.718420,0.035000,0.127000> rotate<0,-44.997030,0> translate<69.596000,-1.535000,22.606000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.104000,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.104000,-1.535000,26.416000>}
box{<0,0,-0.127000><3.302000,0.035000,0.127000> rotate<0,90.000000,0> translate<70.104000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.104000,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.192000,-1.535000,26.416000>}
box{<0,0,-0.127000><0.088000,0.035000,0.127000> rotate<0,0.000000,0> translate<70.104000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.192000,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.231000,-1.535000,26.416000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,0.000000,0> translate<70.192000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<70.294500,-0.000000,1.841500>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<70.294500,-0.000000,4.191000>}
box{<0,0,-0.101600><2.349500,0.035000,0.101600> rotate<0,90.000000,0> translate<70.294500,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.294500,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.294500,-0.000000,4.978500>}
box{<0,0,-0.152400><0.787500,0.035000,0.152400> rotate<0,90.000000,0> translate<70.294500,-0.000000,4.978500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.294500,-0.000000,8.191500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.294500,-0.000000,8.978500>}
box{<0,0,-0.152400><0.787000,0.035000,0.152400> rotate<0,90.000000,0> translate<70.294500,-0.000000,8.978500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.294500,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.307000,-0.000000,4.191000>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,0.000000,0> translate<70.294500,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.294500,-0.000000,8.191500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.307500,-0.000000,8.191500>}
box{<0,0,-0.152400><0.013000,0.035000,0.152400> rotate<0,0.000000,0> translate<70.294500,-0.000000,8.191500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.307000,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.320000,-0.000000,4.204000>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,-44.997030,0> translate<70.307000,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.294500,-0.000000,4.978500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.320000,-0.000000,5.004000>}
box{<0,0,-0.152400><0.036062,0.035000,0.152400> rotate<0,-44.997030,0> translate<70.294500,-0.000000,4.978500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.307500,-0.000000,8.191500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.320000,-0.000000,8.204000>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,-44.997030,0> translate<70.307500,-0.000000,8.191500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.320000,-0.000000,7.404000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.320000,-0.000000,8.204000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,90.000000,0> translate<70.320000,-0.000000,8.204000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.294500,-0.000000,8.978500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.320000,-0.000000,9.004000>}
box{<0,0,-0.152400><0.036062,0.035000,0.152400> rotate<0,-44.997030,0> translate<70.294500,-0.000000,8.978500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.850000,-0.000000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.320000,-0.000000,10.833000>}
box{<0,0,-0.152400><0.664680,0.035000,0.152400> rotate<0,44.997030,0> translate<69.850000,-0.000000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.320000,-0.000000,9.004000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.320000,-0.000000,10.833000>}
box{<0,0,-0.152400><1.829000,0.035000,0.152400> rotate<0,90.000000,0> translate<70.320000,-0.000000,10.833000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<70.294500,-0.000000,1.841500>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<70.358000,-0.000000,1.778000>}
box{<0,0,-0.101600><0.089803,0.035000,0.101600> rotate<0,44.997030,0> translate<70.294500,-0.000000,1.841500> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<70.319000,-0.000000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<70.358000,-0.000000,1.778000>}
box{<0,0,-0.101600><0.039000,0.035000,0.101600> rotate<0,0.000000,0> translate<70.319000,-0.000000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.358000,-1.535000,7.620000>}
box{<0,0,-0.127000><1.436841,0.035000,0.127000> rotate<0,44.997030,0> translate<69.342000,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<69.836000,-0.000000,11.670000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.358000,-0.000000,12.319000>}
box{<0,0,-0.152400><0.832878,0.035000,0.152400> rotate<0,-51.186403,0> translate<69.836000,-0.000000,11.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.485000,-0.000000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.485000,-0.000000,20.955000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,-90.000000,0> translate<70.485000,-0.000000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.723000,-0.000000,23.749000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.485000,-0.000000,22.987000>}
box{<0,0,-0.127000><1.077631,0.035000,0.127000> rotate<0,44.997030,0> translate<69.723000,-0.000000,23.749000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.866000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.866000,-1.535000,21.717000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,90.000000,0> translate<70.866000,-1.535000,21.717000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.120000,-0.000000,4.204000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.120000,-0.000000,4.191000>}
box{<0,0,-0.152400><0.013000,0.035000,0.152400> rotate<0,-90.000000,0> translate<71.120000,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.120000,-0.000000,4.204000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.120000,-0.000000,5.004000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,90.000000,0> translate<71.120000,-0.000000,5.004000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.120000,-0.000000,8.204000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.120000,-0.000000,8.191500>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,-90.000000,0> translate<71.120000,-0.000000,8.191500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.120000,-0.000000,8.204000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.120000,-0.000000,9.004000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,90.000000,0> translate<71.120000,-0.000000,9.004000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.120000,-0.000000,9.004000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.120000,-0.000000,10.033000>}
box{<0,0,-0.101600><1.029000,0.035000,0.101600> rotate<0,90.000000,0> translate<71.120000,-0.000000,10.033000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.675000,-0.000000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-0.000000,29.464000>}
box{<0,0,-0.203200><4.445000,0.035000,0.203200> rotate<0,0.000000,0> translate<66.675000,-0.000000,29.464000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,17.692000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.159000,-1.535000,17.692000>}
box{<0,0,-0.127000><1.817000,0.035000,0.127000> rotate<0,0.000000,0> translate<69.342000,-1.535000,17.692000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.866000,-1.535000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.159000,-1.535000,19.392000>}
box{<0,0,-0.127000><0.414365,0.035000,0.127000> rotate<0,44.997030,0> translate<70.866000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.247000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.247000,-1.535000,17.692000>}
box{<0,0,-0.127000><0.088000,0.035000,0.127000> rotate<0,-90.000000,0> translate<71.247000,-1.535000,17.692000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.159000,-1.535000,17.692000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.247000,-1.535000,17.780000>}
box{<0,0,-0.127000><0.124451,0.035000,0.127000> rotate<0,-44.997030,0> translate<71.159000,-1.535000,17.692000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.159000,-1.535000,19.392000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.247000,-1.535000,19.392000>}
box{<0,0,-0.127000><0.088000,0.035000,0.127000> rotate<0,0.000000,0> translate<71.159000,-1.535000,19.392000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.866000,-1.535000,21.717000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.247000,-1.535000,22.098000>}
box{<0,0,-0.127000><0.538815,0.035000,0.127000> rotate<0,-44.997030,0> translate<70.866000,-1.535000,21.717000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.247000,-1.535000,23.368000>}
box{<0,0,-0.127000><2.785327,0.035000,0.127000> rotate<0,-46.844519,0> translate<69.342000,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.120000,-0.000000,10.033000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.374000,-0.000000,10.287000>}
box{<0,0,-0.101600><0.359210,0.035000,0.101600> rotate<0,-44.997030,0> translate<71.120000,-0.000000,10.033000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.374000,-0.000000,10.287000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.374000,-0.000000,11.176000>}
box{<0,0,-0.101600><0.889000,0.035000,0.101600> rotate<0,90.000000,0> translate<71.374000,-0.000000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.374000,-0.000000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.388000,-0.000000,11.190000>}
box{<0,0,-0.101600><0.019799,0.035000,0.101600> rotate<0,-44.997030,0> translate<71.374000,-0.000000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.388000,-0.000000,11.190000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.388000,-0.000000,11.303000>}
box{<0,0,-0.101600><0.113000,0.035000,0.101600> rotate<0,90.000000,0> translate<71.388000,-0.000000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.589000,-1.535000,14.009000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.589000,-1.535000,15.494000>}
box{<0,0,-0.127000><1.485000,0.035000,0.127000> rotate<0,90.000000,0> translate<71.589000,-1.535000,15.494000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.589000,-1.535000,14.009000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.628000,-1.535000,13.970000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,44.997030,0> translate<71.589000,-1.535000,14.009000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.614000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.628000,-1.535000,13.970000>}
box{<0,0,-0.127000><0.014000,0.035000,0.127000> rotate<0,0.000000,0> translate<71.614000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.755000,-0.000000,27.813000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.755000,-0.000000,26.543000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,-90.000000,0> translate<71.755000,-0.000000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.755000,-0.000000,28.829000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.755000,-0.000000,27.813000>}
box{<0,0,-0.203200><1.016000,0.035000,0.203200> rotate<0,-90.000000,0> translate<71.755000,-0.000000,27.813000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.120000,-0.000000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.755000,-0.000000,28.829000>}
box{<0,0,-0.203200><0.898026,0.035000,0.203200> rotate<0,44.997030,0> translate<71.120000,-0.000000,29.464000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.882000,-0.000000,8.191500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.882000,-0.000000,8.966000>}
box{<0,0,-0.152400><0.774500,0.035000,0.152400> rotate<0,90.000000,0> translate<71.882000,-0.000000,8.966000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.882000,-0.000000,8.191500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.907500,-0.000000,8.191500>}
box{<0,0,-0.152400><0.025500,0.035000,0.152400> rotate<0,0.000000,0> translate<71.882000,-0.000000,8.191500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<70.320000,-0.000000,7.404000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.920000,-0.000000,5.804000>}
box{<0,0,-0.152400><2.262742,0.035000,0.152400> rotate<0,44.997030,0> translate<70.320000,-0.000000,7.404000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.907500,-0.000000,8.191500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.920000,-0.000000,8.204000>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,-44.997030,0> translate<71.907500,-0.000000,8.191500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.882000,-0.000000,8.966000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.920000,-0.000000,9.004000>}
box{<0,0,-0.152400><0.053740,0.035000,0.152400> rotate<0,-44.997030,0> translate<71.882000,-0.000000,8.966000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.920000,-0.000000,9.004000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.920000,-0.000000,9.944000>}
box{<0,0,-0.101600><0.940000,0.035000,0.101600> rotate<0,90.000000,0> translate<71.920000,-0.000000,9.944000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.920000,-0.000000,4.204000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.933000,-0.000000,4.191000>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,44.997030,0> translate<71.920000,-0.000000,4.204000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.933000,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.945500,-0.000000,4.191000>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,0.000000,0> translate<71.933000,-0.000000,4.191000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.920000,-0.000000,5.004000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.945500,-0.000000,4.978500>}
box{<0,0,-0.152400><0.036062,0.035000,0.152400> rotate<0,44.997030,0> translate<71.920000,-0.000000,5.004000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.945500,-0.000000,4.191000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.945500,-0.000000,4.978500>}
box{<0,0,-0.152400><0.787500,0.035000,0.152400> rotate<0,90.000000,0> translate<71.945500,-0.000000,4.978500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.056000,-0.000000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.009000,-0.000000,18.415000>}
box{<0,0,-0.127000><4.953000,0.035000,0.127000> rotate<0,0.000000,0> translate<67.056000,-0.000000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,3.632200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,6.350000>}
box{<0,0,-0.127000><2.717800,0.035000,0.127000> rotate<0,90.000000,0> translate<72.059800,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<70.358000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,7.620000>}
box{<0,0,-0.127000><1.701800,0.035000,0.127000> rotate<0,0.000000,0> translate<70.358000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<69.342000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,8.890000>}
box{<0,0,-0.127000><2.717800,0.035000,0.127000> rotate<0,0.000000,0> translate<69.342000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,12.750800>}
box{<0,0,-0.127000><2.590800,0.035000,0.127000> rotate<0,90.000000,0> translate<72.059800,-1.535000,12.750800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.247000,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,22.098000>}
box{<0,0,-0.127000><0.812800,0.035000,0.127000> rotate<0,0.000000,0> translate<71.247000,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<71.247000,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,23.368000>}
box{<0,0,-0.127000><0.812800,0.035000,0.127000> rotate<0,0.000000,0> translate<71.247000,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,25.704800>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,24.638000>}
box{<0,0,-0.127000><1.066800,0.035000,0.127000> rotate<0,-90.000000,0> translate<72.059800,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.009000,-1.535000,27.813000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.072500,-1.535000,27.749500>}
box{<0,0,-0.127000><0.089803,0.035000,0.127000> rotate<0,44.997030,0> translate<72.009000,-1.535000,27.813000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.136000,-1.535000,22.098000>}
box{<0,0,-0.127000><0.076200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,25.704800>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.136000,-1.535000,25.781000>}
box{<0,0,-0.127000><0.107763,0.035000,0.127000> rotate<0,-44.997030,0> translate<72.059800,-1.535000,25.704800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.072500,-1.535000,27.749500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.136000,-1.535000,27.686000>}
box{<0,0,-0.127000><0.089803,0.035000,0.127000> rotate<0,44.997030,0> translate<72.072500,-1.535000,27.749500> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<69.723000,-1.535000,30.226000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<72.136000,-1.535000,27.813000>}
box{<0,0,-0.101600><3.412497,0.035000,0.101600> rotate<0,44.997030,0> translate<69.723000,-1.535000,30.226000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.072500,-1.535000,27.749500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.136000,-1.535000,27.813000>}
box{<0,0,-0.127000><0.089803,0.035000,0.127000> rotate<0,-44.997030,0> translate<72.072500,-1.535000,27.749500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.136000,-1.535000,25.781000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.175000,-1.535000,25.781000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,0.000000,0> translate<72.136000,-1.535000,25.781000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.175000,-1.535000,27.647000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.175000,-1.535000,25.781000>}
box{<0,0,-0.127000><1.866000,0.035000,0.127000> rotate<0,-90.000000,0> translate<72.175000,-1.535000,25.781000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.136000,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.175000,-1.535000,27.647000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,44.997030,0> translate<72.136000,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.136000,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.175000,-1.535000,27.725000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,-44.997030,0> translate<72.136000,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.150000,-1.535000,27.813000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.175000,-1.535000,27.725000>}
box{<0,0,-0.127000><0.091482,0.035000,0.127000> rotate<0,74.135741,0> translate<72.150000,-1.535000,27.813000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,3.632200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,3.302000>}
box{<0,0,-0.127000><0.466973,0.035000,0.127000> rotate<0,44.997030,0> translate<72.059800,-1.535000,3.632200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,12.750800>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,13.081000>}
box{<0,0,-0.127000><0.466973,0.035000,0.127000> rotate<0,-44.997030,0> translate<72.059800,-1.535000,12.750800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.644000,-1.535000,20.828000>}
box{<0,0,-0.127000><0.584200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.644000,-1.535000,18.669000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.644000,-1.535000,20.828000>}
box{<0,0,-0.127000><2.159000,0.035000,0.127000> rotate<0,90.000000,0> translate<72.644000,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.644000,-1.535000,24.003000>}
box{<0,0,-0.127000><0.584200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<71.920000,-0.000000,5.804000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<72.720000,-0.000000,5.804000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,0.000000,0> translate<71.920000,-0.000000,5.804000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<72.720000,-0.000000,5.804000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<72.745500,-0.000000,5.778500>}
box{<0,0,-0.152400><0.036062,0.035000,0.152400> rotate<0,44.997030,0> translate<72.720000,-0.000000,5.804000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<72.720000,-0.000000,7.404000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<72.745500,-0.000000,7.429500>}
box{<0,0,-0.152400><0.036062,0.035000,0.152400> rotate<0,-44.997030,0> translate<72.720000,-0.000000,7.404000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,6.985000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.771000,-1.535000,6.985000>}
box{<0,0,-0.127000><0.711200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,6.985000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,9.525000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.771000,-1.535000,9.525000>}
box{<0,0,-0.127000><0.711200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,9.525000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.009000,-0.000000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.771000,-0.000000,17.653000>}
box{<0,0,-0.127000><1.077631,0.035000,0.127000> rotate<0,44.997030,0> translate<72.009000,-0.000000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-1.535000,16.676000>}
box{<0,0,-0.127000><0.977000,0.035000,0.127000> rotate<0,-90.000000,0> translate<72.898000,-1.535000,16.676000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.771000,-0.000000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-0.000000,17.653000>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,0.000000,0> translate<72.771000,-0.000000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.644000,-1.535000,18.669000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-1.535000,18.669000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<72.644000,-1.535000,18.669000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-1.535000,18.669000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,90.000000,0> translate<72.898000,-1.535000,18.669000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-1.535000,23.368000>}
box{<0,0,-0.127000><0.838200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.912000,-1.535000,16.637000>}
box{<0,0,-0.127000><0.014000,0.035000,0.127000> rotate<0,0.000000,0> translate<72.898000,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-1.535000,16.676000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.912000,-1.535000,16.637000>}
box{<0,0,-0.127000><0.041437,0.035000,0.127000> rotate<0,70.248527,0> translate<72.898000,-1.535000,16.676000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-1.535000,18.669000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.937000,-1.535000,18.669000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,0.000000,0> translate<72.898000,-1.535000,18.669000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,3.302000>}
box{<0,0,-0.127000><0.635000,0.035000,0.127000> rotate<0,0.000000,0> translate<72.390000,-1.535000,3.302000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,3.316000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,3.302000>}
box{<0,0,-0.127000><0.014000,0.035000,0.127000> rotate<0,-90.000000,0> translate<73.025000,-1.535000,3.302000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.771000,-1.535000,6.985000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,6.731000>}
box{<0,0,-0.127000><0.359210,0.035000,0.127000> rotate<0,44.997030,0> translate<72.771000,-1.535000,6.985000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,5.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,6.731000>}
box{<0,0,-0.127000><1.665000,0.035000,0.127000> rotate<0,90.000000,0> translate<73.025000,-1.535000,6.731000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.771000,-1.535000,9.525000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,9.779000>}
box{<0,0,-0.127000><0.359210,0.035000,0.127000> rotate<0,-44.997030,0> translate<72.771000,-1.535000,9.525000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,11.317000>}
box{<0,0,-0.127000><1.538000,0.035000,0.127000> rotate<0,90.000000,0> translate<73.025000,-1.535000,11.317000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,13.081000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,13.067000>}
box{<0,0,-0.127000><0.014000,0.035000,0.127000> rotate<0,-90.000000,0> translate<73.025000,-1.535000,13.067000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.390000,-1.535000,13.081000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,13.081000>}
box{<0,0,-0.127000><0.635000,0.035000,0.127000> rotate<0,0.000000,0> translate<72.390000,-1.535000,13.081000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,21.463000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,21.463000>}
box{<0,0,-0.127000><0.965200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,21.463000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-0.000000,27.813000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-0.000000,29.083000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<73.025000,-0.000000,29.083000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<72.720000,-0.000000,4.204000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.120000,-0.000000,4.604000>}
box{<0,0,-0.152400><0.565685,0.035000,0.152400> rotate<0,-44.997030,0> translate<72.720000,-0.000000,4.204000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<72.720000,-0.000000,9.004000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.120000,-0.000000,8.604000>}
box{<0,0,-0.152400><0.565685,0.035000,0.152400> rotate<0,44.997030,0> translate<72.720000,-0.000000,9.004000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<72.059800,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.152000,-1.535000,8.890000>}
box{<0,0,-0.101600><1.092200,0.035000,0.101600> rotate<0,0.000000,0> translate<72.059800,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,22.733000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.152000,-1.535000,22.733000>}
box{<0,0,-0.127000><1.092200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,22.733000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<71.920000,-0.000000,9.944000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.279000,-0.000000,11.303000>}
box{<0,0,-0.101600><1.921916,0.035000,0.101600> rotate<0,-44.997030,0> translate<71.920000,-0.000000,9.944000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.138000,-0.000000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.279000,-0.000000,11.303000>}
box{<0,0,-0.101600><0.141000,0.035000,0.101600> rotate<0,0.000000,0> translate<73.138000,-0.000000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,21.463000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.279000,-1.535000,21.209000>}
box{<0,0,-0.127000><0.359210,0.035000,0.127000> rotate<0,44.997030,0> translate<73.025000,-1.535000,21.463000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.279000,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.279000,-1.535000,21.209000>}
box{<0,0,-0.127000><1.143000,0.035000,0.127000> rotate<0,90.000000,0> translate<73.279000,-1.535000,21.209000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<71.755000,-0.000000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.279000,-0.000000,25.019000>}
box{<0,0,-0.203200><2.155261,0.035000,0.203200> rotate<0,44.997030,0> translate<71.755000,-0.000000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.406000,-1.535000,7.620000>}
box{<0,0,-0.127000><1.346200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<72.720000,-0.000000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.520000,-0.000000,6.604000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,0.000000,0> translate<72.720000,-0.000000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.120000,-0.000000,4.604000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.532500,-0.000000,5.016500>}
box{<0,0,-0.152400><0.583363,0.035000,0.152400> rotate<0,-44.997030,0> translate<73.120000,-0.000000,4.604000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.520000,-0.000000,5.004000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.532500,-0.000000,5.016500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,-44.997030,0> translate<73.520000,-0.000000,5.004000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.120000,-0.000000,8.604000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.532500,-0.000000,8.191500>}
box{<0,0,-0.152400><0.583363,0.035000,0.152400> rotate<0,44.997030,0> translate<73.120000,-0.000000,8.604000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.520000,-0.000000,8.204000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.532500,-0.000000,8.191500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,44.997030,0> translate<73.520000,-0.000000,8.204000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.532500,-0.000000,5.016500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,5.016500>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,0.000000,0> translate<73.532500,-0.000000,5.016500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<72.745500,-0.000000,5.778500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,5.778500>}
box{<0,0,-0.152400><0.787500,0.035000,0.152400> rotate<0,0.000000,0> translate<72.745500,-0.000000,5.778500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.520000,-0.000000,5.804000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,5.791000>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,44.997030,0> translate<73.520000,-0.000000,5.804000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,5.778500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,5.791000>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,90.000000,0> translate<73.533000,-0.000000,5.791000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.520000,-0.000000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,6.604000>}
box{<0,0,-0.152400><0.013000,0.035000,0.152400> rotate<0,0.000000,0> translate<73.520000,-0.000000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.520000,-0.000000,7.404000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,7.417000>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,-44.997030,0> translate<73.520000,-0.000000,7.404000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<72.745500,-0.000000,7.429500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,7.429500>}
box{<0,0,-0.152400><0.787500,0.035000,0.152400> rotate<0,0.000000,0> translate<72.745500,-0.000000,7.429500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,7.417000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,7.429500>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,90.000000,0> translate<73.533000,-0.000000,7.429500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.532500,-0.000000,8.191500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<73.533000,-0.000000,8.191500>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,0.000000,0> translate<73.532500,-0.000000,8.191500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.152000,-1.535000,22.733000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.533000,-1.535000,23.114000>}
box{<0,0,-0.127000><0.538815,0.035000,0.127000> rotate<0,-44.997030,0> translate<73.152000,-1.535000,22.733000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.039000,-0.000000,30.226000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.787000,-0.000000,30.226000>}
box{<0,0,-0.101600><15.748000,0.035000,0.101600> rotate<0,0.000000,0> translate<58.039000,-0.000000,30.226000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.025000,-1.535000,11.317000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.801000,-1.535000,11.303000>}
box{<0,0,-0.101600><0.776126,0.035000,0.101600> rotate<0,1.033506,0> translate<73.025000,-1.535000,11.317000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.875000,-1.535000,25.693000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.875000,-1.535000,25.781000>}
box{<0,0,-0.127000><0.088000,0.035000,0.127000> rotate<0,90.000000,0> translate<73.875000,-1.535000,25.781000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.875000,-1.535000,25.781000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.875000,-1.535000,27.901000>}
box{<0,0,-0.127000><2.120000,0.035000,0.127000> rotate<0,90.000000,0> translate<73.875000,-1.535000,27.901000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,13.067000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.900000,-1.535000,13.067000>}
box{<0,0,-0.127000><0.875000,0.035000,0.127000> rotate<0,0.000000,0> translate<73.025000,-1.535000,13.067000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.875000,-1.535000,27.901000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.900000,-1.535000,27.813000>}
box{<0,0,-0.127000><0.091482,0.035000,0.127000> rotate<0,74.135741,0> translate<73.875000,-1.535000,27.901000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.644000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.914000,-1.535000,25.273000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<72.644000,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.875000,-1.535000,25.693000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.914000,-1.535000,25.654000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,44.997030,0> translate<73.875000,-1.535000,25.693000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.914000,-1.535000,25.273000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.914000,-1.535000,25.654000>}
box{<0,0,-0.127000><0.381000,0.035000,0.127000> rotate<0,90.000000,0> translate<73.914000,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.875000,-1.535000,27.901000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.914000,-1.535000,27.940000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,-44.997030,0> translate<73.875000,-1.535000,27.901000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,3.316000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.154000,-1.535000,3.316000>}
box{<0,0,-0.127000><1.129000,0.035000,0.127000> rotate<0,0.000000,0> translate<73.025000,-1.535000,3.316000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.120000,-0.000000,4.604000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<74.154000,-0.000000,3.570000>}
box{<0,0,-0.101600><1.462297,0.035000,0.101600> rotate<0,44.997030,0> translate<73.120000,-0.000000,4.604000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.120000,-0.000000,8.604000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<74.154000,-0.000000,9.638000>}
box{<0,0,-0.101600><1.462297,0.035000,0.101600> rotate<0,-44.997030,0> translate<73.120000,-0.000000,8.604000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.406000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.168000,-1.535000,6.858000>}
box{<0,0,-0.127000><1.077631,0.035000,0.127000> rotate<0,44.997030,0> translate<73.406000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.900000,-1.535000,13.067000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.168000,-1.535000,13.335000>}
box{<0,0,-0.127000><0.379009,0.035000,0.127000> rotate<0,-44.997030,0> translate<73.900000,-1.535000,13.067000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.168000,-1.535000,22.098000>}
box{<0,0,-0.127000><2.108200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.168000,-1.535000,6.858000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.182000,-1.535000,6.858000>}
box{<0,0,-0.127000><0.014000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.168000,-1.535000,6.858000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.152000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<74.182000,-1.535000,9.779000>}
box{<0,0,-0.101600><1.360596,0.035000,0.101600> rotate<0,-40.795008,0> translate<73.152000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-1.535000,5.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.281000,-1.535000,5.066000>}
box{<0,0,-0.127000><1.256000,0.035000,0.127000> rotate<0,0.000000,0> translate<73.025000,-1.535000,5.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.154000,-1.535000,3.316000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.295000,-1.535000,3.175000>}
box{<0,0,-0.127000><0.199404,0.035000,0.127000> rotate<0,44.997030,0> translate<74.154000,-1.535000,3.316000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.691000,-0.000000,18.923000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.295000,-0.000000,18.923000>}
box{<0,0,-0.127000><6.604000,0.035000,0.127000> rotate<0,0.000000,0> translate<67.691000,-0.000000,18.923000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.898000,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.295000,-1.535000,24.765000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,-44.997030,0> translate<72.898000,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.295000,-1.535000,3.175000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.334000,-1.535000,3.175000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.295000,-1.535000,3.175000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.281000,-1.535000,5.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.334000,-1.535000,5.119000>}
box{<0,0,-0.127000><0.074953,0.035000,0.127000> rotate<0,-44.997030,0> translate<74.281000,-1.535000,5.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.334000,-1.535000,5.119000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.334000,-1.535000,5.207000>}
box{<0,0,-0.127000><0.088000,0.035000,0.127000> rotate<0,90.000000,0> translate<74.334000,-1.535000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.801000,-1.535000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<74.334000,-1.535000,11.303000>}
box{<0,0,-0.101600><0.533000,0.035000,0.101600> rotate<0,0.000000,0> translate<73.801000,-1.535000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<74.168000,-1.535000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<74.334000,-1.535000,13.335000>}
box{<0,0,-0.101600><0.166000,0.035000,0.101600> rotate<0,0.000000,0> translate<74.168000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.422000,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.422000,-1.535000,22.313000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,-90.000000,0> translate<74.422000,-1.535000,22.313000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.168000,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.422000,-1.535000,22.352000>}
box{<0,0,-0.127000><0.359210,0.035000,0.127000> rotate<0,-44.997030,0> translate<74.168000,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.279000,-0.000000,25.019000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<74.549000,-0.000000,25.019000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<73.279000,-0.000000,25.019000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<72.059800,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.676000,-1.535000,8.255000>}
box{<0,0,-0.127000><2.616200,0.035000,0.127000> rotate<0,0.000000,0> translate<72.059800,-1.535000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.662000,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.676000,-1.535000,16.637000>}
box{<0,0,-0.127000><0.014000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.662000,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.279000,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.676000,-1.535000,18.669000>}
box{<0,0,-0.127000><1.975656,0.035000,0.127000> rotate<0,44.997030,0> translate<73.279000,-1.535000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.637000,-1.535000,18.669000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.676000,-1.535000,18.669000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.637000,-1.535000,18.669000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.676000,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.676000,-1.535000,18.669000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,90.000000,0> translate<74.676000,-1.535000,18.669000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.295000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.803000,-1.535000,24.765000>}
box{<0,0,-0.127000><0.508000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.295000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.803000,-1.535000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.057000,-1.535000,25.019000>}
box{<0,0,-0.127000><0.359210,0.035000,0.127000> rotate<0,-44.997030,0> translate<74.803000,-1.535000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.057000,-1.535000,25.019000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.096000,-1.535000,25.019000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,0.000000,0> translate<75.057000,-1.535000,25.019000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.875000,-1.535000,25.781000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.096000,-1.535000,27.051000>}
box{<0,0,-0.127000><1.761744,0.035000,0.127000> rotate<0,-46.123865,0> translate<73.875000,-1.535000,25.781000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<68.072000,-0.000000,19.431000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.184000,-0.000000,19.431000>}
box{<0,0,-0.127000><7.112000,0.035000,0.127000> rotate<0,0.000000,0> translate<68.072000,-0.000000,19.431000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.676000,-1.535000,18.669000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.311000,-1.535000,19.304000>}
box{<0,0,-0.127000><0.898026,0.035000,0.127000> rotate<0,-44.997030,0> translate<74.676000,-1.535000,18.669000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.422000,-1.535000,20.613000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.350000,-1.535000,20.613000>}
box{<0,0,-0.127000><0.928000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.422000,-1.535000,20.613000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.533000,-0.000000,5.778500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.374500,-0.000000,5.778500>}
box{<0,0,-0.127000><1.841500,0.035000,0.127000> rotate<0,0.000000,0> translate<73.533000,-0.000000,5.778500> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.533000,-0.000000,7.429500>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.374500,-0.000000,7.429500>}
box{<0,0,-0.101600><1.841500,0.035000,0.101600> rotate<0,0.000000,0> translate<73.533000,-0.000000,7.429500> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.295000,-0.000000,18.923000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.438000,-0.000000,17.653000>}
box{<0,0,-0.127000><1.708610,0.035000,0.127000> rotate<0,48.009619,0> translate<74.295000,-0.000000,18.923000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.025000,-0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.692000,-0.000000,20.955000>}
box{<0,0,-0.127000><2.667000,0.035000,0.127000> rotate<0,0.000000,0> translate<73.025000,-0.000000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.350000,-1.535000,20.613000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.692000,-1.535000,20.955000>}
box{<0,0,-0.127000><0.483661,0.035000,0.127000> rotate<0,-44.997030,0> translate<75.350000,-1.535000,20.613000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.676000,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.706000,-1.535000,8.255000>}
box{<0,0,-0.127000><1.030000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.676000,-1.535000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<74.154000,-0.000000,3.570000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.819000,-0.000000,3.570000>}
box{<0,0,-0.101600><1.665000,0.035000,0.101600> rotate<0,0.000000,0> translate<74.154000,-0.000000,3.570000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.819000,-0.000000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.819000,-0.000000,5.320000>}
box{<0,0,-0.127000><0.014000,0.035000,0.127000> rotate<0,-90.000000,0> translate<75.819000,-0.000000,5.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.374500,-0.000000,5.778500>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.819000,-0.000000,5.334000>}
box{<0,0,-0.127000><0.628618,0.035000,0.127000> rotate<0,44.997030,0> translate<75.374500,-0.000000,5.778500> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.374500,-0.000000,7.429500>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.819000,-0.000000,7.874000>}
box{<0,0,-0.101600><0.628618,0.035000,0.101600> rotate<0,-44.997030,0> translate<75.374500,-0.000000,7.429500> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.819000,-0.000000,7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.819000,-0.000000,7.888000>}
box{<0,0,-0.101600><0.014000,0.035000,0.101600> rotate<0,90.000000,0> translate<75.819000,-0.000000,7.888000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.706000,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.819000,-1.535000,8.255000>}
box{<0,0,-0.127000><0.113000,0.035000,0.127000> rotate<0,0.000000,0> translate<75.706000,-1.535000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<74.154000,-0.000000,9.638000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.819000,-0.000000,9.638000>}
box{<0,0,-0.101600><1.665000,0.035000,0.101600> rotate<0,0.000000,0> translate<74.154000,-0.000000,9.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.549000,-0.000000,22.479000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.819000,-0.000000,22.479000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.549000,-0.000000,22.479000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.819000,-0.000000,21.844000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.819000,-0.000000,22.479000>}
box{<0,0,-0.127000><0.635000,0.035000,0.127000> rotate<0,90.000000,0> translate<75.819000,-0.000000,22.479000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.819000,-0.000000,3.570000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.833000,-0.000000,3.556000>}
box{<0,0,-0.101600><0.019799,0.035000,0.101600> rotate<0,44.997030,0> translate<75.819000,-0.000000,3.570000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.946000,-1.535000,3.175000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.946000,-1.535000,5.207000>}
box{<0,0,-0.101600><2.032000,0.035000,0.101600> rotate<0,90.000000,0> translate<75.946000,-1.535000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.932000,-1.535000,6.858000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.946000,-1.535000,6.985000>}
box{<0,0,-0.101600><0.127769,0.035000,0.101600> rotate<0,-83.703805,0> translate<75.932000,-1.535000,6.858000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.946000,-1.535000,5.207000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.946000,-1.535000,6.985000>}
box{<0,0,-0.101600><1.778000,0.035000,0.101600> rotate<0,90.000000,0> translate<75.946000,-1.535000,6.985000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.946000,-1.535000,3.175000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.034000,-1.535000,3.175000>}
box{<0,0,-0.101600><0.088000,0.035000,0.101600> rotate<0,0.000000,0> translate<75.946000,-1.535000,3.175000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.946000,-1.535000,5.207000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.034000,-1.535000,5.207000>}
box{<0,0,-0.101600><0.088000,0.035000,0.101600> rotate<0,0.000000,0> translate<75.946000,-1.535000,5.207000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.932000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.073000,-1.535000,9.779000>}
box{<0,0,-0.127000><0.141000,0.035000,0.127000> rotate<0,0.000000,0> translate<75.932000,-1.535000,9.779000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.034000,-1.535000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.073000,-1.535000,11.303000>}
box{<0,0,-0.101600><0.039000,0.035000,0.101600> rotate<0,0.000000,0> translate<76.034000,-1.535000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.073000,-1.535000,9.779000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.073000,-1.535000,11.303000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,90.000000,0> translate<76.073000,-1.535000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.073000,-1.535000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.073000,-1.535000,11.430000>}
box{<0,0,-0.101600><0.127000,0.035000,0.101600> rotate<0,90.000000,0> translate<76.073000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.034000,-1.535000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.073000,-1.535000,13.335000>}
box{<0,0,-0.101600><0.039000,0.035000,0.101600> rotate<0,0.000000,0> translate<76.034000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.073000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.073000,-1.535000,13.335000>}
box{<0,0,-0.101600><1.905000,0.035000,0.101600> rotate<0,90.000000,0> translate<76.073000,-1.535000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<73.533000,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.073000,-1.535000,23.114000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<73.533000,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.819000,-1.535000,21.844000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.112000,-1.535000,22.440000>}
box{<0,0,-0.127000><0.664127,0.035000,0.127000> rotate<0,-63.816561,0> translate<75.819000,-1.535000,21.844000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.087000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.112000,-1.535000,22.440000>}
box{<0,0,-0.127000><0.547571,0.035000,0.127000> rotate<0,87.377417,0> translate<76.087000,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.073000,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.112000,-1.535000,23.075000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,44.997030,0> translate<76.073000,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.087000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.112000,-1.535000,23.075000>}
box{<0,0,-0.127000><0.091482,0.035000,0.127000> rotate<0,-74.135741,0> translate<76.087000,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.438000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,17.907000>}
box{<0,0,-0.127000><0.803219,0.035000,0.127000> rotate<0,-18.433732,0> translate<75.438000,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.200000,-1.535000,17.907000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.239000,-1.535000,17.946000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,-44.997030,0> translate<76.200000,-1.535000,17.907000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.239000,-1.535000,17.946000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.327000,-1.535000,17.565000>}
box{<0,0,-0.127000><0.391031,0.035000,0.127000> rotate<0,76.989319,0> translate<76.239000,-1.535000,17.946000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.327000,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.327000,-1.535000,19.265000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,-90.000000,0> translate<76.327000,-1.535000,19.265000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.311000,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.327000,-1.535000,19.304000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<75.311000,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.533000,-0.000000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.454000,-0.000000,6.604000>}
box{<0,0,-0.101600><2.921000,0.035000,0.101600> rotate<0,0.000000,0> translate<73.533000,-0.000000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.184000,-0.000000,19.431000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.708000,-0.000000,20.955000>}
box{<0,0,-0.127000><2.155261,0.035000,0.127000> rotate<0,-44.997030,0> translate<75.184000,-0.000000,19.431000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.581000,-0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.708000,-0.000000,24.003000>}
box{<0,0,-0.127000><0.179605,0.035000,0.127000> rotate<0,44.997030,0> translate<76.581000,-0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.708000,-0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.708000,-0.000000,24.003000>}
box{<0,0,-0.127000><3.048000,0.035000,0.127000> rotate<0,90.000000,0> translate<76.708000,-0.000000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.796000,-1.535000,25.019000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.835000,-1.535000,25.019000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,0.000000,0> translate<76.796000,-1.535000,25.019000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<74.549000,-0.000000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.835000,-0.000000,26.289000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,0.000000,0> translate<74.549000,-0.000000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.796000,-1.535000,27.051000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.835000,-1.535000,27.051000>}
box{<0,0,-0.127000><0.039000,0.035000,0.127000> rotate<0,0.000000,0> translate<76.796000,-1.535000,27.051000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.835000,-1.535000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.835000,-1.535000,27.051000>}
box{<0,0,-0.127000><0.762000,0.035000,0.127000> rotate<0,90.000000,0> translate<76.835000,-1.535000,27.051000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<75.833000,-0.000000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.962000,-0.000000,3.556000>}
box{<0,0,-0.101600><1.129000,0.035000,0.101600> rotate<0,0.000000,0> translate<75.833000,-0.000000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.835000,-1.535000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.962000,-1.535000,3.556000>}
box{<0,0,-0.101600><0.127000,0.035000,0.101600> rotate<0,0.000000,0> translate<76.835000,-1.535000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.454000,-0.000000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.962000,-0.000000,6.096000>}
box{<0,0,-0.101600><0.718420,0.035000,0.101600> rotate<0,44.997030,0> translate<76.454000,-0.000000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.581000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.089000,-1.535000,24.765000>}
box{<0,0,-0.127000><0.813197,0.035000,0.127000> rotate<0,-51.336803,0> translate<76.581000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.835000,-1.535000,25.019000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.089000,-1.535000,24.765000>}
box{<0,0,-0.127000><0.359210,0.035000,0.127000> rotate<0,44.997030,0> translate<76.835000,-1.535000,25.019000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<75.946000,-1.535000,6.985000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.343000,-1.535000,6.985000>}
box{<0,0,-0.127000><1.397000,0.035000,0.127000> rotate<0,0.000000,0> translate<75.946000,-1.535000,6.985000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<76.073000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.343000,-1.535000,11.430000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<76.073000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<77.470000,-0.000000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<77.470000,-0.000000,23.368000>}
box{<0,0,-0.101600><3.175000,0.035000,0.101600> rotate<0,-90.000000,0> translate<77.470000,-0.000000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<73.787000,-0.000000,30.226000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<77.470000,-0.000000,26.543000>}
box{<0,0,-0.101600><5.208549,0.035000,0.101600> rotate<0,44.997030,0> translate<73.787000,-0.000000,30.226000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.835000,-1.535000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<77.724000,-1.535000,4.205000>}
box{<0,0,-0.101600><1.100692,0.035000,0.101600> rotate<0,-36.128321,0> translate<76.835000,-1.535000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<76.962000,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<77.724000,-1.535000,5.842000>}
box{<0,0,-0.101600><0.803219,0.035000,0.101600> rotate<0,18.433732,0> translate<76.962000,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<77.724000,-1.535000,5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<77.724000,-1.535000,5.955000>}
box{<0,0,-0.101600><0.113000,0.035000,0.101600> rotate<0,90.000000,0> translate<77.724000,-1.535000,5.955000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<77.724000,-1.535000,4.205000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<77.865000,-1.535000,4.205000>}
box{<0,0,-0.203200><0.141000,0.035000,0.203200> rotate<0,0.000000,0> translate<77.724000,-1.535000,4.205000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<77.456000,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<77.978000,-1.535000,8.255000>}
box{<0,0,-0.203200><0.522000,0.035000,0.203200> rotate<0,0.000000,0> translate<77.456000,-1.535000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.343000,-0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,-0.000000,10.160000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<77.343000,-0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.343000,-0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.359000,-0.000000,11.430000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<77.343000,-0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<77.470000,-0.000000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<78.359000,-0.000000,22.479000>}
box{<0,0,-0.101600><1.257236,0.035000,0.101600> rotate<0,44.997030,0> translate<77.470000,-0.000000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<77.343000,-0.000000,6.985000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<78.486000,-0.000000,6.985000>}
box{<0,0,-0.127000><1.143000,0.035000,0.127000> rotate<0,0.000000,0> translate<77.343000,-0.000000,6.985000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<77.865000,-1.535000,4.205000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.867000,-1.535000,5.207000>}
box{<0,0,-0.203200><1.417042,0.035000,0.203200> rotate<0,-44.997030,0> translate<77.865000,-1.535000,4.205000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<77.978000,-1.535000,8.255000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.867000,-1.535000,7.366000>}
box{<0,0,-0.203200><1.257236,0.035000,0.203200> rotate<0,44.997030,0> translate<77.978000,-1.535000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.867000,-1.535000,5.207000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.867000,-1.535000,7.366000>}
box{<0,0,-0.203200><2.159000,0.035000,0.203200> rotate<0,90.000000,0> translate<78.867000,-1.535000,7.366000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<31.369000,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<31.369000,-1.535000,17.780000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,90.000000,0> translate<31.369000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<31.369000,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<33.020000,-1.535000,16.764000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<31.369000,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<31.369000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<33.020000,-1.535000,17.780000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<31.369000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<31.369000,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<31.369000,-1.535000,20.828000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,90.000000,0> translate<31.369000,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<31.369000,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<33.020000,-1.535000,19.812000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<31.369000,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<31.369000,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<33.020000,-1.535000,20.828000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<31.369000,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<33.020000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<33.020000,-1.535000,16.764000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,-90.000000,0> translate<33.020000,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<33.020000,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<33.020000,-1.535000,19.812000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,-90.000000,0> translate<33.020000,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.957000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.957000,-1.535000,21.336000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,90.000000,0> translate<36.957000,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.957000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.608000,-1.535000,20.320000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<36.957000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<36.957000,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.608000,-1.535000,21.336000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<36.957000,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.608000,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<38.608000,-1.535000,20.320000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,-90.000000,0> translate<38.608000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.624000,-1.535000,19.431000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.148000,-1.535000,17.907000>}
box{<0,0,-0.101600><2.155261,0.035000,0.101600> rotate<0,44.997030,0> translate<39.624000,-1.535000,19.431000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.624000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.624000,-1.535000,19.431000>}
box{<0,0,-0.101600><2.159000,0.035000,0.101600> rotate<0,-90.000000,0> translate<39.624000,-1.535000,19.431000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<39.624000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.307000,-1.535000,21.590000>}
box{<0,0,-0.101600><3.683000,0.035000,0.101600> rotate<0,0.000000,0> translate<39.624000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<41.148000,-1.535000,17.907000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.561000,-1.535000,17.907000>}
box{<0,0,-0.101600><2.413000,0.035000,0.101600> rotate<0,0.000000,0> translate<41.148000,-1.535000,17.907000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.307000,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.307000,-1.535000,21.590000>}
box{<0,0,-0.101600><2.413000,0.035000,0.101600> rotate<0,90.000000,0> translate<43.307000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.307000,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.561000,-1.535000,18.923000>}
box{<0,0,-0.101600><0.359210,0.035000,0.101600> rotate<0,44.997030,0> translate<43.307000,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.561000,-1.535000,17.907000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<43.561000,-1.535000,18.923000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,90.000000,0> translate<43.561000,-1.535000,18.923000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.323000,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.323000,-1.535000,23.622000>}
box{<0,0,-0.101600><5.588000,0.035000,0.101600> rotate<0,90.000000,0> translate<44.323000,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.323000,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.450000,-1.535000,17.907000>}
box{<0,0,-0.101600><0.179605,0.035000,0.101600> rotate<0,44.997030,0> translate<44.323000,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.323000,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.323000,-1.535000,24.003000>}
box{<0,0,-0.101600><0.381000,0.035000,0.101600> rotate<0,90.000000,0> translate<44.323000,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.323000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.450000,-1.535000,24.130000>}
box{<0,0,-0.101600><0.179605,0.035000,0.101600> rotate<0,-44.997030,0> translate<44.323000,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.450000,-1.535000,17.907000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.339000,-1.535000,17.907000>}
box{<0,0,-0.101600><0.889000,0.035000,0.101600> rotate<0,0.000000,0> translate<44.450000,-1.535000,17.907000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<44.450000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.228000,-1.535000,24.130000>}
box{<0,0,-0.101600><1.778000,0.035000,0.101600> rotate<0,0.000000,0> translate<44.450000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<45.339000,-1.535000,17.907000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.355000,-1.535000,18.923000>}
box{<0,0,-0.101600><1.436841,0.035000,0.101600> rotate<0,-44.997030,0> translate<45.339000,-1.535000,17.907000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.228000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.355000,-1.535000,24.003000>}
box{<0,0,-0.101600><0.179605,0.035000,0.101600> rotate<0,44.997030,0> translate<46.228000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.355000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<46.355000,-1.535000,18.923000>}
box{<0,0,-0.101600><5.080000,0.035000,0.101600> rotate<0,-90.000000,0> translate<46.355000,-1.535000,18.923000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.244000,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.244000,-1.535000,18.161000>}
box{<0,0,-0.101600><1.143000,0.035000,0.101600> rotate<0,90.000000,0> translate<47.244000,-1.535000,18.161000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.244000,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.895000,-1.535000,17.018000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<47.244000,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<47.244000,-1.535000,18.161000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.768000,-1.535000,18.161000>}
box{<0,0,-0.101600><1.524000,0.035000,0.101600> rotate<0,0.000000,0> translate<47.244000,-1.535000,18.161000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.768000,-1.535000,18.161000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-1.535000,18.542000>}
box{<0,0,-0.101600><0.538815,0.035000,0.101600> rotate<0,-44.997030,0> translate<48.768000,-1.535000,18.161000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.895000,-1.535000,15.748000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.895000,-1.535000,17.018000>}
box{<0,0,-0.101600><1.270000,0.035000,0.101600> rotate<0,90.000000,0> translate<48.895000,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<48.895000,-1.535000,15.748000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.784000,-1.535000,15.748000>}
box{<0,0,-0.101600><0.889000,0.035000,0.101600> rotate<0,0.000000,0> translate<48.895000,-1.535000,15.748000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-1.535000,18.796000>}
box{<0,0,-0.101600><0.254000,0.035000,0.101600> rotate<0,90.000000,0> translate<49.149000,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.149000,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.276000,-1.535000,18.923000>}
box{<0,0,-0.101600><0.179605,0.035000,0.101600> rotate<0,-44.997030,0> translate<49.149000,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.276000,-1.535000,18.923000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.927000,-1.535000,18.923000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<49.276000,-1.535000,18.923000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.784000,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.784000,-1.535000,15.748000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,-90.000000,0> translate<49.784000,-1.535000,15.748000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<49.784000,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.165000,-1.535000,17.145000>}
box{<0,0,-0.101600><0.538815,0.035000,0.101600> rotate<0,-44.997030,0> translate<49.784000,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.165000,-1.535000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.927000,-1.535000,17.145000>}
box{<0,0,-0.101600><0.762000,0.035000,0.101600> rotate<0,0.000000,0> translate<50.165000,-1.535000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.927000,-1.535000,18.923000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<50.927000,-1.535000,17.145000>}
box{<0,0,-0.101600><1.778000,0.035000,0.101600> rotate<0,-90.000000,0> translate<50.927000,-1.535000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.562000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.562000,-1.535000,24.003000>}
box{<0,0,-0.101600><6.223000,0.035000,0.101600> rotate<0,90.000000,0> translate<51.562000,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.562000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.070000,-1.535000,17.272000>}
box{<0,0,-0.101600><0.718420,0.035000,0.101600> rotate<0,44.997030,0> translate<51.562000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<51.562000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-1.535000,24.003000>}
box{<0,0,-0.101600><1.778000,0.035000,0.101600> rotate<0,0.000000,0> translate<51.562000,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<52.070000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.086000,-1.535000,17.272000>}
box{<0,0,-0.101600><1.016000,0.035000,0.101600> rotate<0,0.000000,0> translate<52.070000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.086000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-1.535000,17.526000>}
box{<0,0,-0.101600><0.359210,0.035000,0.101600> rotate<0,-44.997030,0> translate<53.086000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.340000,-1.535000,17.526000>}
box{<0,0,-0.101600><6.477000,0.035000,0.101600> rotate<0,-90.000000,0> translate<53.340000,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.975000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<55.499000,-1.535000,17.272000>}
box{<0,0,-0.101600><1.524000,0.035000,0.101600> rotate<0,0.000000,0> translate<53.975000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.975000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.975000,-1.535000,17.272000>}
box{<0,0,-0.101600><6.858000,0.035000,0.101600> rotate<0,-90.000000,0> translate<53.975000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<53.975000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.515000,-1.535000,24.130000>}
box{<0,0,-0.101600><2.540000,0.035000,0.101600> rotate<0,0.000000,0> translate<53.975000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<55.499000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.214000,-1.535000,17.272000>}
box{<0,0,-0.101600><5.715000,0.035000,0.101600> rotate<0,0.000000,0> translate<55.499000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.515000,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.515000,-1.535000,24.130000>}
box{<0,0,-0.101600><4.064000,0.035000,0.101600> rotate<0,90.000000,0> translate<56.515000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<56.515000,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.039000,-1.535000,20.066000>}
box{<0,0,-0.101600><1.524000,0.035000,0.101600> rotate<0,0.000000,0> translate<56.515000,-1.535000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.039000,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.039000,-1.535000,20.066000>}
box{<0,0,-0.101600><1.524000,0.035000,0.101600> rotate<0,90.000000,0> translate<58.039000,-1.535000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<58.039000,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.690000,-1.535000,18.542000>}
box{<0,0,-0.101600><1.651000,0.035000,0.101600> rotate<0,0.000000,0> translate<58.039000,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<59.690000,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<60.198000,-1.535000,19.050000>}
box{<0,0,-0.101600><0.718420,0.035000,0.101600> rotate<0,-44.997030,0> translate<59.690000,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<60.198000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<60.198000,-1.535000,19.050000>}
box{<0,0,-0.101600><1.270000,0.035000,0.101600> rotate<0,-90.000000,0> translate<60.198000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<60.198000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.722000,-1.535000,20.320000>}
box{<0,0,-0.101600><1.524000,0.035000,0.101600> rotate<0,0.000000,0> translate<60.198000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.214000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.722000,-1.535000,17.780000>}
box{<0,0,-0.101600><0.718420,0.035000,0.101600> rotate<0,-44.997030,0> translate<61.214000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.722000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<61.722000,-1.535000,20.320000>}
box{<0,0,-0.101600><2.540000,0.035000,0.101600> rotate<0,90.000000,0> translate<61.722000,-1.535000,20.320000> }
texture{col_pol}
}
#end
union{
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.441000,0.038000,4.781000><34.441000,-1.538000,4.781000>0.304800 }
cylinder{<34.441000,0.038000,21.381000><34.441000,-1.538000,21.381000>0.304800 }
cylinder{<34.778000,0.038000,25.136000><34.778000,-1.538000,25.136000>0.250000}
cylinder{<34.778000,0.038000,23.886000><34.778000,-1.538000,23.886000>0.250000}
//Holes(fast)/Vias
cylinder{<75.819000,0.038000,21.844000><75.819000,-1.538000,21.844000>0.175000 }
cylinder{<74.676000,0.038000,8.255000><74.676000,-1.538000,8.255000>0.175000 }
cylinder{<77.343000,0.038000,10.160000><77.343000,-1.538000,10.160000>0.175000 }
cylinder{<53.086000,0.038000,18.796000><53.086000,-1.538000,18.796000>0.175000 }
cylinder{<53.086000,0.038000,17.907000><53.086000,-1.538000,17.907000>0.175000 }
cylinder{<51.943000,0.038000,18.796000><51.943000,-1.538000,18.796000>0.175000 }
cylinder{<51.943000,0.038000,17.907000><51.943000,-1.538000,17.907000>0.175000 }
cylinder{<41.783000,0.038000,1.905000><41.783000,-1.538000,1.905000>0.175000 }
cylinder{<42.291000,0.038000,27.559000><42.291000,-1.538000,27.559000>0.175000 }
cylinder{<59.309000,0.038000,15.621000><59.309000,-1.538000,15.621000>0.175000 }
cylinder{<62.103000,0.038000,21.590000><62.103000,-1.538000,21.590000>0.175000 }
cylinder{<44.196000,0.038000,8.001000><44.196000,-1.538000,8.001000>0.175000 }
cylinder{<43.307000,0.038000,27.559000><43.307000,-1.538000,27.559000>0.175000 }
cylinder{<48.133000,0.038000,26.543000><48.133000,-1.538000,26.543000>0.175000 }
cylinder{<54.356000,0.038000,23.876000><54.356000,-1.538000,23.876000>0.175000 }
cylinder{<46.863000,0.038000,27.432000><46.863000,-1.538000,27.432000>0.175000 }
cylinder{<54.737000,0.038000,24.638000><54.737000,-1.538000,24.638000>0.175000 }
cylinder{<41.656000,0.038000,28.194000><41.656000,-1.538000,28.194000>0.175000 }
cylinder{<76.962000,0.038000,3.556000><76.962000,-1.538000,3.556000>0.175000 }
cylinder{<68.961000,0.038000,23.749000><68.961000,-1.538000,23.749000>0.175000 }
cylinder{<73.025000,0.038000,29.083000><73.025000,-1.538000,29.083000>0.175000 }
cylinder{<62.103000,0.038000,23.114000><62.103000,-1.538000,23.114000>0.175000 }
cylinder{<58.420000,0.038000,29.591000><58.420000,-1.538000,29.591000>0.175000 }
cylinder{<66.421000,0.038000,3.429000><66.421000,-1.538000,3.429000>0.175000 }
cylinder{<42.545000,0.038000,2.540000><42.545000,-1.538000,2.540000>0.175000 }
cylinder{<33.147000,0.038000,23.876000><33.147000,-1.538000,23.876000>0.175000 }
cylinder{<32.512000,0.038000,23.114000><32.512000,-1.538000,23.114000>0.175000 }
cylinder{<31.369000,0.038000,23.114000><31.369000,-1.538000,23.114000>0.175000 }
cylinder{<36.322000,0.038000,23.876000><36.322000,-1.538000,23.876000>0.175000 }
cylinder{<35.814000,0.038000,23.114000><35.814000,-1.538000,23.114000>0.175000 }
cylinder{<36.703000,0.038000,23.114000><36.703000,-1.538000,23.114000>0.175000 }
cylinder{<38.227000,0.038000,20.828000><38.227000,-1.538000,20.828000>0.175000 }
cylinder{<37.465000,0.038000,20.828000><37.465000,-1.538000,20.828000>0.175000 }
cylinder{<41.402000,0.038000,18.796000><41.402000,-1.538000,18.796000>0.175000 }
cylinder{<42.037000,0.038000,18.796000><42.037000,-1.538000,18.796000>0.175000 }
cylinder{<42.037000,0.038000,18.161000><42.037000,-1.538000,18.161000>0.175000 }
cylinder{<41.402000,0.038000,18.161000><41.402000,-1.538000,18.161000>0.175000 }
cylinder{<40.767000,0.038000,18.796000><40.767000,-1.538000,18.796000>0.175000 }
cylinder{<49.530000,0.038000,18.669000><49.530000,-1.538000,18.669000>0.175000 }
cylinder{<50.673000,0.038000,17.780000><50.673000,-1.538000,17.780000>0.175000 }
cylinder{<41.021000,0.038000,27.559000><41.021000,-1.538000,27.559000>0.175000 }
cylinder{<58.420000,0.038000,25.654000><58.420000,-1.538000,25.654000>0.175000 }
cylinder{<32.639000,0.038000,17.272000><32.639000,-1.538000,17.272000>0.175000 }
cylinder{<31.750000,0.038000,17.272000><31.750000,-1.538000,17.272000>0.175000 }
cylinder{<32.639000,0.038000,20.320000><32.639000,-1.538000,20.320000>0.175000 }
cylinder{<31.750000,0.038000,20.320000><31.750000,-1.538000,20.320000>0.175000 }
cylinder{<34.798000,0.038000,23.876000><34.798000,-1.538000,23.876000>0.175000 }
cylinder{<32.004000,0.038000,23.876000><32.004000,-1.538000,23.876000>0.175000 }
cylinder{<33.655000,0.038000,23.114000><33.655000,-1.538000,23.114000>0.175000 }
cylinder{<52.959000,0.038000,13.335000><52.959000,-1.538000,13.335000>0.175000 }
cylinder{<72.898000,0.038000,17.653000><72.898000,-1.538000,17.653000>0.175000 }
cylinder{<63.754000,0.038000,20.955000><63.754000,-1.538000,20.955000>0.175000 }
cylinder{<57.658000,0.038000,27.178000><57.658000,-1.538000,27.178000>0.175000 }
cylinder{<57.023000,0.038000,30.226000><57.023000,-1.538000,30.226000>0.175000 }
cylinder{<57.785000,0.038000,26.289000><57.785000,-1.538000,26.289000>0.175000 }
cylinder{<76.962000,0.038000,6.096000><76.962000,-1.538000,6.096000>0.175000 }
cylinder{<77.343000,0.038000,11.430000><77.343000,-1.538000,11.430000>0.175000 }
cylinder{<77.343000,0.038000,6.985000><77.343000,-1.538000,6.985000>0.175000 }
cylinder{<75.692000,0.038000,20.955000><75.692000,-1.538000,20.955000>0.175000 }
cylinder{<76.581000,0.038000,24.130000><76.581000,-1.538000,24.130000>0.175000 }
cylinder{<69.596000,0.038000,22.606000><69.596000,-1.538000,22.606000>0.175000 }
cylinder{<75.438000,0.038000,17.653000><75.438000,-1.538000,17.653000>0.175000 }
cylinder{<76.835000,0.038000,26.289000><76.835000,-1.538000,26.289000>0.175000 }
cylinder{<66.421000,0.038000,26.289000><66.421000,-1.538000,26.289000>0.175000 }
cylinder{<46.990000,0.038000,16.002000><46.990000,-1.538000,16.002000>0.175000 }
cylinder{<47.752000,0.038000,15.494000><47.752000,-1.538000,15.494000>0.175000 }
cylinder{<53.594000,0.038000,10.414000><53.594000,-1.538000,10.414000>0.175000 }
cylinder{<48.514000,0.038000,14.986000><48.514000,-1.538000,14.986000>0.175000 }
cylinder{<36.195000,0.038000,25.146000><36.195000,-1.538000,25.146000>0.175000 }
cylinder{<33.274000,0.038000,25.146000><33.274000,-1.538000,25.146000>0.175000 }
cylinder{<32.385000,0.038000,25.146000><32.385000,-1.538000,25.146000>0.175000 }
cylinder{<45.720000,0.038000,26.162000><45.720000,-1.538000,26.162000>0.175000 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.504200,-1.536000,15.034600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.448000,-1.536000,8.090900>}
box{<0,0,-0.101600><9.819945,0.036000,0.101600> rotate<0,44.996618,0> translate<53.504200,-1.536000,15.034600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.448000,-1.536000,8.090900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.504300,-1.536000,1.147100>}
box{<0,0,-0.101600><9.819945,0.036000,0.101600> rotate<0,-44.997443,0> translate<53.504300,-1.536000,1.147100> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.504300,-1.536000,1.147100>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.560500,-1.536000,8.090800>}
box{<0,0,-0.101600><9.819945,0.036000,0.101600> rotate<0,44.996618,0> translate<46.560500,-1.536000,8.090800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.560500,-1.536000,8.090800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.504200,-1.536000,15.034600>}
box{<0,0,-0.101600><9.819945,0.036000,0.101600> rotate<0,-44.997443,0> translate<46.560500,-1.536000,8.090800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.836200,-1.536000,8.097900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.504300,-1.536000,1.429900>}
box{<0,0,-0.101600><9.430047,0.036000,0.101600> rotate<0,44.996601,0> translate<46.836200,-1.536000,8.097900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.504300,-1.536000,1.429900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.165200,-1.536000,8.090900>}
box{<0,0,-0.101600><9.420006,0.036000,0.101600> rotate<0,-44.997460,0> translate<53.504300,-1.536000,1.429900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.165200,-1.536000,8.090900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.497200,-1.536000,14.758900>}
box{<0,0,-0.101600><9.429976,0.036000,0.101600> rotate<0,44.997030,0> translate<53.497200,-1.536000,14.758900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.497200,-1.536000,14.758900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.836200,-1.536000,8.097900>}
box{<0,0,-0.101600><9.420077,0.036000,0.101600> rotate<0,-44.997030,0> translate<46.836200,-1.536000,8.097900> }
difference{
cylinder{<53.504200,0,13.394300><53.504200,0.036000,13.394300>0.627200 translate<0,-1.536000,0>}
cylinder{<53.504200,-0.1,13.394300><53.504200,0.135000,13.394300>0.373200 translate<0,-1.536000,0>}}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<54.688700,-1.536000,14.578400>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<55.042100,-1.536000,14.224900>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<55.395800,-1.536000,13.871300>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<55.749200,-1.536000,13.517800>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<56.102900,-1.536000,13.164200>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<56.456400,-1.536000,12.810700>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<56.810000,-1.536000,12.457100>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<57.163400,-1.536000,12.103700>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<57.517100,-1.536000,11.750000>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<57.870500,-1.536000,11.396600>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<58.224100,-1.536000,11.043000>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<58.577600,-1.536000,10.689500>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<58.931200,-1.536000,10.335800>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<59.284700,-1.536000,9.982400>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<59.638300,-1.536000,9.628700>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<59.991800,-1.536000,9.275300>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<59.991800,-1.536000,6.906400>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<59.638300,-1.536000,6.553000>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<59.284700,-1.536000,6.199300>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<58.931200,-1.536000,5.845900>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<58.577600,-1.536000,5.492200>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<58.224100,-1.536000,5.138700>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<57.870500,-1.536000,4.785100>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<57.517100,-1.536000,4.431700>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<57.163400,-1.536000,4.078000>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<56.810000,-1.536000,3.724600>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<56.456400,-1.536000,3.371000>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<56.102900,-1.536000,3.017500>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<55.749200,-1.536000,2.663900>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<55.395800,-1.536000,2.310400>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<55.042100,-1.536000,1.956800>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<54.688700,-1.536000,1.603300>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<52.319800,-1.536000,1.603300>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<51.966400,-1.536000,1.956800>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<51.612700,-1.536000,2.310400>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<51.259300,-1.536000,2.663900>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<50.905600,-1.536000,3.017500>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<50.552100,-1.536000,3.371000>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<50.198500,-1.536000,3.724600>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<49.845100,-1.536000,4.078000>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<49.491400,-1.536000,4.431700>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<49.138000,-1.536000,4.785100>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<48.784400,-1.536000,5.138700>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<48.430900,-1.536000,5.492200>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<48.077300,-1.536000,5.845900>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<47.723800,-1.536000,6.199300>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<47.370200,-1.536000,6.553000>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-315.000000,0> translate<47.016700,-1.536000,6.906400>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<47.016700,-1.536000,9.275300>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<47.370200,-1.536000,9.628700>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<47.723800,-1.536000,9.982400>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<48.077300,-1.536000,10.335800>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<48.430900,-1.536000,10.689500>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<48.784400,-1.536000,11.043000>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<49.138000,-1.536000,11.396600>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<49.491400,-1.536000,11.750000>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<49.845100,-1.536000,12.103700>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<50.198500,-1.536000,12.457100>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<50.552100,-1.536000,12.810700>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<50.905600,-1.536000,13.164200>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<51.259300,-1.536000,13.517800>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<51.612700,-1.536000,13.871300>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<51.966400,-1.536000,14.224900>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-315.000000,0> translate<52.319800,-1.536000,14.578400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<75.469000,0.000000,8.038000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<75.469000,0.000000,9.488000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<75.469000,0.000000,9.488000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<76.169000,0.000000,9.488000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<76.169000,0.000000,8.038000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<76.169000,0.000000,8.038000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<75.819000,0.000000,8.138000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<75.819000,0.000000,9.388000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.538000,0.000000,11.653000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.988000,0.000000,11.653000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<71.538000,0.000000,11.653000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.988000,0.000000,10.953000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.538000,0.000000,10.953000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<71.538000,0.000000,10.953000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<71.638000,0.000000,11.303000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<72.888000,0.000000,11.303000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.236000,0.000000,11.653000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.686000,0.000000,11.653000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<68.236000,0.000000,11.653000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.686000,0.000000,10.953000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.236000,0.000000,10.953000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<68.236000,0.000000,10.953000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<68.336000,0.000000,11.303000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<69.586000,0.000000,11.303000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<76.169000,0.000000,5.170000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<76.169000,0.000000,3.720000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<76.169000,0.000000,3.720000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<75.469000,0.000000,3.720000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<75.469000,0.000000,5.170000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<75.469000,0.000000,5.170000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<75.819000,0.000000,5.070000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<75.819000,0.000000,3.820000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.771000,0.000000,6.186000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.771000,0.000000,4.736000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<66.771000,0.000000,4.736000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.071000,0.000000,4.736000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.071000,0.000000,6.186000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<66.071000,0.000000,6.186000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<66.421000,0.000000,6.086000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<66.421000,0.000000,4.836000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<77.374000,-1.536000,5.805000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<77.374000,-1.536000,4.355000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<77.374000,-1.536000,4.355000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<78.074000,-1.536000,4.355000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<78.074000,-1.536000,5.805000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<78.074000,-1.536000,5.805000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<77.724000,-1.536000,5.705000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<77.724000,-1.536000,4.455000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.071000,0.000000,8.038000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.071000,0.000000,9.488000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<66.071000,0.000000,9.488000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.771000,0.000000,9.488000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.771000,0.000000,8.038000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<66.771000,0.000000,8.038000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<66.421000,0.000000,8.138000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<66.421000,0.000000,9.388000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<65.622000,-1.536000,18.003000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.172000,-1.536000,18.003000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<64.172000,-1.536000,18.003000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.172000,-1.536000,17.303000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<65.622000,-1.536000,17.303000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<64.172000,-1.536000,17.303000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<65.522000,-1.536000,17.653000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<64.272000,-1.536000,17.653000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<48.717200,0.000000,9.693500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.742500,0.000000,10.718800>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,-44.997030,0> translate<48.717200,0.000000,9.693500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.237500,0.000000,10.223800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.212200,0.000000,9.198500>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,-44.997030,0> translate<49.212200,0.000000,9.198500> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-45.000000,0> translate<49.035400,0.000000,9.516700>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-45.000000,0> translate<49.919300,0.000000,10.400600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<73.062000,-1.536000,16.287000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<74.512000,-1.536000,16.287000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<73.062000,-1.536000,16.287000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<74.512000,-1.536000,16.987000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<73.062000,-1.536000,16.987000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<73.062000,-1.536000,16.987000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<73.162000,-1.536000,16.637000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<74.412000,-1.536000,16.637000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<45.731000,0.000000,9.728200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.705700,0.000000,10.753500>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<44.705700,0.000000,10.753500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<45.200700,0.000000,11.248500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.226000,0.000000,10.223200>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<45.200700,0.000000,11.248500> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-135.000000,0> translate<45.907800,0.000000,10.046400>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-135.000000,0> translate<45.023900,0.000000,10.930300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.300000,-1.536000,27.463000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<73.750000,-1.536000,27.463000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<72.300000,-1.536000,27.463000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<73.750000,-1.536000,28.163000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.300000,-1.536000,28.163000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<72.300000,-1.536000,28.163000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<72.400000,-1.536000,27.813000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<73.650000,-1.536000,27.813000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.511000,0.000000,27.590000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<65.061000,0.000000,27.590000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<65.061000,0.000000,27.590000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<65.061000,0.000000,28.290000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.511000,0.000000,28.290000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<65.061000,0.000000,28.290000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<66.411000,0.000000,27.940000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<65.161000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.511000,0.000000,29.114000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<65.061000,0.000000,29.114000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<65.061000,0.000000,29.114000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<65.061000,0.000000,29.814000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.511000,0.000000,29.814000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<65.061000,0.000000,29.814000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<66.411000,0.000000,29.464000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<65.161000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.766900,0.000000,24.675100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.766900,0.000000,26.125100>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<46.766900,0.000000,26.125100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<47.466900,0.000000,26.125100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<47.466900,0.000000,24.675100>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<47.466900,0.000000,24.675100> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<47.116900,0.000000,24.775100>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<47.116900,0.000000,26.025100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.313800,0.000000,25.525100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.339100,0.000000,24.499800>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<60.313800,0.000000,25.525100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.844100,0.000000,24.004800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.818800,0.000000,25.030100>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<59.818800,0.000000,25.030100> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-315.000000,0> translate<60.137000,0.000000,25.206900>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-315.000000,0> translate<61.020900,0.000000,24.323000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<45.858100,0.000000,16.638800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.832800,0.000000,17.664100>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<44.832800,0.000000,17.664100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<45.327800,0.000000,18.159100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.353100,0.000000,17.133800>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<45.327800,0.000000,18.159100> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-135.000000,0> translate<46.034900,0.000000,16.957000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-135.000000,0> translate<45.151000,0.000000,17.840900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.519200,0.000000,24.309800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.519200,0.000000,22.859800>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<40.519200,0.000000,22.859800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.819200,0.000000,22.859800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.819200,0.000000,24.309800>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<39.819200,0.000000,24.309800> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<40.169200,0.000000,24.209800>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<40.169200,0.000000,22.959800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.043800,0.000000,15.111100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.069100,0.000000,14.085800>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<59.043800,0.000000,15.111100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.574100,0.000000,13.590800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.548800,0.000000,14.616100>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<58.548800,0.000000,14.616100> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-315.000000,0> translate<58.867000,0.000000,14.792900>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-315.000000,0> translate<59.750900,0.000000,13.909000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<51.296800,0.000000,12.063100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<52.322100,0.000000,11.037800>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<51.296800,0.000000,12.063100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<51.827100,0.000000,10.542800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.801800,0.000000,11.568100>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<50.801800,0.000000,11.568100> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-315.000000,0> translate<51.120000,0.000000,11.744900>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-315.000000,0> translate<52.003900,0.000000,10.861000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<76.237000,-1.536000,22.637000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<77.687000,-1.536000,22.637000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<76.237000,-1.536000,22.637000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<77.687000,-1.536000,23.337000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<76.237000,-1.536000,23.337000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<76.237000,-1.536000,23.337000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<76.337000,-1.536000,22.987000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<77.587000,-1.536000,22.987000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.519000,0.000000,23.061000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.519000,0.000000,25.961000>}
box{<0,0,-0.050800><2.900000,0.036000,0.050800> rotate<0,90.000000,0> translate<62.519000,0.000000,25.961000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.519000,0.000000,25.961000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<63.719000,0.000000,25.961000>}
box{<0,0,-0.050800><1.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<62.519000,0.000000,25.961000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<63.719000,0.000000,25.961000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<63.719000,0.000000,23.061000>}
box{<0,0,-0.050800><2.900000,0.036000,0.050800> rotate<0,-90.000000,0> translate<63.719000,0.000000,23.061000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<63.719000,0.000000,23.061000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.519000,0.000000,23.061000>}
box{<0,0,-0.050800><1.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<62.519000,0.000000,23.061000> }
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-90.000000,0> translate<63.119000,0.000000,22.973500>}
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-90.000000,0> translate<63.119000,0.000000,26.048500>}
box{<-0.150000,0,-0.625000><0.150000,0.036000,0.625000> rotate<0,-90.000000,0> translate<63.119000,0.000000,25.461000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.859000,-1.536000,20.394000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.859000,-1.536000,23.294000>}
box{<0,0,-0.050800><2.900000,0.036000,0.050800> rotate<0,90.000000,0> translate<40.859000,-1.536000,23.294000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.859000,-1.536000,23.294000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.659000,-1.536000,23.294000>}
box{<0,0,-0.050800><1.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<39.659000,-1.536000,23.294000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.659000,-1.536000,23.294000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.659000,-1.536000,20.394000>}
box{<0,0,-0.050800><2.900000,0.036000,0.050800> rotate<0,-90.000000,0> translate<39.659000,-1.536000,20.394000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.659000,-1.536000,20.394000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.859000,-1.536000,20.394000>}
box{<0,0,-0.050800><1.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<39.659000,-1.536000,20.394000> }
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-90.000000,0> translate<40.259000,-1.536000,20.306500>}
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-90.000000,0> translate<40.259000,-1.536000,23.381500>}
box{<-0.150000,0,-0.625000><0.150000,0.036000,0.625000> rotate<0,-90.000000,0> translate<40.259000,-1.536000,22.794000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<55.575000,-1.536000,21.647000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<52.375000,-1.536000,21.647000>}
box{<0,0,-0.050800><3.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<52.375000,-1.536000,21.647000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<52.375000,-1.536000,21.647000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<52.375000,-1.536000,19.247000>}
box{<0,0,-0.050800><2.400000,0.036000,0.050800> rotate<0,-90.000000,0> translate<52.375000,-1.536000,19.247000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<52.375000,-1.536000,19.247000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<55.575000,-1.536000,19.247000>}
box{<0,0,-0.050800><3.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<52.375000,-1.536000,19.247000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<55.575000,-1.536000,19.247000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<55.575000,-1.536000,21.647000>}
box{<0,0,-0.050800><2.400000,0.036000,0.050800> rotate<0,90.000000,0> translate<55.575000,-1.536000,21.647000> }
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-180.000000,0> translate<55.662500,-1.536000,20.447000>}
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-180.000000,0> translate<52.287500,-1.536000,20.447000>}
box{<-0.150000,0,-1.225000><0.150000,0.036000,1.225000> rotate<0,-180.000000,0> translate<52.875000,-1.536000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<54.446000,-1.536000,18.511000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<52.996000,-1.536000,18.511000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<52.996000,-1.536000,18.511000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<52.996000,-1.536000,17.811000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<54.446000,-1.536000,17.811000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<52.996000,-1.536000,17.811000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<54.346000,-1.536000,18.161000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<53.096000,-1.536000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.342000,-1.536000,19.247000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<45.542000,-1.536000,19.247000>}
box{<0,0,-0.050800><3.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<42.342000,-1.536000,19.247000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<45.542000,-1.536000,19.247000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<45.542000,-1.536000,21.647000>}
box{<0,0,-0.050800><2.400000,0.036000,0.050800> rotate<0,90.000000,0> translate<45.542000,-1.536000,21.647000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<45.542000,-1.536000,21.647000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.342000,-1.536000,21.647000>}
box{<0,0,-0.050800><3.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<42.342000,-1.536000,21.647000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.342000,-1.536000,21.647000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.342000,-1.536000,19.247000>}
box{<0,0,-0.050800><2.400000,0.036000,0.050800> rotate<0,-90.000000,0> translate<42.342000,-1.536000,19.247000> }
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-0.000000,0> translate<42.254500,-1.536000,20.447000>}
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-0.000000,0> translate<45.629500,-1.536000,20.447000>}
box{<-0.150000,0,-1.225000><0.150000,0.036000,1.225000> rotate<0,-0.000000,0> translate<45.042000,-1.536000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<63.068000,0.000000,12.979000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<63.068000,0.000000,13.691000>}
box{<0,0,-0.050800><0.712000,0.036000,0.050800> rotate<0,90.000000,0> translate<63.068000,0.000000,13.691000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<63.919000,0.000000,12.979000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<63.919000,0.000000,13.691000>}
box{<0,0,-0.050800><0.712000,0.036000,0.050800> rotate<0,90.000000,0> translate<63.919000,0.000000,13.691000> }
box{<-0.250100,0,-0.475000><0.250100,0.036000,0.475000> rotate<0,-90.000000,0> translate<63.494900,0.000000,12.746900>}
box{<-0.250100,0,-0.475000><0.250100,0.036000,0.475000> rotate<0,-90.000000,0> translate<63.494900,0.000000,13.915200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.217000,-1.536000,17.938000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.667000,-1.536000,17.938000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<43.217000,-1.536000,17.938000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.667000,-1.536000,18.638000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.217000,-1.536000,18.638000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<43.217000,-1.536000,18.638000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<43.317000,-1.536000,18.288000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<44.567000,-1.536000,18.288000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<75.782000,-1.536000,10.129000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<74.332000,-1.536000,10.129000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<74.332000,-1.536000,10.129000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<74.332000,-1.536000,9.429000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<75.782000,-1.536000,9.429000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<74.332000,-1.536000,9.429000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<75.682000,-1.536000,9.779000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<74.432000,-1.536000,9.779000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.675000,-1.536000,12.917000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.675000,-1.536000,11.467000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<72.675000,-1.536000,11.467000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<73.375000,-1.536000,11.467000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<73.375000,-1.536000,12.917000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<73.375000,-1.536000,12.917000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<73.025000,-1.536000,12.817000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<73.025000,-1.536000,11.567000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<75.782000,-1.536000,7.208000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<74.332000,-1.536000,7.208000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<74.332000,-1.536000,7.208000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<74.332000,-1.536000,6.508000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<75.782000,-1.536000,6.508000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<74.332000,-1.536000,6.508000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<75.682000,-1.536000,6.858000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<74.432000,-1.536000,6.858000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<73.375000,-1.536000,3.466000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<73.375000,-1.536000,4.916000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<73.375000,-1.536000,4.916000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.675000,-1.536000,4.916000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.675000,-1.536000,3.466000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<72.675000,-1.536000,3.466000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<73.025000,-1.536000,3.566000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<73.025000,-1.536000,4.816000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.902000,-1.536000,9.429000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.352000,-1.536000,9.429000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<62.902000,-1.536000,9.429000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.352000,-1.536000,10.129000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.902000,-1.536000,10.129000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<62.902000,-1.536000,10.129000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<63.002000,-1.536000,9.779000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<64.252000,-1.536000,9.779000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<65.309000,-1.536000,12.917000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<65.309000,-1.536000,11.467000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<65.309000,-1.536000,11.467000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.009000,-1.536000,11.467000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.009000,-1.536000,12.917000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<66.009000,-1.536000,12.917000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<65.659000,-1.536000,12.817000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<65.659000,-1.536000,11.567000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.014000,-1.536000,13.620000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.464000,-1.536000,13.620000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<70.014000,-1.536000,13.620000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.464000,-1.536000,14.320000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.014000,-1.536000,14.320000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<70.014000,-1.536000,14.320000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<70.114000,-1.536000,13.970000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<71.364000,-1.536000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<75.856000,-1.536000,7.905000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<77.306000,-1.536000,7.905000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<75.856000,-1.536000,7.905000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<77.306000,-1.536000,8.605000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<75.856000,-1.536000,8.605000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<75.856000,-1.536000,8.605000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<75.956000,-1.536000,8.255000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<77.206000,-1.536000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.560000,-1.536000,19.251000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.560000,-1.536000,22.151000>}
box{<0,0,-0.050800><2.900000,0.036000,0.050800> rotate<0,90.000000,0> translate<61.560000,-1.536000,22.151000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.560000,-1.536000,22.151000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.360000,-1.536000,22.151000>}
box{<0,0,-0.050800><1.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<60.360000,-1.536000,22.151000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.360000,-1.536000,22.151000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.360000,-1.536000,19.251000>}
box{<0,0,-0.050800><2.900000,0.036000,0.050800> rotate<0,-90.000000,0> translate<60.360000,-1.536000,19.251000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.360000,-1.536000,19.251000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.560000,-1.536000,19.251000>}
box{<0,0,-0.050800><1.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<60.360000,-1.536000,19.251000> }
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-90.000000,0> translate<60.960000,-1.536000,19.163500>}
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-90.000000,0> translate<60.960000,-1.536000,22.238500>}
box{<-0.150000,0,-0.625000><0.150000,0.036000,0.625000> rotate<0,-90.000000,0> translate<60.960000,-1.536000,21.651000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.892000,-1.536000,17.981000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.892000,-1.536000,20.881000>}
box{<0,0,-0.050800><2.900000,0.036000,0.050800> rotate<0,90.000000,0> translate<50.892000,-1.536000,20.881000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.892000,-1.536000,20.881000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.692000,-1.536000,20.881000>}
box{<0,0,-0.050800><1.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<49.692000,-1.536000,20.881000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.692000,-1.536000,20.881000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.692000,-1.536000,17.981000>}
box{<0,0,-0.050800><2.900000,0.036000,0.050800> rotate<0,-90.000000,0> translate<49.692000,-1.536000,17.981000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.692000,-1.536000,17.981000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.892000,-1.536000,17.981000>}
box{<0,0,-0.050800><1.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<49.692000,-1.536000,17.981000> }
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-90.000000,0> translate<50.292000,-1.536000,17.893500>}
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-90.000000,0> translate<50.292000,-1.536000,20.968500>}
box{<-0.150000,0,-0.625000><0.150000,0.036000,0.625000> rotate<0,-90.000000,0> translate<50.292000,-1.536000,20.381000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.655000,-1.536000,28.030000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.655000,-1.536000,26.580000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<39.655000,-1.536000,26.580000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.355000,-1.536000,26.580000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.355000,-1.536000,28.030000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<40.355000,-1.536000,28.030000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<40.005000,-1.536000,27.930000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<40.005000,-1.536000,26.680000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.728000,0.000000,13.304000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.178000,0.000000,13.304000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<67.728000,0.000000,13.304000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.178000,0.000000,12.604000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.728000,0.000000,12.604000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<67.728000,0.000000,12.604000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<67.828000,0.000000,12.954000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<69.078000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<56.732000,0.000000,9.048000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<55.282000,0.000000,9.048000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<55.282000,0.000000,9.048000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<55.282000,0.000000,9.748000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<56.732000,0.000000,9.748000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<55.282000,0.000000,9.748000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<56.632000,0.000000,9.398000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<55.382000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.900000,0.000000,4.541000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<48.350000,0.000000,4.541000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<46.900000,0.000000,4.541000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<48.350000,0.000000,3.841000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.900000,0.000000,3.841000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<46.900000,0.000000,3.841000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<47.000000,0.000000,4.191000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<48.250000,0.000000,4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.948000,0.000000,4.541000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<51.398000,0.000000,4.541000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<49.948000,0.000000,4.541000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<51.398000,0.000000,3.841000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.948000,0.000000,3.841000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<49.948000,0.000000,3.841000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<50.048000,0.000000,4.191000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<51.298000,0.000000,4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<48.297000,0.000000,8.478000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.747000,0.000000,8.478000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<48.297000,0.000000,8.478000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.747000,0.000000,7.778000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<48.297000,0.000000,7.778000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<48.297000,0.000000,7.778000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<48.397000,0.000000,8.128000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<49.647000,0.000000,8.128000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<56.044000,0.000000,4.541000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<57.494000,0.000000,4.541000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<56.044000,0.000000,4.541000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<57.494000,0.000000,3.841000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<56.044000,0.000000,3.841000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<56.044000,0.000000,3.841000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<56.144000,0.000000,4.191000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<57.394000,0.000000,4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.909000,0.000000,7.800000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.909000,0.000000,4.900000>}
box{<0,0,-0.050800><2.900000,0.036000,0.050800> rotate<0,-90.000000,0> translate<59.909000,0.000000,4.900000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.909000,0.000000,4.900000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.709000,0.000000,4.900000>}
box{<0,0,-0.050800><1.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<58.709000,0.000000,4.900000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.709000,0.000000,4.900000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.709000,0.000000,7.800000>}
box{<0,0,-0.050800><2.900000,0.036000,0.050800> rotate<0,90.000000,0> translate<58.709000,0.000000,7.800000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.709000,0.000000,7.800000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.909000,0.000000,7.800000>}
box{<0,0,-0.050800><1.200000,0.036000,0.050800> rotate<0,0.000000,0> translate<58.709000,0.000000,7.800000> }
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-270.000000,0> translate<59.309000,0.000000,7.887500>}
box{<-0.062500,0,-0.600000><0.062500,0.036000,0.600000> rotate<0,-270.000000,0> translate<59.309000,0.000000,4.812500>}
box{<-0.150000,0,-0.625000><0.150000,0.036000,0.625000> rotate<0,-270.000000,0> translate<59.309000,0.000000,5.400000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<57.568000,-1.536000,19.208000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.018000,-1.536000,19.208000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<57.568000,-1.536000,19.208000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.018000,-1.536000,19.908000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<57.568000,-1.536000,19.908000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<57.568000,-1.536000,19.908000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<57.668000,-1.536000,19.558000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<58.918000,-1.536000,19.558000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.226200,-1.536000,11.926800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<45.200900,-1.536000,12.952100>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<45.200900,-1.536000,12.952100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.705900,-1.536000,12.457100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<45.731200,-1.536000,11.431800>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<44.705900,-1.536000,12.457100> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-135.000000,0> translate<45.908000,-1.536000,11.750000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-135.000000,0> translate<45.024100,-1.536000,12.633900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.356900,-1.536000,3.440100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<47.382200,-1.536000,2.414800>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<46.356900,-1.536000,3.440100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<47.877200,-1.536000,2.909800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.851900,-1.536000,3.935100>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<46.851900,-1.536000,3.935100> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-315.000000,0> translate<46.675100,-1.536000,3.616900>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-315.000000,0> translate<47.559000,-1.536000,2.733000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.567900,-1.536000,3.303800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.593200,-1.536000,4.329100>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,-44.997030,0> translate<60.567900,-1.536000,3.303800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.098200,-1.536000,4.824100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.072900,-1.536000,3.798800>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,-44.997030,0> translate<60.072900,-1.536000,3.798800> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-45.000000,0> translate<60.391100,-1.536000,3.622000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-45.000000,0> translate<61.275000,-1.536000,4.505900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.703000,0.000000,6.260000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.703000,0.000000,7.710000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<42.703000,0.000000,7.710000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.403000,0.000000,7.710000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.403000,0.000000,6.260000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<43.403000,0.000000,6.260000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<43.053000,0.000000,6.360000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<43.053000,0.000000,7.610000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.307200,-1.536000,14.212800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.281900,-1.536000,15.238100>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<58.281900,-1.536000,15.238100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<57.786900,-1.536000,14.743100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<58.812200,-1.536000,13.717800>}
box{<0,0,-0.050800><1.449993,0.036000,0.050800> rotate<0,44.997030,0> translate<57.786900,-1.536000,14.743100> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-135.000000,0> translate<58.989000,-1.536000,14.036000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-135.000000,0> translate<58.105100,-1.536000,14.919900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.927100,-1.536000,16.441800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.477100,-1.536000,16.441800>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<49.477100,-1.536000,16.441800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.477100,-1.536000,15.741800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.927100,-1.536000,15.741800>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<49.477100,-1.536000,15.741800> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<50.827100,-1.536000,16.091800>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-180.000000,0> translate<49.577100,-1.536000,16.091800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.793400,-1.536000,20.624800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.793400,-1.536000,17.983200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.793400,-1.536000,17.983200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.218600,-1.536000,20.624800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.218600,-1.536000,17.983200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.218600,-1.536000,17.983200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.606000,-1.536000,19.804000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.006000,-1.536000,18.804000>}
box{<0,0,-0.101600><1.166190,0.036000,0.101600> rotate<0,-59.032347,0> translate<48.006000,-1.536000,18.804000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.006000,-1.536000,18.804000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.406000,-1.536000,19.804000>}
box{<0,0,-0.101600><1.166190,0.036000,0.101600> rotate<0,59.032347,0> translate<47.406000,-1.536000,19.804000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.406000,-1.536000,19.804000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.606000,-1.536000,19.804000>}
box{<0,0,-0.101600><1.200000,0.036000,0.101600> rotate<0,0.000000,0> translate<47.406000,-1.536000,19.804000> }
box{<-0.279400,0,-0.863600><0.279400,0.036000,0.863600> rotate<0,-90.000000,0> translate<48.006000,-1.536000,17.729200>}
box{<-0.279400,0,-0.863600><0.279400,0.036000,0.863600> rotate<0,-90.000000,0> translate<48.006000,-1.536000,20.878800>}
box{<-0.304800,0,-0.787400><0.304800,0.036000,0.787400> rotate<0,-90.000000,0> translate<48.006000,-1.536000,18.618200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.646500,0.000000,13.503200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.590300,0.000000,20.446900>}
box{<0,0,-0.101600><9.819945,0.036000,0.101600> rotate<0,-44.996618,0> translate<53.646500,0.000000,13.503200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.590300,0.000000,20.446900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.646600,0.000000,27.390700>}
box{<0,0,-0.101600><9.819945,0.036000,0.101600> rotate<0,44.997443,0> translate<53.646600,0.000000,27.390700> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.646600,0.000000,27.390700>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.702800,0.000000,20.447000>}
box{<0,0,-0.101600><9.819945,0.036000,0.101600> rotate<0,-44.996618,0> translate<46.702800,0.000000,20.447000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.702800,0.000000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.646500,0.000000,13.503200>}
box{<0,0,-0.101600><9.819945,0.036000,0.101600> rotate<0,44.997443,0> translate<46.702800,0.000000,20.447000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.978500,0.000000,20.439900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.646600,0.000000,27.107900>}
box{<0,0,-0.101600><9.430047,0.036000,0.101600> rotate<0,-44.996601,0> translate<46.978500,0.000000,20.439900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.646600,0.000000,27.107900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.307500,0.000000,20.446900>}
box{<0,0,-0.101600><9.420006,0.036000,0.101600> rotate<0,44.997460,0> translate<53.646600,0.000000,27.107900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.307500,0.000000,20.446900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.639500,0.000000,13.778900>}
box{<0,0,-0.101600><9.429976,0.036000,0.101600> rotate<0,-44.997030,0> translate<53.639500,0.000000,13.778900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.639500,0.000000,13.778900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.978500,0.000000,20.439900>}
box{<0,0,-0.101600><9.420077,0.036000,0.101600> rotate<0,44.997030,0> translate<46.978500,0.000000,20.439900> }
difference{
cylinder{<53.646500,0,15.143500><53.646500,0.036000,15.143500>0.627200 translate<0,0.000000,0>}
cylinder{<53.646500,-0.1,15.143500><53.646500,0.135000,15.143500>0.373200 translate<0,0.000000,0>}}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<54.831000,0.000000,13.959400>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<55.184400,0.000000,14.312900>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<55.538100,0.000000,14.666500>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<55.891500,0.000000,15.020000>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<56.245200,0.000000,15.373600>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<56.598700,0.000000,15.727100>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<56.952300,0.000000,16.080700>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<57.305700,0.000000,16.434100>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<57.659400,0.000000,16.787800>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<58.012800,0.000000,17.141200>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<58.366400,0.000000,17.494800>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<58.719900,0.000000,17.848300>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<59.073500,0.000000,18.202000>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<59.427000,0.000000,18.555400>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<59.780600,0.000000,18.909100>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<60.134100,0.000000,19.262500>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<60.134100,0.000000,21.631400>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<59.780600,0.000000,21.984800>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<59.427000,0.000000,22.338500>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<59.073500,0.000000,22.691900>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<58.719900,0.000000,23.045600>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<58.366400,0.000000,23.399100>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<58.012800,0.000000,23.752700>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<57.659400,0.000000,24.106100>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<57.305700,0.000000,24.459800>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<56.952300,0.000000,24.813200>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<56.598700,0.000000,25.166800>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<56.245200,0.000000,25.520300>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<55.891500,0.000000,25.873900>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<55.538100,0.000000,26.227400>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<55.184400,0.000000,26.581000>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<54.831000,0.000000,26.934500>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<52.462100,0.000000,26.934500>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<52.108700,0.000000,26.581000>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<51.755000,0.000000,26.227400>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<51.401600,0.000000,25.873900>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<51.047900,0.000000,25.520300>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<50.694400,0.000000,25.166800>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<50.340800,0.000000,24.813200>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<49.987400,0.000000,24.459800>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<49.633700,0.000000,24.106100>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<49.280300,0.000000,23.752700>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<48.926700,0.000000,23.399100>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<48.573200,0.000000,23.045600>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<48.219600,0.000000,22.691900>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<47.866100,0.000000,22.338500>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<47.512500,0.000000,21.984800>}
box{<-0.150000,0,-0.475000><0.150000,0.036000,0.475000> rotate<0,-45.000000,0> translate<47.159000,0.000000,21.631400>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<47.159000,0.000000,19.262500>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<47.512500,0.000000,18.909100>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<47.866100,0.000000,18.555400>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<48.219600,0.000000,18.202000>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<48.573200,0.000000,17.848300>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<48.926700,0.000000,17.494800>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<49.280300,0.000000,17.141200>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<49.633700,0.000000,16.787800>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<49.987400,0.000000,16.434100>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<50.340800,0.000000,16.080700>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<50.694400,0.000000,15.727100>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<51.047900,0.000000,15.373600>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<51.401600,0.000000,15.020000>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<51.755000,0.000000,14.666500>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<52.108700,0.000000,14.312900>}
box{<-0.475000,0,-0.150000><0.475000,0.036000,0.150000> rotate<0,-45.000000,0> translate<52.462100,0.000000,13.959400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.626000,-1.536000,3.280000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<61.151000,-1.536000,3.280000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,0.000000,0> translate<60.626000,-1.536000,3.280000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<61.151000,-1.536000,3.280000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<69.151000,-1.536000,3.280000>}
box{<0,0,-0.101600><8.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<61.151000,-1.536000,3.280000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<69.151000,-1.536000,3.280000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<69.676000,-1.536000,3.280000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,0.000000,0> translate<69.151000,-1.536000,3.280000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.651000,-1.536000,0.280000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.151000,-1.536000,0.280000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<60.651000,-1.536000,0.280000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.151000,-1.536000,0.280000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.401000,-1.536000,0.280000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<61.151000,-1.536000,0.280000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.401000,-1.536000,0.280000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.401000,-1.536000,0.905000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<61.401000,-1.536000,0.905000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.401000,-1.536000,0.905000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.901000,-1.536000,0.905000>}
box{<0,0,-0.025400><7.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<61.401000,-1.536000,0.905000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.901000,-1.536000,0.280000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.151000,-1.536000,0.280000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<68.901000,-1.536000,0.280000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.151000,-1.536000,0.280000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.651000,-1.536000,0.280000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<69.151000,-1.536000,0.280000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.901000,-1.536000,0.280000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.901000,-1.536000,0.905000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<68.901000,-1.536000,0.905000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.651000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.151000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<60.651000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.151000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.151000,-1.536000,3.280000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<61.151000,-1.536000,3.280000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.151000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.651000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<69.151000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.151000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.151000,-1.536000,3.280000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<69.151000,-1.536000,3.280000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.151000,-1.536000,0.280000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.151000,-1.536000,-0.345000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,-90.000000,0> translate<61.151000,-1.536000,-0.345000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.151000,-1.536000,-0.345000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.151000,-1.536000,-0.345000>}
box{<0,0,-0.025400><8.000000,0.036000,0.025400> rotate<0,0.000000,0> translate<61.151000,-1.536000,-0.345000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.151000,-1.536000,-0.345000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.151000,-1.536000,0.280000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<69.151000,-1.536000,0.280000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.776000,-1.536000,3.155000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.776000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<61.776000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<61.776000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<62.276000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<61.776000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<62.276000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<62.276000,-1.536000,3.155000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<62.276000,-1.536000,3.155000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<63.026000,-1.536000,3.155000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<63.026000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<63.026000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<63.026000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<63.526000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<63.026000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<63.526000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<63.526000,-1.536000,3.155000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<63.526000,-1.536000,3.155000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<64.276000,-1.536000,3.155000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<64.276000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<64.276000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<64.276000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<64.776000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<64.276000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<64.776000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<64.776000,-1.536000,3.155000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<64.776000,-1.536000,3.155000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.526000,-1.536000,3.155000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.526000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<65.526000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<65.526000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<66.026000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<65.526000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<66.026000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<66.026000,-1.536000,3.155000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<66.026000,-1.536000,3.155000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<66.776000,-1.536000,3.155000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<66.776000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<66.776000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<66.776000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.276000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<66.776000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.276000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.276000,-1.536000,3.155000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<67.276000,-1.536000,3.155000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.026000,-1.536000,3.155000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.026000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<68.026000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.026000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.526000,-1.536000,2.655000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<68.026000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.526000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.526000,-1.536000,3.155000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<68.526000,-1.536000,3.155000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.526000,-1.536000,-0.345000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.651000,-1.536000,-0.345000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,0.000000,0> translate<58.651000,-1.536000,-0.345000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.651000,-1.536000,-0.345000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.651000,-1.536000,2.655000>}
box{<0,0,-0.101600><3.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<58.651000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.651000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<60.526000,-1.536000,2.655000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,0.000000,0> translate<58.651000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<69.776000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.651000,-1.536000,2.655000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,0.000000,0> translate<69.776000,-1.536000,2.655000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.651000,-1.536000,2.655000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.651000,-1.536000,-0.345000>}
box{<0,0,-0.101600><3.000000,0.036000,0.101600> rotate<0,-90.000000,0> translate<71.651000,-1.536000,-0.345000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.651000,-1.536000,-0.345000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<69.776000,-1.536000,-0.345000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,0.000000,0> translate<69.776000,-1.536000,-0.345000> }
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<62.026000,-1.536000,0.467500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<63.276000,-1.536000,0.467500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<64.526000,-1.536000,0.467500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<65.776000,-1.536000,0.467500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<67.026000,-1.536000,0.467500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<68.276000,-1.536000,0.467500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.131000,-1.536000,3.026000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.656000,-1.536000,3.026000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.131000,-1.536000,3.026000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.656000,-1.536000,3.026000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.656000,-1.536000,3.026000>}
box{<0,0,-0.101600><8.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.656000,-1.536000,3.026000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.656000,-1.536000,3.026000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.181000,-1.536000,3.026000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.656000,-1.536000,3.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.156000,-1.536000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,-1.536000,0.026000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.156000,-1.536000,0.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,-1.536000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,-1.536000,0.026000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.656000,-1.536000,0.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,-1.536000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,-1.536000,0.651000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<37.906000,-1.536000,0.651000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,-1.536000,0.651000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,-1.536000,0.651000>}
box{<0,0,-0.025400><7.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.906000,-1.536000,0.651000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,-1.536000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,-1.536000,0.026000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<45.406000,-1.536000,0.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,-1.536000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<46.156000,-1.536000,0.026000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<45.656000,-1.536000,0.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,-1.536000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,-1.536000,0.651000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<45.406000,-1.536000,0.651000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.156000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.156000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,-1.536000,3.026000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<37.656000,-1.536000,3.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<46.156000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<45.656000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,-1.536000,3.026000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<45.656000,-1.536000,3.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.281000,-1.536000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.281000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<38.281000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.281000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.781000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<38.281000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.781000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.781000,-1.536000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<38.781000,-1.536000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<39.531000,-1.536000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<39.531000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<39.531000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<39.531000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.031000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<39.531000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.031000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.031000,-1.536000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<40.031000,-1.536000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.781000,-1.536000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.781000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<40.781000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.781000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.281000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<40.781000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.281000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.281000,-1.536000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<41.281000,-1.536000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.031000,-1.536000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.031000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<42.031000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.031000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.531000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<42.031000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.531000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.531000,-1.536000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<42.531000,-1.536000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.281000,-1.536000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.281000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<43.281000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.281000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.781000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<43.281000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.781000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.781000,-1.536000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<43.781000,-1.536000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.531000,-1.536000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.531000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<44.531000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.531000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.031000,-1.536000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<44.531000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.031000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.031000,-1.536000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<45.031000,-1.536000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.156000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.031000,-1.536000,2.401000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,0.000000,0> translate<35.156000,-1.536000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.281000,-1.536000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.156000,-1.536000,2.401000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.281000,-1.536000,2.401000> }
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<38.531000,-1.536000,0.213500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<39.781000,-1.536000,0.213500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<41.031000,-1.536000,0.213500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<42.281000,-1.536000,0.213500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<43.531000,-1.536000,0.213500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<44.781000,-1.536000,0.213500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.620000,0.000000,10.104000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.370000,0.000000,10.104000>}
box{<0,0,-0.063500><0.750000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.620000,0.000000,10.104000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.370000,0.000000,10.104000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.620000,0.000000,10.104000>}
box{<0,0,-0.063500><6.250000,0.036000,0.063500> rotate<0,0.000000,0> translate<68.370000,0.000000,10.104000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.620000,0.000000,10.104000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.620000,0.000000,3.104000>}
box{<0,0,-0.063500><7.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<74.620000,0.000000,3.104000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.620000,0.000000,3.104000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.620000,0.000000,3.104000>}
box{<0,0,-0.063500><7.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.620000,0.000000,3.104000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.620000,0.000000,3.104000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.620000,0.000000,9.354000>}
box{<0,0,-0.063500><6.250000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.620000,0.000000,9.354000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.620000,0.000000,9.354000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.620000,0.000000,10.104000>}
box{<0,0,-0.063500><0.750000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.620000,0.000000,10.104000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.620000,0.000000,9.354000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.370000,0.000000,10.104000>}
box{<0,0,-0.063500><1.060660,0.036000,0.063500> rotate<0,-44.997030,0> translate<67.620000,0.000000,9.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.715400,-1.536000,21.668600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.715400,-1.536000,23.289400>}
box{<0,0,-0.076200><1.620800,0.036000,0.076200> rotate<0,90.000000,0> translate<59.715400,-1.536000,23.289400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.715400,-1.536000,23.289400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.870600,-1.536000,23.289400>}
box{<0,0,-0.076200><2.844800,0.036000,0.076200> rotate<0,0.000000,0> translate<56.870600,-1.536000,23.289400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.870600,-1.536000,23.289400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.870600,-1.536000,21.668600>}
box{<0,0,-0.076200><1.620800,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.870600,-1.536000,21.668600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.870600,-1.536000,21.668600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.715400,-1.536000,21.668600>}
box{<0,0,-0.076200><2.844800,0.036000,0.076200> rotate<0,0.000000,0> translate<56.870600,-1.536000,21.668600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.770600,-1.536000,21.668600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.815400,-1.536000,21.668600>}
box{<0,0,-0.076200><1.044800,0.036000,0.076200> rotate<0,0.000000,0> translate<57.770600,-1.536000,21.668600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.865400,-1.536000,23.289400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.770600,-1.536000,23.289400>}
box{<0,0,-0.076200><0.094800,0.036000,0.076200> rotate<0,0.000000,0> translate<57.770600,-1.536000,23.289400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.815400,-1.536000,23.289400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.720600,-1.536000,23.289400>}
box{<0,0,-0.076200><0.094800,0.036000,0.076200> rotate<0,0.000000,0> translate<58.720600,-1.536000,23.289400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.965400,-1.536000,23.289400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.870600,-1.536000,23.289400>}
box{<0,0,-0.076200><0.094800,0.036000,0.076200> rotate<0,0.000000,0> translate<56.870600,-1.536000,23.289400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.715400,-1.536000,23.289400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.620600,-1.536000,23.289400>}
box{<0,0,-0.076200><0.094800,0.036000,0.076200> rotate<0,0.000000,0> translate<59.620600,-1.536000,23.289400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.620600,-1.536000,21.668600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.715400,-1.536000,21.668600>}
box{<0,0,-0.076200><0.094800,0.036000,0.076200> rotate<0,0.000000,0> translate<59.620600,-1.536000,21.668600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.870600,-1.536000,21.668600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.965400,-1.536000,21.668600>}
box{<0,0,-0.076200><0.094800,0.036000,0.076200> rotate<0,0.000000,0> translate<56.870600,-1.536000,21.668600> }
box{<-0.250000,0,-0.325000><0.250000,0.036000,0.325000> rotate<0,-0.000000,0> translate<57.343000,-1.536000,23.654000>}
box{<-0.250000,0,-0.325000><0.250000,0.036000,0.325000> rotate<0,-0.000000,0> translate<58.293000,-1.536000,23.654000>}
box{<-0.250000,0,-0.325000><0.250000,0.036000,0.325000> rotate<0,-0.000000,0> translate<59.243000,-1.536000,23.654000>}
box{<-0.250000,0,-0.325000><0.250000,0.036000,0.325000> rotate<0,-0.000000,0> translate<59.243000,-1.536000,21.304000>}
box{<-0.250000,0,-0.325000><0.250000,0.036000,0.325000> rotate<0,-0.000000,0> translate<57.343000,-1.536000,21.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.702000,-1.536000,28.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.702000,-1.536000,24.560000>}
box{<0,0,-0.076200><3.460000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.702000,-1.536000,24.560000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.454000,-1.536000,24.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.454000,-1.536000,28.020000>}
box{<0,0,-0.076200><3.460000,0.036000,0.076200> rotate<0,90.000000,0> translate<49.454000,-1.536000,28.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.702000,-1.536000,28.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.454000,-1.536000,28.020000>}
box{<0,0,-0.076200><6.248000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.454000,-1.536000,28.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.454000,-1.536000,24.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.702000,-1.536000,24.560000>}
box{<0,0,-0.076200><6.248000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.454000,-1.536000,24.560000> }
box{<-1.524000,0,-0.762000><1.524000,0.036000,0.762000> rotate<0,-180.000000,0> translate<52.578000,-1.536000,28.829000>}
box{<-0.381000,0,-0.762000><0.381000,0.036000,0.762000> rotate<0,-180.000000,0> translate<54.864000,-1.536000,23.749000>}
box{<-0.381000,0,-0.762000><0.381000,0.036000,0.762000> rotate<0,-180.000000,0> translate<50.292000,-1.536000,23.749000>}
box{<-0.381000,0,-0.762000><0.381000,0.036000,0.762000> rotate<0,-180.000000,0> translate<52.578000,-1.536000,23.749000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.463000,-1.536000,28.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.463000,-1.536000,24.560000>}
box{<0,0,-0.076200><3.460000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.463000,-1.536000,24.560000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.215000,-1.536000,24.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.215000,-1.536000,28.020000>}
box{<0,0,-0.076200><3.460000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.215000,-1.536000,28.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.463000,-1.536000,28.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.215000,-1.536000,28.020000>}
box{<0,0,-0.076200><6.248000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.215000,-1.536000,28.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.215000,-1.536000,24.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.463000,-1.536000,24.560000>}
box{<0,0,-0.076200><6.248000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.215000,-1.536000,24.560000> }
box{<-1.524000,0,-0.762000><1.524000,0.036000,0.762000> rotate<0,-180.000000,0> translate<45.339000,-1.536000,28.829000>}
box{<-0.381000,0,-0.762000><0.381000,0.036000,0.762000> rotate<0,-180.000000,0> translate<47.625000,-1.536000,23.749000>}
box{<-0.381000,0,-0.762000><0.381000,0.036000,0.762000> rotate<0,-180.000000,0> translate<43.053000,-1.536000,23.749000>}
box{<-0.381000,0,-0.762000><0.381000,0.036000,0.762000> rotate<0,-180.000000,0> translate<45.339000,-1.536000,23.749000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.875000,0.000000,0.518000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.775000,0.000000,0.518000>}
box{<0,0,-0.050800><0.900000,0.036000,0.050800> rotate<0,0.000000,0> translate<59.875000,0.000000,0.518000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.875000,0.000000,1.768000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<60.800000,0.000000,1.768000>}
box{<0,0,-0.050800><0.925000,0.036000,0.050800> rotate<0,0.000000,0> translate<59.875000,0.000000,1.768000> }
box{<-0.075000,0,-0.150000><0.075000,0.036000,0.150000> rotate<0,-90.000000,0> translate<60.175000,0.000000,0.543000>}
box{<-0.075000,0,-0.150000><0.075000,0.036000,0.150000> rotate<0,-90.000000,0> translate<60.175000,0.000000,1.743000>}
box{<-0.150000,0,-0.150000><0.150000,0.036000,0.150000> rotate<0,-90.000000,0> translate<60.175000,0.000000,1.143000>}
box{<-0.675000,0,-0.300000><0.675000,0.036000,0.300000> rotate<0,-90.000000,0> translate<59.575000,0.000000,1.143000>}
box{<-0.675000,0,-0.300000><0.675000,0.036000,0.300000> rotate<0,-90.000000,0> translate<61.075000,0.000000,1.143000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<55.430000,0.000000,0.518000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<56.330000,0.000000,0.518000>}
box{<0,0,-0.050800><0.900000,0.036000,0.050800> rotate<0,0.000000,0> translate<55.430000,0.000000,0.518000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<55.430000,0.000000,1.768000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<56.355000,0.000000,1.768000>}
box{<0,0,-0.050800><0.925000,0.036000,0.050800> rotate<0,0.000000,0> translate<55.430000,0.000000,1.768000> }
box{<-0.075000,0,-0.150000><0.075000,0.036000,0.150000> rotate<0,-90.000000,0> translate<55.730000,0.000000,0.543000>}
box{<-0.075000,0,-0.150000><0.075000,0.036000,0.150000> rotate<0,-90.000000,0> translate<55.730000,0.000000,1.743000>}
box{<-0.150000,0,-0.150000><0.150000,0.036000,0.150000> rotate<0,-90.000000,0> translate<55.730000,0.000000,1.143000>}
box{<-0.675000,0,-0.300000><0.675000,0.036000,0.300000> rotate<0,-90.000000,0> translate<55.130000,0.000000,1.143000>}
box{<-0.675000,0,-0.300000><0.675000,0.036000,0.300000> rotate<0,-90.000000,0> translate<56.630000,0.000000,1.143000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.858000,0.000000,0.518000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<51.758000,0.000000,0.518000>}
box{<0,0,-0.050800><0.900000,0.036000,0.050800> rotate<0,0.000000,0> translate<50.858000,0.000000,0.518000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.858000,0.000000,1.768000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<51.783000,0.000000,1.768000>}
box{<0,0,-0.050800><0.925000,0.036000,0.050800> rotate<0,0.000000,0> translate<50.858000,0.000000,1.768000> }
box{<-0.075000,0,-0.150000><0.075000,0.036000,0.150000> rotate<0,-90.000000,0> translate<51.158000,0.000000,0.543000>}
box{<-0.075000,0,-0.150000><0.075000,0.036000,0.150000> rotate<0,-90.000000,0> translate<51.158000,0.000000,1.743000>}
box{<-0.150000,0,-0.150000><0.150000,0.036000,0.150000> rotate<0,-90.000000,0> translate<51.158000,0.000000,1.143000>}
box{<-0.675000,0,-0.300000><0.675000,0.036000,0.300000> rotate<0,-90.000000,0> translate<50.558000,0.000000,1.143000>}
box{<-0.675000,0,-0.300000><0.675000,0.036000,0.300000> rotate<0,-90.000000,0> translate<52.058000,0.000000,1.143000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.424800,-1.536000,10.769600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.424800,-1.536000,5.740400>}
box{<0,0,-0.076200><5.029200,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.424800,-1.536000,5.740400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.259200,-1.536000,5.740400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.424800,-1.536000,5.740400>}
box{<0,0,-0.076200><4.165600,0.036000,0.076200> rotate<0,0.000000,0> translate<67.259200,-1.536000,5.740400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.259200,-1.536000,5.740400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.259200,-1.536000,10.769600>}
box{<0,0,-0.076200><5.029200,0.036000,0.076200> rotate<0,90.000000,0> translate<67.259200,-1.536000,10.769600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.424800,-1.536000,10.769600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.259200,-1.536000,10.769600>}
box{<0,0,-0.076200><4.165600,0.036000,0.076200> rotate<0,0.000000,0> translate<67.259200,-1.536000,10.769600> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.196200,-1.536000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.196200,-1.536000,5.969000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,-90.000000,0> translate<71.196200,-1.536000,5.969000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.487800,-1.536000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.196200,-1.536000,5.969000>}
box{<0,0,-0.025400><3.708400,0.036000,0.025400> rotate<0,0.000000,0> translate<67.487800,-1.536000,5.969000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.487800,-1.536000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.487800,-1.536000,10.541000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,90.000000,0> translate<67.487800,-1.536000,10.541000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.196200,-1.536000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.487800,-1.536000,10.541000>}
box{<0,0,-0.025400><3.708400,0.036000,0.025400> rotate<0,0.000000,0> translate<67.487800,-1.536000,10.541000> }
difference{
cylinder{<70.561200,0,9.880600><70.561200,0.036000,9.880600>0.533400 translate<0,-1.536000,0>}
cylinder{<70.561200,-0.1,9.880600><70.561200,0.135000,9.880600>0.381000 translate<0,-1.536000,0>}}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,6.350000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,6.985000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,7.620000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,8.255000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,8.890000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,9.525000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,10.160000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,10.160000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,9.525000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,8.890000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,8.255000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,7.620000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,6.985000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.395000,0.000000,6.056000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.395000,0.000000,6.581000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,90.000000,0> translate<34.395000,0.000000,6.581000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.395000,0.000000,6.581000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.395000,0.000000,19.581000>}
box{<0,0,-0.101600><13.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<34.395000,0.000000,19.581000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.395000,0.000000,19.581000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.395000,0.000000,20.106000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,90.000000,0> translate<34.395000,0.000000,20.106000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.395000,0.000000,20.106000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.395000,0.000000,20.106000>}
box{<0,0,-0.101600><4.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<30.395000,0.000000,20.106000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.395000,0.000000,20.106000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.395000,0.000000,19.956000>}
box{<0,0,-0.101600><0.150000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.395000,0.000000,19.956000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.395000,0.000000,19.956000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.395000,0.000000,6.206000>}
box{<0,0,-0.101600><13.750000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.395000,0.000000,6.206000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.395000,0.000000,6.206000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.395000,0.000000,6.056000>}
box{<0,0,-0.101600><0.150000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.395000,0.000000,6.056000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.395000,0.000000,6.056000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.395000,0.000000,6.056000>}
box{<0,0,-0.101600><4.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<30.395000,0.000000,6.056000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,6.081000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,6.581000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<31.395000,0.000000,6.581000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,6.581000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,6.831000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,90.000000,0> translate<31.395000,0.000000,6.831000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,6.831000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.020000,0.000000,6.831000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,0.000000,0> translate<31.395000,0.000000,6.831000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.020000,0.000000,6.831000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.020000,0.000000,19.331000>}
box{<0,0,-0.025400><12.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<32.020000,0.000000,19.331000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,19.331000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,19.581000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,90.000000,0> translate<31.395000,0.000000,19.581000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,19.581000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,20.081000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<31.395000,0.000000,20.081000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,19.331000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.020000,0.000000,19.331000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,0.000000,0> translate<31.395000,0.000000,19.331000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,6.081000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,6.581000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,6.581000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,6.581000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.395000,0.000000,6.581000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,6.581000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,19.581000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,20.081000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,20.081000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,19.581000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.395000,0.000000,19.581000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,19.581000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,6.581000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.770000,0.000000,6.581000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,0.000000,0> translate<30.770000,0.000000,6.581000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.770000,0.000000,6.581000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.770000,0.000000,19.581000>}
box{<0,0,-0.025400><13.000000,0.036000,0.025400> rotate<0,90.000000,0> translate<30.770000,0.000000,19.581000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.770000,0.000000,19.581000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<31.395000,0.000000,19.581000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,0.000000,0> translate<30.770000,0.000000,19.581000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.770000,0.000000,6.581000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.395000,0.000000,6.206000>}
box{<0,0,-0.025400><0.530330,0.036000,0.025400> rotate<0,-44.997030,0> translate<30.395000,0.000000,6.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.770000,0.000000,19.581000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.395000,0.000000,19.956000>}
box{<0,0,-0.025400><0.530330,0.036000,0.025400> rotate<0,44.997030,0> translate<30.395000,0.000000,19.956000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,7.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,7.206000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,7.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,7.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,7.706000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,7.706000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,7.706000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,7.706000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,7.706000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,8.456000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,8.456000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,8.456000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,8.456000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,8.956000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,8.956000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,8.956000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,8.956000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,8.956000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,9.706000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,9.706000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,9.706000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,9.706000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,10.206000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,10.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,10.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,10.206000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,10.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,10.956000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,10.956000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,10.956000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,10.956000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,11.456000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,11.456000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,11.456000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,11.456000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,11.456000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,12.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,12.206000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,12.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,12.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,12.706000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,12.706000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,12.706000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,12.706000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,12.706000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,13.456000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,13.456000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,13.456000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,13.456000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,13.956000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,13.956000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,13.956000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,13.956000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,13.956000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,14.706000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,14.706000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,14.706000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,14.706000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,15.206000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,15.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,15.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,15.206000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,15.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,15.956000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,15.956000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,15.956000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,15.956000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,16.456000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,16.456000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,16.456000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,16.456000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,16.456000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,17.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,17.206000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,17.206000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,17.206000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,17.706000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,17.706000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,17.706000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,17.706000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,17.706000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,18.456000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,18.456000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,18.456000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,18.456000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,18.956000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<33.770000,0.000000,18.956000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.770000,0.000000,18.956000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.270000,0.000000,18.956000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<33.770000,0.000000,18.956000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.770000,0.000000,5.956000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.770000,0.000000,4.081000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.770000,0.000000,4.081000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.770000,0.000000,4.081000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.770000,0.000000,4.081000>}
box{<0,0,-0.101600><3.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<30.770000,0.000000,4.081000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.770000,0.000000,4.081000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.770000,0.000000,5.956000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,90.000000,0> translate<33.770000,0.000000,5.956000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.770000,0.000000,20.206000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.770000,0.000000,22.081000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,90.000000,0> translate<33.770000,0.000000,22.081000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.770000,0.000000,22.081000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.770000,0.000000,22.081000>}
box{<0,0,-0.101600><3.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<30.770000,0.000000,22.081000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.770000,0.000000,22.081000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.770000,0.000000,20.206000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.770000,0.000000,20.206000> }
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<31.582500,0.000000,7.456000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<31.582500,0.000000,8.706000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<31.582500,0.000000,9.956000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<31.582500,0.000000,11.206000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<31.582500,0.000000,12.456000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<31.582500,0.000000,13.706000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<31.582500,0.000000,14.956000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<31.582500,0.000000,16.206000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<31.582500,0.000000,17.456000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<31.582500,0.000000,18.706000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.520000,0.000000,23.190000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.520000,0.000000,24.054000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.520000,0.000000,24.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.808000,0.000000,24.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.808000,0.000000,23.190000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<41.808000,0.000000,23.190000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-90.000000,0> translate<42.164000,0.000000,24.257000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-90.000000,0> translate<42.164000,0.000000,22.987000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.616000,-1.536000,10.947000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.752000,-1.536000,10.947000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.752000,-1.536000,10.947000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.752000,-1.536000,11.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.616000,-1.536000,11.659000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.752000,-1.536000,11.659000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<74.549000,-1.536000,11.303000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<75.819000,-1.536000,11.303000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.616000,-1.536000,12.979000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.752000,-1.536000,12.979000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.752000,-1.536000,12.979000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.752000,-1.536000,13.691000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.616000,-1.536000,13.691000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.752000,-1.536000,13.691000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<74.549000,-1.536000,13.335000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<75.819000,-1.536000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.541000,0.000000,25.832000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.541000,0.000000,24.968000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.541000,0.000000,24.968000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.253000,0.000000,24.968000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.253000,0.000000,25.832000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.253000,0.000000,25.832000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<64.897000,0.000000,24.765000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<64.897000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.616000,-1.536000,4.851000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.752000,-1.536000,4.851000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.752000,-1.536000,4.851000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.752000,-1.536000,5.563000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.616000,-1.536000,5.563000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.752000,-1.536000,5.563000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<74.549000,-1.536000,5.207000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<75.819000,-1.536000,5.207000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.616000,-1.536000,2.819000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.752000,-1.536000,2.819000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.752000,-1.536000,2.819000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.752000,-1.536000,3.531000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.616000,-1.536000,3.531000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.752000,-1.536000,3.531000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<74.549000,-1.536000,3.175000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<75.819000,-1.536000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.932000,-1.536000,15.011000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.068000,-1.536000,15.011000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.068000,-1.536000,15.011000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.068000,-1.536000,15.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.932000,-1.536000,15.723000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.068000,-1.536000,15.723000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<62.865000,-1.536000,15.367000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<64.135000,-1.536000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.068000,-1.536000,11.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.932000,-1.536000,11.659000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.068000,-1.536000,11.659000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.932000,-1.536000,10.947000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.068000,-1.536000,10.947000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.068000,-1.536000,10.947000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<64.135000,-1.536000,11.303000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<62.865000,-1.536000,11.303000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.068000,-1.536000,13.691000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.932000,-1.536000,13.691000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.068000,-1.536000,13.691000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.932000,-1.536000,12.979000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.068000,-1.536000,12.979000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.068000,-1.536000,12.979000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<64.135000,-1.536000,13.335000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<62.865000,-1.536000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.123000,-1.536000,14.249000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.259000,-1.536000,14.249000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.259000,-1.536000,14.249000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.259000,-1.536000,14.961000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.123000,-1.536000,14.961000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.259000,-1.536000,14.961000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<67.056000,-1.536000,14.605000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<68.326000,-1.536000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.171000,-1.536000,15.138000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.307000,-1.536000,15.138000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.307000,-1.536000,15.138000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.307000,-1.536000,15.850000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.171000,-1.536000,15.850000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.307000,-1.536000,15.850000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<70.104000,-1.536000,15.494000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<71.374000,-1.536000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.378000,-1.536000,24.663000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.514000,-1.536000,24.663000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.514000,-1.536000,24.663000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.514000,-1.536000,25.375000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.378000,-1.536000,25.375000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.514000,-1.536000,25.375000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<75.311000,-1.536000,25.019000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<76.581000,-1.536000,25.019000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.698000,-1.536000,18.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.698000,-1.536000,18.110000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.698000,-1.536000,18.110000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.986000,-1.536000,18.110000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.986000,-1.536000,18.974000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<68.986000,-1.536000,18.974000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<69.342000,-1.536000,17.907000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<69.342000,-1.536000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.378000,-1.536000,26.695000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.514000,-1.536000,26.695000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.514000,-1.536000,26.695000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.514000,-1.536000,27.407000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.378000,-1.536000,27.407000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<75.514000,-1.536000,27.407000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<75.311000,-1.536000,27.051000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<76.581000,-1.536000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.593000,-1.536000,26.137000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.457000,-1.536000,26.137000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.593000,-1.536000,26.137000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.457000,-1.536000,25.425000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.593000,-1.536000,25.425000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<72.593000,-1.536000,25.425000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<73.660000,-1.536000,25.781000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<72.390000,-1.536000,25.781000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.066000,-1.536000,21.031000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.066000,-1.536000,21.895000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.066000,-1.536000,21.895000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.778000,-1.536000,21.895000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.778000,-1.536000,21.031000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<74.778000,-1.536000,21.031000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-90.000000,0> translate<74.422000,-1.536000,22.098000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-90.000000,0> translate<74.422000,-1.536000,20.828000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.603000,-1.536000,18.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.603000,-1.536000,18.110000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.603000,-1.536000,18.110000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.891000,-1.536000,18.110000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.891000,-1.536000,18.974000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.891000,-1.536000,18.974000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<71.247000,-1.536000,17.907000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<71.247000,-1.536000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.971000,-1.536000,17.983000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.971000,-1.536000,18.847000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<75.971000,-1.536000,18.847000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.683000,-1.536000,18.847000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.683000,-1.536000,17.983000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.683000,-1.536000,17.983000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-90.000000,0> translate<76.327000,-1.536000,19.050000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-90.000000,0> translate<76.327000,-1.536000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.355000,-1.536000,19.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.219000,-1.536000,19.025000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.355000,-1.536000,19.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.219000,-1.536000,18.313000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.355000,-1.536000,18.313000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.355000,-1.536000,18.313000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<74.422000,-1.536000,18.669000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<73.152000,-1.536000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.774000,-1.536000,26.060000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.910000,-1.536000,26.060000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.910000,-1.536000,26.060000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.910000,-1.536000,26.772000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.774000,-1.536000,26.772000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.910000,-1.536000,26.772000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<68.707000,-1.536000,26.416000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<69.977000,-1.536000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.793000,-1.536000,18.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.793000,-1.536000,18.110000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.793000,-1.536000,18.110000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.081000,-1.536000,18.110000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.081000,-1.536000,18.974000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.081000,-1.536000,18.974000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<67.437000,-1.536000,17.907000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<67.437000,-1.536000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.253000,-1.536000,22.657000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.253000,-1.536000,21.793000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.253000,-1.536000,21.793000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.541000,-1.536000,21.793000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.541000,-1.536000,22.657000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<64.541000,-1.536000,22.657000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<64.897000,-1.536000,21.590000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<64.897000,-1.536000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.329000,-1.536000,19.329000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.465000,-1.536000,19.329000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.465000,-1.536000,19.329000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.465000,-1.536000,20.041000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.329000,-1.536000,20.041000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.465000,-1.536000,20.041000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<64.262000,-1.536000,19.685000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<65.532000,-1.536000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.585000,-1.536000,26.873000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.585000,-1.536000,27.737000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.585000,-1.536000,27.737000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.297000,-1.536000,27.737000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.297000,-1.536000,26.873000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.297000,-1.536000,26.873000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-90.000000,0> translate<35.941000,-1.536000,27.940000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-90.000000,0> translate<35.941000,-1.536000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.329000,-1.536000,27.737000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.329000,-1.536000,26.873000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.329000,-1.536000,26.873000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.617000,-1.536000,26.873000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.617000,-1.536000,27.737000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.617000,-1.536000,27.737000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<37.973000,-1.536000,26.670000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<37.973000,-1.536000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.126000,0.000000,7.163000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.126000,0.000000,6.299000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<46.126000,0.000000,6.299000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.838000,0.000000,6.299000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.838000,0.000000,7.163000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.838000,0.000000,7.163000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<46.482000,0.000000,6.096000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<46.482000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.454000,0.000000,6.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.590000,0.000000,6.579000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.590000,0.000000,6.579000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.590000,0.000000,5.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.454000,0.000000,5.867000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.590000,0.000000,5.867000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<48.387000,0.000000,6.223000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<49.657000,0.000000,6.223000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.153000,0.000000,4.547000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.289000,0.000000,4.547000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.289000,0.000000,4.547000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.289000,0.000000,3.835000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.153000,0.000000,3.835000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.289000,0.000000,3.835000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<53.086000,0.000000,4.191000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<54.356000,0.000000,4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.985000,0.000000,8.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.985000,0.000000,7.950000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.985000,0.000000,7.950000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.697000,0.000000,7.950000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.697000,0.000000,8.814000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<61.697000,0.000000,8.814000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<61.341000,0.000000,7.747000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<61.341000,0.000000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.985000,0.000000,5.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.985000,0.000000,4.902000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.985000,0.000000,4.902000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.697000,0.000000,4.902000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.697000,0.000000,5.766000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<61.697000,0.000000,5.766000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<61.341000,0.000000,4.699000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<61.341000,0.000000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.414000,0.000000,9.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.414000,0.000000,8.331000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.414000,0.000000,8.331000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.126000,0.000000,8.331000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.126000,0.000000,9.195000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.126000,0.000000,9.195000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<64.770000,0.000000,8.128000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<64.770000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.414000,0.000000,5.893000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.414000,0.000000,5.029000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.414000,0.000000,5.029000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.126000,0.000000,5.029000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.126000,0.000000,5.893000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.126000,0.000000,5.893000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<64.770000,0.000000,4.826000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<64.770000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.901000,0.000000,2.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.037000,0.000000,2.134000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.037000,0.000000,2.134000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.037000,0.000000,1.422000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.901000,0.000000,1.422000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.037000,0.000000,1.422000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<68.834000,0.000000,1.778000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<70.104000,0.000000,1.778000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.853000,0.000000,2.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.989000,0.000000,2.134000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.989000,0.000000,2.134000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.989000,0.000000,1.422000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.853000,0.000000,1.422000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.989000,0.000000,1.422000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<65.786000,0.000000,1.778000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<67.056000,0.000000,1.778000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.046000,0.000000,7.417000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.046000,0.000000,6.553000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<41.046000,0.000000,6.553000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.758000,0.000000,6.553000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.758000,0.000000,7.417000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.758000,0.000000,7.417000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<41.402000,0.000000,6.350000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<41.402000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.552000,0.000000,23.190000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.552000,0.000000,24.054000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.552000,0.000000,24.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.840000,0.000000,24.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.840000,0.000000,23.190000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.840000,0.000000,23.190000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-90.000000,0> translate<44.196000,0.000000,24.257000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-90.000000,0> translate<44.196000,0.000000,22.987000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.395000,0.000000,7.417000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.395000,0.000000,6.553000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<39.395000,0.000000,6.553000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.107000,0.000000,6.553000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.107000,0.000000,7.417000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.107000,0.000000,7.417000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<39.751000,0.000000,6.350000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<39.751000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.757000,0.000000,0.483000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.893000,0.000000,0.483000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.893000,0.000000,0.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.893000,0.000000,-0.229000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.757000,0.000000,-0.229000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.893000,0.000000,-0.229000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<59.690000,0.000000,0.127000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<60.960000,0.000000,0.127000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.312000,0.000000,0.483000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.448000,0.000000,0.483000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.448000,0.000000,0.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.448000,0.000000,-0.229000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.312000,0.000000,-0.229000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.448000,0.000000,-0.229000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<55.245000,0.000000,0.127000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<56.515000,0.000000,0.127000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.740000,0.000000,0.483000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.876000,0.000000,0.483000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.876000,0.000000,0.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.876000,0.000000,-0.229000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.740000,0.000000,-0.229000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.876000,0.000000,-0.229000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<50.673000,0.000000,0.127000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<51.943000,0.000000,0.127000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,28.067000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,26.797000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<74.803000,0.000000,26.797000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,26.670000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,-90.000000,0> translate<74.803000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,25.908000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,25.400000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,-90.000000,0> translate<74.803000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,24.638000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,24.130000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,-90.000000,0> translate<74.803000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,23.368000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,22.860000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,-90.000000,0> translate<74.803000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,22.098000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,21.971000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,-90.000000,0> translate<74.803000,0.000000,21.971000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,21.971000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,20.701000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<74.803000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.533000,0.000000,20.701000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<73.533000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.533000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.406000,0.000000,20.701000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<73.406000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.644000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.136000,0.000000,20.701000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<72.136000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<71.374000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<70.866000,0.000000,20.701000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<70.866000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<70.104000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.596000,0.000000,20.701000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<69.596000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.834000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.707000,0.000000,20.701000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<68.707000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.707000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,20.701000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.437000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,21.971000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.437000,0.000000,21.971000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,21.971000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,22.098000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.437000,0.000000,22.098000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,23.368000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.437000,0.000000,23.368000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,24.638000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.437000,0.000000,24.638000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,25.908000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.437000,0.000000,25.908000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,26.797000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.437000,0.000000,26.797000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,28.067000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<67.437000,0.000000,28.067000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.437000,0.000000,28.067000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.707000,0.000000,28.067000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.437000,0.000000,28.067000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.707000,0.000000,28.067000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<68.834000,0.000000,28.067000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<68.707000,0.000000,28.067000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<69.596000,0.000000,28.067000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<70.104000,0.000000,28.067000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<69.596000,0.000000,28.067000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<70.866000,0.000000,28.067000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<71.374000,0.000000,28.067000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<70.866000,0.000000,28.067000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.136000,0.000000,28.067000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.644000,0.000000,28.067000>}
box{<0,0,-0.063500><0.508000,0.036000,0.063500> rotate<0,0.000000,0> translate<72.136000,0.000000,28.067000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.406000,0.000000,28.067000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.533000,0.000000,28.067000>}
box{<0,0,-0.063500><0.127000,0.036000,0.063500> rotate<0,0.000000,0> translate<73.406000,0.000000,28.067000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.533000,0.000000,28.067000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<74.803000,0.000000,28.067000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,0.000000,0> translate<73.533000,0.000000,28.067000> }
object{ARC(0.381000,0.127000,90.000000,270.000000,0.036000) translate<74.803000,0.000000,22.479000>}
object{ARC(0.381000,0.127000,90.000000,270.000000,0.036000) translate<74.803000,0.000000,23.749000>}
object{ARC(0.381000,0.127000,90.000000,270.000000,0.036000) translate<74.803000,0.000000,25.019000>}
object{ARC(0.381000,0.127000,90.000000,270.000000,0.036000) translate<74.803000,0.000000,26.289000>}
object{ARC(0.381000,0.127000,180.000000,360.000000,0.036000) translate<73.025000,0.000000,28.067000>}
object{ARC(0.381000,0.127000,180.000000,360.000000,0.036000) translate<71.755000,0.000000,28.067000>}
object{ARC(0.381000,0.127000,180.000000,360.000000,0.036000) translate<70.485000,0.000000,28.067000>}
object{ARC(0.381000,0.127000,180.000000,360.000000,0.036000) translate<69.215000,0.000000,28.067000>}
object{ARC(0.381000,0.127000,270.000000,450.000000,0.036000) translate<67.437000,0.000000,26.289000>}
object{ARC(0.381000,0.127000,270.000000,450.000000,0.036000) translate<67.437000,0.000000,25.019000>}
object{ARC(0.381000,0.127000,270.000000,450.000000,0.036000) translate<67.437000,0.000000,23.749000>}
object{ARC(0.381000,0.127000,270.000000,450.000000,0.036000) translate<67.437000,0.000000,22.479000>}
object{ARC(0.381000,0.127000,0.000000,180.000000,0.036000) translate<69.215000,0.000000,20.701000>}
object{ARC(0.381000,0.127000,0.000000,180.000000,0.036000) translate<70.485000,0.000000,20.701000>}
object{ARC(0.381000,0.127000,0.000000,180.000000,0.036000) translate<71.755000,0.000000,20.701000>}
object{ARC(0.381000,0.127000,0.000000,180.000000,0.036000) translate<73.025000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<46.465100,0.000000,15.562000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<50.000600,0.000000,12.026500>}
box{<0,0,-0.063500><4.999952,0.036000,0.063500> rotate<0,44.997030,0> translate<46.465100,0.000000,15.562000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<50.000600,0.000000,12.026500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.737800,0.000000,9.763700>}
box{<0,0,-0.063500><3.200082,0.036000,0.063500> rotate<0,-44.997030,0> translate<47.737800,0.000000,9.763700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.737800,0.000000,9.763700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<44.202300,0.000000,13.299200>}
box{<0,0,-0.063500><4.999952,0.036000,0.063500> rotate<0,44.997030,0> translate<44.202300,0.000000,13.299200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<44.202300,0.000000,13.299200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<46.465100,0.000000,15.562000>}
box{<0,0,-0.063500><3.200082,0.036000,0.063500> rotate<0,-44.997030,0> translate<44.202300,0.000000,13.299200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.424800,-1.536000,25.247600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.424800,-1.536000,20.218400>}
box{<0,0,-0.076200><5.029200,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.424800,-1.536000,20.218400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.259200,-1.536000,20.218400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.424800,-1.536000,20.218400>}
box{<0,0,-0.076200><4.165600,0.036000,0.076200> rotate<0,0.000000,0> translate<67.259200,-1.536000,20.218400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.259200,-1.536000,20.218400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.259200,-1.536000,25.247600>}
box{<0,0,-0.076200><5.029200,0.036000,0.076200> rotate<0,90.000000,0> translate<67.259200,-1.536000,25.247600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.424800,-1.536000,25.247600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.259200,-1.536000,25.247600>}
box{<0,0,-0.076200><4.165600,0.036000,0.076200> rotate<0,0.000000,0> translate<67.259200,-1.536000,25.247600> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.196200,-1.536000,25.019000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.196200,-1.536000,20.447000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,-90.000000,0> translate<71.196200,-1.536000,20.447000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.487800,-1.536000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.196200,-1.536000,20.447000>}
box{<0,0,-0.025400><3.708400,0.036000,0.025400> rotate<0,0.000000,0> translate<67.487800,-1.536000,20.447000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.487800,-1.536000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.487800,-1.536000,25.019000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,90.000000,0> translate<67.487800,-1.536000,25.019000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<71.196200,-1.536000,25.019000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<67.487800,-1.536000,25.019000>}
box{<0,0,-0.025400><3.708400,0.036000,0.025400> rotate<0,0.000000,0> translate<67.487800,-1.536000,25.019000> }
difference{
cylinder{<70.561200,0,24.358600><70.561200,0.036000,24.358600>0.533400 translate<0,-1.536000,0>}
cylinder{<70.561200,-0.1,24.358600><70.561200,0.135000,24.358600>0.381000 translate<0,-1.536000,0>}}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,20.828000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,21.463000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,22.098000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,22.733000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,23.368000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,24.003000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<66.814700,-1.536000,24.638000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,24.638000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,24.003000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,23.368000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,22.733000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,22.098000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,21.463000>}
box{<-0.101600,0,-0.419100><0.101600,0.036000,0.419100> rotate<0,-270.000000,0> translate<71.843900,-1.536000,20.828000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<63.119000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<63.119000,0.000000,27.051000>}
box{<0,0,-0.012700><3.048000,0.036000,0.012700> rotate<0,-90.000000,0> translate<63.119000,0.000000,27.051000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<63.119000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<60.071000,0.000000,27.051000>}
box{<0,0,-0.012700><3.048000,0.036000,0.012700> rotate<0,0.000000,0> translate<60.071000,0.000000,27.051000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<60.071000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<60.071000,0.000000,30.099000>}
box{<0,0,-0.012700><3.048000,0.036000,0.012700> rotate<0,90.000000,0> translate<60.071000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<60.071000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<63.119000,0.000000,30.099000>}
box{<0,0,-0.012700><3.048000,0.036000,0.012700> rotate<0,0.000000,0> translate<60.071000,0.000000,30.099000> }
difference{
cylinder{<60.325000,0,29.845000><60.325000,0.036000,29.845000>0.156300 translate<0,0.000000,0>}
cylinder{<60.325000,-0.1,29.845000><60.325000,0.135000,29.845000>0.130900 translate<0,0.000000,0>}}
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<61.373000,0.000000,15.208000>}
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<65.373000,0.000000,15.208000>}
box{<0,0,-0.050000><4.000000,0.036000,0.050000> rotate<0,0.000000,0> translate<61.373000,0.000000,15.208000> }
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<65.373000,0.000000,15.208000>}
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<65.373000,0.000000,11.208000>}
box{<0,0,-0.050000><4.000000,0.036000,0.050000> rotate<0,-90.000000,0> translate<65.373000,0.000000,11.208000> }
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<65.373000,0.000000,11.208000>}
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<61.373000,0.000000,11.208000>}
box{<0,0,-0.050000><4.000000,0.036000,0.050000> rotate<0,0.000000,0> translate<61.373000,0.000000,11.208000> }
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<61.373000,0.000000,11.208000>}
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<61.373000,0.000000,15.208000>}
box{<0,0,-0.050000><4.000000,0.036000,0.050000> rotate<0,90.000000,0> translate<61.373000,0.000000,15.208000> }
difference{
cylinder{<62.103000,0,14.478000><62.103000,0.036000,14.478000>0.192300 translate<0,0.000000,0>}
cylinder{<62.103000,-0.1,14.478000><62.103000,0.135000,14.478000>0.166900 translate<0,0.000000,0>}}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.241000,-1.536000,22.081000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.241000,-1.536000,4.081000>}
box{<0,0,-0.063500><18.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<33.241000,-1.536000,4.081000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.241000,-1.536000,4.081000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.641000,-1.536000,4.081000>}
box{<0,0,-0.063500><5.400000,0.036000,0.063500> rotate<0,0.000000,0> translate<33.241000,-1.536000,4.081000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.641000,-1.536000,4.081000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.641000,-1.536000,22.081000>}
box{<0,0,-0.063500><18.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<38.641000,-1.536000,22.081000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.641000,-1.536000,22.081000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.241000,-1.536000,22.081000>}
box{<0,0,-0.063500><5.400000,0.036000,0.063500> rotate<0,0.000000,0> translate<33.241000,-1.536000,22.081000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.333000,0.000000,5.458000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.633000,0.000000,5.458000>}
box{<0,0,-0.101600><4.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<52.333000,0.000000,5.458000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.633000,0.000000,5.458000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.633000,0.000000,8.258000>}
box{<0,0,-0.101600><2.800000,0.036000,0.101600> rotate<0,90.000000,0> translate<56.633000,0.000000,8.258000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.633000,0.000000,8.258000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.333000,0.000000,8.258000>}
box{<0,0,-0.101600><4.300000,0.036000,0.101600> rotate<0,0.000000,0> translate<52.333000,0.000000,8.258000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.333000,0.000000,8.258000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.333000,0.000000,5.458000>}
box{<0,0,-0.101600><2.800000,0.036000,0.101600> rotate<0,-90.000000,0> translate<52.333000,0.000000,5.458000> }
difference{
cylinder{<52.858000,0,7.508000><52.858000,0.036000,7.508000>0.325000 translate<0,0.000000,0>}
cylinder{<52.858000,-0.1,7.508000><52.858000,0.135000,7.508000>0.325000 translate<0,0.000000,0>}}
box{<-0.125000,0,-0.500000><0.125000,0.036000,0.500000> rotate<0,-270.000000,0> translate<51.783000,0.000000,7.833000>}
box{<-0.125000,0,-0.500000><0.125000,0.036000,0.500000> rotate<0,-270.000000,0> translate<51.783000,0.000000,7.183000>}
box{<-0.125000,0,-0.500000><0.125000,0.036000,0.500000> rotate<0,-270.000000,0> translate<51.783000,0.000000,6.533000>}
box{<-0.125000,0,-0.500000><0.125000,0.036000,0.500000> rotate<0,-270.000000,0> translate<51.783000,0.000000,5.883000>}
box{<-0.125000,0,-0.500000><0.125000,0.036000,0.500000> rotate<0,-270.000000,0> translate<57.183000,0.000000,5.883000>}
box{<-0.125000,0,-0.500000><0.125000,0.036000,0.500000> rotate<0,-270.000000,0> translate<57.183000,0.000000,6.533000>}
box{<-0.125000,0,-0.500000><0.125000,0.036000,0.500000> rotate<0,-270.000000,0> translate<57.183000,0.000000,7.183000>}
box{<-0.125000,0,-0.500000><0.125000,0.036000,0.500000> rotate<0,-270.000000,0> translate<57.183000,0.000000,7.833000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.131000,0.000000,27.454000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.656000,0.000000,27.454000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.131000,0.000000,27.454000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.656000,0.000000,27.454000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.656000,0.000000,27.454000>}
box{<0,0,-0.101600><8.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.656000,0.000000,27.454000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.656000,0.000000,27.454000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.181000,0.000000,27.454000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.656000,0.000000,27.454000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.156000,0.000000,30.454000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,0.000000,30.454000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.156000,0.000000,30.454000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,0.000000,30.454000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,0.000000,30.454000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.656000,0.000000,30.454000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,0.000000,30.454000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,0.000000,29.829000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,-90.000000,0> translate<37.906000,0.000000,29.829000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,0.000000,29.829000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,0.000000,29.829000>}
box{<0,0,-0.025400><7.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.906000,0.000000,29.829000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,0.000000,30.454000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,0.000000,30.454000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<45.406000,0.000000,30.454000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,0.000000,30.454000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<46.156000,0.000000,30.454000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<45.656000,0.000000,30.454000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,0.000000,30.454000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,0.000000,29.829000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,-90.000000,0> translate<45.406000,0.000000,29.829000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.156000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.156000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,0.000000,27.454000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,-90.000000,0> translate<37.656000,0.000000,27.454000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<46.156000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<45.656000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,0.000000,27.454000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,-90.000000,0> translate<45.656000,0.000000,27.454000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.281000,0.000000,27.579000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.281000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<38.281000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.281000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.781000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<38.281000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.781000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.781000,0.000000,27.579000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<38.781000,0.000000,27.579000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<39.531000,0.000000,27.579000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<39.531000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<39.531000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<39.531000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.031000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<39.531000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.031000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.031000,0.000000,27.579000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<40.031000,0.000000,27.579000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.781000,0.000000,27.579000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.781000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<40.781000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.781000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.281000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<40.781000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.281000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.281000,0.000000,27.579000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<41.281000,0.000000,27.579000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.031000,0.000000,27.579000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.031000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<42.031000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.031000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.531000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<42.031000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.531000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.531000,0.000000,27.579000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<42.531000,0.000000,27.579000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.281000,0.000000,27.579000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.281000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<43.281000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.281000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.781000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<43.281000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.781000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.781000,0.000000,27.579000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<43.781000,0.000000,27.579000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.531000,0.000000,27.579000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.531000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<44.531000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.531000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.031000,0.000000,28.079000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<44.531000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.031000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.031000,0.000000,27.579000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<45.031000,0.000000,27.579000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.156000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.031000,0.000000,28.079000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,0.000000,0> translate<35.156000,0.000000,28.079000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.281000,0.000000,28.079000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.156000,0.000000,28.079000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.281000,0.000000,28.079000> }
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<38.531000,0.000000,30.266500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<39.781000,0.000000,30.266500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<41.031000,0.000000,30.266500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<42.281000,0.000000,30.266500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<43.531000,0.000000,30.266500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-0.000000,0> translate<44.781000,0.000000,30.266500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.181000,0.000000,3.026000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.656000,0.000000,3.026000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,0.000000,0> translate<45.656000,0.000000,3.026000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<45.656000,0.000000,3.026000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.656000,0.000000,3.026000>}
box{<0,0,-0.101600><8.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.656000,0.000000,3.026000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.656000,0.000000,3.026000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.131000,0.000000,3.026000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.131000,0.000000,3.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<46.156000,0.000000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,0.000000,0.026000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<45.656000,0.000000,0.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,0.000000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,0.000000,0.026000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<45.406000,0.000000,0.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,0.000000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,0.000000,0.651000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<45.406000,0.000000,0.651000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.406000,0.000000,0.651000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,0.000000,0.651000>}
box{<0,0,-0.025400><7.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.906000,0.000000,0.651000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,0.000000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,0.000000,0.026000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.656000,0.000000,0.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,0.000000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.156000,0.000000,0.026000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.156000,0.000000,0.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,0.000000,0.026000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.906000,0.000000,0.651000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<37.906000,0.000000,0.651000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<46.156000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<45.656000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.656000,0.000000,3.026000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<45.656000,0.000000,3.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.156000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<37.156000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<37.656000,0.000000,3.026000>}
box{<0,0,-0.025400><0.625000,0.036000,0.025400> rotate<0,90.000000,0> translate<37.656000,0.000000,3.026000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.031000,0.000000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.031000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<45.031000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.031000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.531000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<44.531000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.531000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<44.531000,0.000000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<44.531000,0.000000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.781000,0.000000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.781000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<43.781000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.781000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.281000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<43.281000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.281000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<43.281000,0.000000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<43.281000,0.000000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.531000,0.000000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.531000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<42.531000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.531000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.031000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<42.031000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.031000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<42.031000,0.000000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<42.031000,0.000000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.281000,0.000000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.281000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<41.281000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.281000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.781000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<40.781000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.781000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.781000,0.000000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<40.781000,0.000000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.031000,0.000000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.031000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<40.031000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<40.031000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<39.531000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<39.531000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<39.531000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<39.531000,0.000000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<39.531000,0.000000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.781000,0.000000,2.901000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.781000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,-90.000000,0> translate<38.781000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.781000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.281000,0.000000,2.401000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,0.000000,0> translate<38.281000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.281000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.281000,0.000000,2.901000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<38.281000,0.000000,2.901000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.156000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.281000,0.000000,2.401000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.281000,0.000000,2.401000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.031000,0.000000,2.401000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.156000,0.000000,2.401000>}
box{<0,0,-0.101600><1.875000,0.036000,0.101600> rotate<0,0.000000,0> translate<35.156000,0.000000,2.401000> }
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-180.000000,0> translate<44.781000,0.000000,0.213500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-180.000000,0> translate<43.531000,0.000000,0.213500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-180.000000,0> translate<42.281000,0.000000,0.213500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-180.000000,0> translate<41.031000,0.000000,0.213500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-180.000000,0> translate<39.781000,0.000000,0.213500>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-180.000000,0> translate<38.531000,0.000000,0.213500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.778000,0.000000,22.486000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.778000,0.000000,23.011000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,90.000000,0> translate<35.778000,0.000000,23.011000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.778000,0.000000,26.011000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.778000,0.000000,26.536000>}
box{<0,0,-0.101600><0.525000,0.036000,0.101600> rotate<0,90.000000,0> translate<35.778000,0.000000,26.536000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.778000,0.000000,26.536000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.403000,0.000000,26.536000>}
box{<0,0,-0.101600><5.375000,0.036000,0.101600> rotate<0,0.000000,0> translate<30.403000,0.000000,26.536000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.403000,0.000000,26.536000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.403000,0.000000,26.386000>}
box{<0,0,-0.101600><0.150000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.403000,0.000000,26.386000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.403000,0.000000,26.386000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.403000,0.000000,22.636000>}
box{<0,0,-0.101600><3.750000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.403000,0.000000,22.636000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.403000,0.000000,22.636000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.403000,0.000000,22.486000>}
box{<0,0,-0.101600><0.150000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.403000,0.000000,22.486000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.403000,0.000000,22.486000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.778000,0.000000,22.486000>}
box{<0,0,-0.101600><5.375000,0.036000,0.101600> rotate<0,0.000000,0> translate<30.403000,0.000000,22.486000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,22.511000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,23.011000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<32.028000,0.000000,23.011000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,23.011000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,23.261000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,90.000000,0> translate<32.028000,0.000000,23.261000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,23.261000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.903000,0.000000,23.261000>}
box{<0,0,-0.025400><0.875000,0.036000,0.025400> rotate<0,0.000000,0> translate<32.028000,0.000000,23.261000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.903000,0.000000,23.261000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.903000,0.000000,25.761000>}
box{<0,0,-0.025400><2.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<32.903000,0.000000,25.761000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,25.761000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,26.011000>}
box{<0,0,-0.025400><0.250000,0.036000,0.025400> rotate<0,90.000000,0> translate<32.028000,0.000000,26.011000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,26.011000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,26.511000>}
box{<0,0,-0.025400><0.500000,0.036000,0.025400> rotate<0,90.000000,0> translate<32.028000,0.000000,26.511000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,25.761000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.903000,0.000000,25.761000>}
box{<0,0,-0.025400><0.875000,0.036000,0.025400> rotate<0,0.000000,0> translate<32.028000,0.000000,25.761000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.528000,0.000000,23.011000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.528000,0.000000,26.011000>}
box{<0,0,-0.101600><3.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<34.528000,0.000000,26.011000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.028000,0.000000,23.636000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.153000,0.000000,23.511000>}
box{<0,0,-0.101600><0.176777,0.036000,0.101600> rotate<0,44.997030,0> translate<35.028000,0.000000,23.636000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.028000,0.000000,24.886000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.153000,0.000000,24.761000>}
box{<0,0,-0.101600><0.176777,0.036000,0.101600> rotate<0,44.997030,0> translate<35.028000,0.000000,24.886000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.153000,0.000000,24.761000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.153000,0.000000,24.261000>}
box{<0,0,-0.101600><0.500000,0.036000,0.101600> rotate<0,-90.000000,0> translate<35.153000,0.000000,24.261000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.028000,0.000000,24.136000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.153000,0.000000,24.261000>}
box{<0,0,-0.101600><0.176777,0.036000,0.101600> rotate<0,-44.997030,0> translate<35.028000,0.000000,24.136000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.153000,0.000000,26.011000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.153000,0.000000,25.511000>}
box{<0,0,-0.101600><0.500000,0.036000,0.101600> rotate<0,-90.000000,0> translate<35.153000,0.000000,25.511000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.028000,0.000000,25.386000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.153000,0.000000,25.511000>}
box{<0,0,-0.101600><0.176777,0.036000,0.101600> rotate<0,-44.997030,0> translate<35.028000,0.000000,25.386000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.153000,0.000000,23.511000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.153000,0.000000,23.011000>}
box{<0,0,-0.101600><0.500000,0.036000,0.101600> rotate<0,-90.000000,0> translate<35.153000,0.000000,23.011000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.528000,0.000000,22.511000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.528000,0.000000,23.011000>}
box{<0,0,-0.101600><0.500000,0.036000,0.101600> rotate<0,90.000000,0> translate<34.528000,0.000000,23.011000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.528000,0.000000,23.011000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.778000,0.000000,23.011000>}
box{<0,0,-0.101600><1.250000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.528000,0.000000,23.011000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.528000,0.000000,26.011000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.528000,0.000000,26.511000>}
box{<0,0,-0.101600><0.500000,0.036000,0.101600> rotate<0,90.000000,0> translate<34.528000,0.000000,26.511000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<34.528000,0.000000,26.011000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.778000,0.000000,26.011000>}
box{<0,0,-0.101600><1.250000,0.036000,0.101600> rotate<0,0.000000,0> translate<34.528000,0.000000,26.011000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,23.011000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.778000,0.000000,23.011000>}
box{<0,0,-0.025400><1.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<30.778000,0.000000,23.011000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.778000,0.000000,23.011000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.778000,0.000000,26.011000>}
box{<0,0,-0.025400><3.000000,0.036000,0.025400> rotate<0,90.000000,0> translate<30.778000,0.000000,26.011000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.778000,0.000000,26.011000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<32.028000,0.000000,26.011000>}
box{<0,0,-0.025400><1.250000,0.036000,0.025400> rotate<0,0.000000,0> translate<30.778000,0.000000,26.011000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.778000,0.000000,23.011000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.403000,0.000000,22.636000>}
box{<0,0,-0.025400><0.530330,0.036000,0.025400> rotate<0,-44.997030,0> translate<30.403000,0.000000,22.636000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.778000,0.000000,26.011000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<30.403000,0.000000,26.386000>}
box{<0,0,-0.025400><0.530330,0.036000,0.025400> rotate<0,44.997030,0> translate<30.403000,0.000000,26.386000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.028000,0.000000,23.761000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.528000,0.000000,23.886000>}
box{<0,0,-0.101600><0.515388,0.036000,0.101600> rotate<0,14.035317,0> translate<31.528000,0.000000,23.886000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.528000,0.000000,23.886000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.028000,0.000000,24.011000>}
box{<0,0,-0.101600><0.515388,0.036000,0.101600> rotate<0,-14.035317,0> translate<31.528000,0.000000,23.886000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.028000,0.000000,25.011000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.528000,0.000000,25.136000>}
box{<0,0,-0.101600><0.515388,0.036000,0.101600> rotate<0,14.035317,0> translate<31.528000,0.000000,25.136000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.528000,0.000000,25.136000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.028000,0.000000,25.261000>}
box{<0,0,-0.101600><0.515388,0.036000,0.101600> rotate<0,-14.035317,0> translate<31.528000,0.000000,25.136000> }
box{<-0.250000,0,-0.250000><0.250000,0.036000,0.250000> rotate<0,-90.000000,0> translate<34.778000,0.000000,23.886000>}
box{<-0.250000,0,-0.250000><0.250000,0.036000,0.250000> rotate<0,-90.000000,0> translate<34.778000,0.000000,25.136000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<32.465500,0.000000,23.886000>}
box{<-0.250000,0,-0.437500><0.250000,0.036000,0.437500> rotate<0,-90.000000,0> translate<32.465500,0.000000,25.136000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<65.786000,0.000000,15.811500>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<68.072000,0.000000,15.811500>}
box{<0,0,-0.012700><2.286000,0.036000,0.012700> rotate<0,0.000000,0> translate<65.786000,0.000000,15.811500> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<68.072000,0.000000,15.811500>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<75.184000,0.000000,15.811500>}
box{<0,0,-0.012700><7.112000,0.036000,0.012700> rotate<0,0.000000,0> translate<68.072000,0.000000,15.811500> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<75.184000,0.000000,15.811500>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<78.486000,0.000000,15.811500>}
box{<0,0,-0.012700><3.302000,0.036000,0.012700> rotate<0,0.000000,0> translate<75.184000,0.000000,15.811500> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<78.486000,0.000000,14.668500>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<65.786000,0.000000,14.668500>}
box{<0,0,-0.012700><12.700000,0.036000,0.012700> rotate<0,0.000000,0> translate<65.786000,0.000000,14.668500> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<68.072000,0.000000,15.811500>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<68.072000,0.000000,18.097500>}
box{<0,0,-0.012700><2.286000,0.036000,0.012700> rotate<0,90.000000,0> translate<68.072000,0.000000,18.097500> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<68.072000,0.000000,18.097500>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<75.184000,0.000000,18.097500>}
box{<0,0,-0.012700><7.112000,0.036000,0.012700> rotate<0,0.000000,0> translate<68.072000,0.000000,18.097500> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<75.184000,0.000000,18.097500>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<75.184000,0.000000,15.811500>}
box{<0,0,-0.012700><2.286000,0.036000,0.012700> rotate<0,-90.000000,0> translate<75.184000,0.000000,15.811500> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<65.786000,0.000000,15.811500>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<65.786000,0.000000,14.668500>}
box{<0,0,-0.012700><1.143000,0.036000,0.012700> rotate<0,-90.000000,0> translate<65.786000,0.000000,14.668500> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<78.486000,0.000000,15.811500>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<78.486000,0.000000,14.668500>}
box{<0,0,-0.012700><1.143000,0.036000,0.012700> rotate<0,-90.000000,0> translate<78.486000,0.000000,14.668500> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<78.486000,0.000000,25.654000>}
box{<0,0,-0.012700><1.524000,0.036000,0.012700> rotate<0,0.000000,0> translate<78.486000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<78.486000,0.000000,4.826000>}
box{<0,0,-0.012700><1.524000,0.036000,0.012700> rotate<0,0.000000,0> translate<78.486000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,25.654000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,22.733000>}
box{<0,0,-0.012700><2.921000,0.036000,0.012700> rotate<0,-90.000000,0> translate<80.010000,0.000000,22.733000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,22.733000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,15.621000>}
box{<0,0,-0.012700><7.112000,0.036000,0.012700> rotate<0,-90.000000,0> translate<80.010000,0.000000,15.621000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,15.621000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,11.049000>}
box{<0,0,-0.012700><4.572000,0.036000,0.012700> rotate<0,-90.000000,0> translate<80.010000,0.000000,11.049000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,6.985000>}
box{<0,0,-0.012700><4.064000,0.036000,0.012700> rotate<0,-90.000000,0> translate<80.010000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,4.826000>}
box{<0,0,-0.012700><2.159000,0.036000,0.012700> rotate<0,-90.000000,0> translate<80.010000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<78.486000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<78.486000,0.000000,25.654000>}
box{<0,0,-0.012700><20.828000,0.036000,0.012700> rotate<0,90.000000,0> translate<78.486000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.772000,0.000000,11.049000>}
box{<0,0,-0.012700><0.762000,0.036000,0.012700> rotate<0,0.000000,0> translate<80.010000,0.000000,11.049000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.772000,0.000000,11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.772000,0.000000,6.985000>}
box{<0,0,-0.012700><4.064000,0.036000,0.012700> rotate<0,-90.000000,0> translate<80.772000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.772000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<80.010000,0.000000,6.985000>}
box{<0,0,-0.012700><0.762000,0.036000,0.012700> rotate<0,0.000000,0> translate<80.010000,0.000000,6.985000> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  IMU_XY(-56.192500,0,-15.240000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//XZ_BOARD	IMU_XZ	IMU_XZ
//YZ_BOARD	IMU_YZ2	IMU_YZ_2
