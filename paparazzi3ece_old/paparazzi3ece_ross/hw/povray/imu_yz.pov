//POVRay-File created by 3d41.ulp v1.03
///home/poine/work/paparazzi_savannah/paparazzi3/hw/in_progress/imu_yz.brd
//11/12/2005 00:51:23 

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
#local cam_y = 66;
#local cam_z = -23;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -1;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
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

#local lgt1_pos_x = 7;
#local lgt1_pos_y = 11;
#local lgt1_pos_z = 5;
#local lgt1_intense = 0.703023;
#local lgt2_pos_x = -7;
#local lgt2_pos_y = 11;
#local lgt2_pos_z = 5;
#local lgt2_intense = 0.703023;
#local lgt3_pos_x = 7;
#local lgt3_pos_y = 11;
#local lgt3_pos_z = -3;
#local lgt3_intense = 0.703023;
#local lgt4_pos_x = -7;
#local lgt4_pos_y = 11;
#local lgt4_pos_z = -3;
#local lgt4_intense = 0.703023;

//Do not change these values
#declare pcb_hight = 1.500000;
#declare pcb_cuhight = 0.035000;
#declare pcb_x_size = 20.828000;
#declare pcb_y_size = 10.160000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(638);
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
	//translate<-10.414000,0,-5.080000>
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


#macro IMU_YZ(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,30
<5.461000,3.175000><26.289000,3.175000>
<26.289000,3.175000><26.289000,10.795000>
<(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-0.000000,0>)+<23.749000,0,10.795000>).x,(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-0.000000,0>)+<23.749000,0,10.795000>).z>
<(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-10.001111,0>)+<23.749000,0,10.795000>).x,(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-10.001111,0>)+<23.749000,0,10.795000>).z>
<(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-20.002222,0>)+<23.749000,0,10.795000>).x,(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-20.002222,0>)+<23.749000,0,10.795000>).z>
<(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-30.003334,0>)+<23.749000,0,10.795000>).x,(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-30.003334,0>)+<23.749000,0,10.795000>).z>
<(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-40.004445,0>)+<23.749000,0,10.795000>).x,(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-40.004445,0>)+<23.749000,0,10.795000>).z>
<(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-50.005556,0>)+<23.749000,0,10.795000>).x,(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-50.005556,0>)+<23.749000,0,10.795000>).z>
<(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-60.006667,0>)+<23.749000,0,10.795000>).x,(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-60.006667,0>)+<23.749000,0,10.795000>).z>
<(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-70.007779,0>)+<23.749000,0,10.795000>).x,(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-70.007779,0>)+<23.749000,0,10.795000>).z>
<(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-80.008890,0>)+<23.749000,0,10.795000>).x,(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-80.008890,0>)+<23.749000,0,10.795000>).z>
<(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-90.010001,0>)+<23.749000,0,10.795000>).x,(vrotate(<26.289000,0,10.795000>-<23.749000,0,10.795000>,<0,-90.010001,0>)+<23.749000,0,10.795000>).z>
<23.749000,13.335000>
<23.749000,13.335000><8.001000,13.335000>
<(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-0.000000,0>)+<8.001000,0,10.795000>).x,(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-0.000000,0>)+<8.001000,0,10.795000>).z>
<(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-10.001111,0>)+<8.001000,0,10.795000>).x,(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-10.001111,0>)+<8.001000,0,10.795000>).z>
<(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-20.002222,0>)+<8.001000,0,10.795000>).x,(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-20.002222,0>)+<8.001000,0,10.795000>).z>
<(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-30.003334,0>)+<8.001000,0,10.795000>).x,(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-30.003334,0>)+<8.001000,0,10.795000>).z>
<(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-40.004445,0>)+<8.001000,0,10.795000>).x,(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-40.004445,0>)+<8.001000,0,10.795000>).z>
<(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-50.005556,0>)+<8.001000,0,10.795000>).x,(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-50.005556,0>)+<8.001000,0,10.795000>).z>
<(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-60.006667,0>)+<8.001000,0,10.795000>).x,(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-60.006667,0>)+<8.001000,0,10.795000>).z>
<(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-70.007779,0>)+<8.001000,0,10.795000>).x,(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-70.007779,0>)+<8.001000,0,10.795000>).z>
<(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-80.008890,0>)+<8.001000,0,10.795000>).x,(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-80.008890,0>)+<8.001000,0,10.795000>).z>
<(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-90.010001,0>)+<8.001000,0,10.795000>).x,(vrotate(<8.001000,0,13.335000>-<8.001000,0,10.795000>,<0,-90.010001,0>)+<8.001000,0,10.795000>).z>
<5.461000,10.795000>
<5.461000,10.795000><5.461000,3.175000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_GYRO_X) #declare global_pack_GYRO_X=yes; object {USER_ADXR_GYRO()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<11.938000,-1.500000,8.763000>translate<0,-0.035000,0> }#end		//Analog device ADRX320 gyro  GYRO_X ADXR BC-32
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_SMD_CHIP_0603("123",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<24.257000,-1.500000,6.604000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R1 12K R0603
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_SMD_CHIP_0603("123",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<9.525000,-0.000000,6.604000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R2 12K R0603
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_SMD_CHIP_0603("123",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<9.525000,-0.000000,8.636000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R3 12K R0603
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_SMD_CHIP_0603("123",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<19.685000,-1.500000,6.604000>translate<0,-0.035000,0> }#end		//SMD Resistor 0603 R4 12K R0603
#ifndef(pack_U_2) #declare global_pack_U_2=yes; object {USER_ADXL320()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<22.098000,-1.500000,10.287000>translate<0,-0.035000,0> }#end		// ADXL accelerometer U$2 ADXL320 LSCFP
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<16.637000,-1.537000,7.479000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<16.637000,-1.537000,5.729000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<11.825000,-1.537000,4.318000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<13.575000,-1.537000,4.318000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<13.589000,0.000000,11.416000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<13.589000,0.000000,9.666000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<11.811000,0.000000,5.729000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<11.811000,0.000000,7.479000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<8.650000,0.000000,10.287000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<10.400000,0.000000,10.287000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<18.161000,-1.537000,7.479000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<18.161000,-1.537000,5.729000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<7.239000,-1.537000,8.495000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<7.239000,-1.537000,6.745000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<18.923000,-1.537000,11.670000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<18.923000,-1.537000,9.920000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<22.733000,-1.537000,5.729000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<22.733000,-1.537000,7.479000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<21.209000,-1.537000,7.479000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<21.209000,-1.537000,5.729000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<10.338000,-1.537000,6.363000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<11.138000,-1.537000,6.363000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<11.938000,-1.537000,6.363000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<12.738000,-1.537000,6.363000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<13.538000,-1.537000,6.363000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<9.538000,-1.537000,7.163000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<11.138000,-1.537000,7.163000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<11.938000,-1.537000,7.163000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<12.738000,-1.537000,7.163000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<14.338000,-1.537000,7.163000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<9.538000,-1.537000,7.963000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<10.338000,-1.537000,7.963000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<13.538000,-1.537000,7.963000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<14.338000,-1.537000,7.963000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<9.538000,-1.537000,8.763000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<10.338000,-1.537000,8.763000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<13.538000,-1.537000,8.763000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<14.338000,-1.537000,8.763000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<9.538000,-1.537000,9.563000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<10.338000,-1.537000,9.563000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<13.538000,-1.537000,9.563000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<14.338000,-1.537000,9.563000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<9.538000,-1.537000,10.363000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<11.138000,-1.537000,10.363000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<11.938000,-1.537000,10.363000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<12.738000,-1.537000,10.363000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<14.338000,-1.537000,10.363000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<10.338000,-1.537000,11.163000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<11.138000,-1.537000,11.163000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<11.938000,-1.537000,11.163000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<12.738000,-1.537000,11.163000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<13.538000,-1.537000,11.163000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<24.257000,-1.537000,7.454000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<24.257000,-1.537000,5.754000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<10.375000,0.000000,6.604000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<8.675000,0.000000,6.604000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<8.675000,0.000000,8.636000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<10.375000,0.000000,8.636000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<19.685000,-1.537000,7.454000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<19.685000,-1.537000,5.754000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<24.130000,0.000000,3.810000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<21.123000,-1.537000,12.087000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<21.773000,-1.537000,12.087000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<22.423000,-1.537000,12.087000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<23.073000,-1.537000,12.087000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<23.898000,-1.537000,11.262000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<23.898000,-1.537000,10.612000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<23.898000,-1.537000,9.962000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<23.898000,-1.537000,9.312000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<23.073000,-1.537000,8.487000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<22.423000,-1.537000,8.487000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<21.773000,-1.537000,8.487000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<21.123000,-1.537000,8.487000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.298000,-1.537000,9.312000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.298000,-1.537000,9.962000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.298000,-1.537000,10.612000>}
object{TOOLS_PCB_SMD(0.400000,0.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.298000,-1.537000,11.262000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<19.685000,0.000000,3.810000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<8.636000,0.000000,3.810000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<12.827000,0.000000,3.810000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<20.955000,0.000000,3.810000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<14.097000,0.000000,3.810000>}
//Pads/Vias
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<20.955000,0,4.699000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<18.923000,0,9.144000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<10.541000,0,4.953000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<16.002000,0,9.652000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<19.685000,0,4.699000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<24.257000,0,4.699000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<17.780000,0,11.684000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<14.732000,0,4.826000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<9.017000,0,11.684000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<22.225000,0,4.699000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<22.098000,0,10.287000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<17.653000,0,4.699000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<16.002000,0,11.303000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<7.874000,0,9.906000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.604000,0.350000,1,16,1,0) translate<9.525000,0,4.953000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.239000,-1.535000,6.745000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.239000,-1.535000,6.731000>}
box{<0,0,-0.152400><0.014000,0.035000,0.152400> rotate<0,-90.000000,0> translate<7.239000,-1.535000,6.731000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.860000,-1.535000,9.920000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.874000,-1.535000,9.906000>}
box{<0,0,-0.152400><0.019799,0.035000,0.152400> rotate<0,44.997030,0> translate<7.860000,-1.535000,9.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.239000,-1.535000,8.495000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.888000,-1.535000,8.495000>}
box{<0,0,-0.152400><0.649000,0.035000,0.152400> rotate<0,0.000000,0> translate<7.239000,-1.535000,8.495000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.874000,-0.000000,9.906000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.255000,-0.000000,10.287000>}
box{<0,0,-0.152400><0.538815,0.035000,0.152400> rotate<0,-44.997030,0> translate<7.874000,-0.000000,9.906000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.888000,-1.535000,8.495000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.420000,-1.535000,7.963000>}
box{<0,0,-0.152400><0.752362,0.035000,0.152400> rotate<0,44.997030,0> translate<7.888000,-1.535000,8.495000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,6.604000>}
box{<0,0,-0.152400><2.794000,0.035000,0.152400> rotate<0,90.000000,0> translate<8.636000,-0.000000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,6.643000>}
box{<0,0,-0.152400><0.039000,0.035000,0.152400> rotate<0,90.000000,0> translate<8.636000,-0.000000,6.643000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,6.643000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,6.731000>}
box{<0,0,-0.152400><0.088000,0.035000,0.152400> rotate<0,90.000000,0> translate<8.636000,-0.000000,6.731000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,8.597000>}
box{<0,0,-0.152400><1.993000,0.035000,0.152400> rotate<0,90.000000,0> translate<8.636000,-0.000000,8.597000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.255000,-0.000000,10.287000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.650000,-0.000000,10.287000>}
box{<0,0,-0.152400><0.395000,0.035000,0.152400> rotate<0,0.000000,0> translate<8.255000,-0.000000,10.287000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.675000,-0.000000,6.604000>}
box{<0,0,-0.152400><0.039000,0.035000,0.152400> rotate<0,0.000000,0> translate<8.636000,-0.000000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,6.643000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.675000,-0.000000,6.604000>}
box{<0,0,-0.152400><0.055154,0.035000,0.152400> rotate<0,44.997030,0> translate<8.636000,-0.000000,6.643000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.636000,-0.000000,8.597000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.675000,-0.000000,8.636000>}
box{<0,0,-0.152400><0.055154,0.035000,0.152400> rotate<0,-44.997030,0> translate<8.636000,-0.000000,8.597000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.874000,-1.535000,9.906000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.017000,-1.535000,8.763000>}
box{<0,0,-0.152400><1.616446,0.035000,0.152400> rotate<0,44.997030,0> translate<7.874000,-1.535000,9.906000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.525000,-1.535000,6.731000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.525000,-1.535000,4.953000>}
box{<0,0,-0.152400><1.778000,0.035000,0.152400> rotate<0,-90.000000,0> translate<9.525000,-1.535000,4.953000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.525000,-0.000000,4.953000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.525000,-0.000000,5.754000>}
box{<0,0,-0.152400><0.801000,0.035000,0.152400> rotate<0,90.000000,0> translate<9.525000,-0.000000,5.754000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.239000,-1.535000,6.731000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.525000,-1.535000,6.731000>}
box{<0,0,-0.152400><2.286000,0.035000,0.152400> rotate<0,0.000000,0> translate<7.239000,-1.535000,6.731000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.420000,-1.535000,7.963000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.538000,-1.535000,7.963000>}
box{<0,0,-0.152400><1.118000,0.035000,0.152400> rotate<0,0.000000,0> translate<8.420000,-1.535000,7.963000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.017000,-1.535000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.538000,-1.535000,8.763000>}
box{<0,0,-0.152400><0.521000,0.035000,0.152400> rotate<0,0.000000,0> translate<9.017000,-1.535000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.525000,-1.535000,6.731000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.906000,-1.535000,6.731000>}
box{<0,0,-0.152400><0.381000,0.035000,0.152400> rotate<0,0.000000,0> translate<9.525000,-1.535000,6.731000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.538000,-1.535000,7.163000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.938000,-1.535000,6.763000>}
box{<0,0,-0.152400><0.565685,0.035000,0.152400> rotate<0,44.997030,0> translate<9.538000,-1.535000,7.163000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.906000,-1.535000,6.731000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.938000,-1.535000,6.763000>}
box{<0,0,-0.152400><0.045255,0.035000,0.152400> rotate<0,-44.997030,0> translate<9.906000,-1.535000,6.731000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.017000,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.938000,-1.535000,10.763000>}
box{<0,0,-0.203200><1.302491,0.035000,0.203200> rotate<0,44.997030,0> translate<9.017000,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.538000,-1.535000,10.363000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.938000,-1.535000,10.763000>}
box{<0,0,-0.152400><0.565685,0.035000,0.152400> rotate<0,-44.997030,0> translate<9.538000,-1.535000,10.363000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.938000,-1.535000,10.763000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.325600,-1.535000,11.150600>}
box{<0,0,-0.152400><0.548149,0.035000,0.152400> rotate<0,-44.997030,0> translate<9.938000,-1.535000,10.763000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.538000,-1.535000,7.963000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.337800,-1.535000,7.963000>}
box{<0,0,-0.152400><0.799800,0.035000,0.152400> rotate<0,0.000000,0> translate<9.538000,-1.535000,7.963000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.337800,-1.535000,7.963000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.337800,-1.535000,7.975600>}
box{<0,0,-0.101600><0.012600,0.035000,0.101600> rotate<0,90.000000,0> translate<10.337800,-1.535000,7.975600> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.337800,-1.535000,9.563000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.337800,-1.535000,9.550400>}
box{<0,0,-0.101600><0.012600,0.035000,0.101600> rotate<0,-90.000000,0> translate<10.337800,-1.535000,9.550400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.538000,-1.535000,9.563000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.337800,-1.535000,9.563000>}
box{<0,0,-0.152400><0.799800,0.035000,0.152400> rotate<0,0.000000,0> translate<9.538000,-1.535000,9.563000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.325600,-1.535000,11.150600>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.337800,-1.535000,11.150600>}
box{<0,0,-0.101600><0.012200,0.035000,0.101600> rotate<0,0.000000,0> translate<10.325600,-1.535000,11.150600> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.337800,-1.535000,11.150600>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.337800,-1.535000,11.162800>}
box{<0,0,-0.101600><0.012200,0.035000,0.101600> rotate<0,90.000000,0> translate<10.337800,-1.535000,11.162800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.337800,-1.535000,7.963000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.338000,-1.535000,7.963000>}
box{<0,0,-0.101600><0.000200,0.035000,0.101600> rotate<0,0.000000,0> translate<10.337800,-1.535000,7.963000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.538000,-1.535000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.338000,-1.535000,8.763000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,0.000000,0> translate<9.538000,-1.535000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.337800,-1.535000,9.563000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.338000,-1.535000,9.563000>}
box{<0,0,-0.101600><0.000200,0.035000,0.101600> rotate<0,0.000000,0> translate<10.337800,-1.535000,9.563000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.337800,-1.535000,11.162800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.338000,-1.535000,11.163000>}
box{<0,0,-0.101600><0.000283,0.035000,0.101600> rotate<0,-44.997030,0> translate<10.337800,-1.535000,11.162800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.938000,-1.535000,6.763000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.351000,-1.535000,6.350000>}
box{<0,0,-0.152400><0.584070,0.035000,0.152400> rotate<0,44.997030,0> translate<9.938000,-1.535000,6.763000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.338000,-1.535000,6.363000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.351000,-1.535000,6.350000>}
box{<0,0,-0.101600><0.018385,0.035000,0.101600> rotate<0,44.997030,0> translate<10.338000,-1.535000,6.363000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.351000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<10.363200,-1.535000,6.350000>}
box{<0,0,-0.101600><0.012200,0.035000,0.101600> rotate<0,0.000000,0> translate<10.351000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.525000,-0.000000,5.754000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.375000,-0.000000,6.604000>}
box{<0,0,-0.152400><1.202082,0.035000,0.152400> rotate<0,-44.997030,0> translate<9.525000,-0.000000,5.754000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.400000,-0.000000,8.650000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.400000,-0.000000,10.287000>}
box{<0,0,-0.152400><1.637000,0.035000,0.152400> rotate<0,90.000000,0> translate<10.400000,-0.000000,10.287000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.375000,-0.000000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.414000,-0.000000,8.636000>}
box{<0,0,-0.152400><0.039000,0.035000,0.152400> rotate<0,0.000000,0> translate<10.375000,-0.000000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.400000,-0.000000,8.650000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.414000,-0.000000,8.636000>}
box{<0,0,-0.152400><0.019799,0.035000,0.152400> rotate<0,44.997030,0> translate<10.400000,-0.000000,8.650000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.017000,-0.000000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.414000,-0.000000,10.287000>}
box{<0,0,-0.203200><1.975656,0.035000,0.203200> rotate<0,44.997030,0> translate<9.017000,-0.000000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.400000,-0.000000,10.287000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.414000,-0.000000,10.287000>}
box{<0,0,-0.203200><0.014000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.400000,-0.000000,10.287000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.541000,-1.535000,4.953000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.125200,-1.535000,5.537200>}
box{<0,0,-0.152400><0.826184,0.035000,0.152400> rotate<0,-44.997030,0> translate<10.541000,-1.535000,4.953000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.125200,-1.535000,5.537200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.125200,-1.535000,6.375400>}
box{<0,0,-0.152400><0.838200,0.035000,0.152400> rotate<0,90.000000,0> translate<11.125200,-1.535000,6.375400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.125200,-1.535000,6.375400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.125200,-1.535000,7.150200>}
box{<0,0,-0.152400><0.774800,0.035000,0.152400> rotate<0,90.000000,0> translate<11.125200,-1.535000,7.150200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.125200,-1.535000,6.375400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.125600,-1.535000,6.375400>}
box{<0,0,-0.101600><0.000400,0.035000,0.101600> rotate<0,0.000000,0> translate<11.125200,-1.535000,6.375400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.125600,-1.535000,6.375400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.138000,-1.535000,6.363000>}
box{<0,0,-0.101600><0.017536,0.035000,0.101600> rotate<0,44.997030,0> translate<11.125600,-1.535000,6.375400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.125200,-1.535000,7.150200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.138000,-1.535000,7.163000>}
box{<0,0,-0.101600><0.018102,0.035000,0.101600> rotate<0,-44.997030,0> translate<11.125200,-1.535000,7.150200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.138000,-1.535000,10.363000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.138200,-1.535000,10.363200>}
box{<0,0,-0.101600><0.000283,0.035000,0.101600> rotate<0,-44.997030,0> translate<11.138000,-1.535000,10.363000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.138200,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.150600,-1.535000,10.363200>}
box{<0,0,-0.101600><0.012400,0.035000,0.101600> rotate<0,0.000000,0> translate<11.138200,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.150600,-1.535000,11.150400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.150600,-1.535000,10.363200>}
box{<0,0,-0.152400><0.787200,0.035000,0.152400> rotate<0,-90.000000,0> translate<11.150600,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.138000,-1.535000,11.163000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<11.150600,-1.535000,11.150400>}
box{<0,0,-0.101600><0.017819,0.035000,0.101600> rotate<0,44.997030,0> translate<11.138000,-1.535000,11.163000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.541000,-0.000000,4.953000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.317000,-0.000000,5.729000>}
box{<0,0,-0.152400><1.097430,0.035000,0.152400> rotate<0,-44.997030,0> translate<10.541000,-0.000000,4.953000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<10.375000,-0.000000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.391000,-0.000000,7.620000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,44.997030,0> translate<10.375000,-0.000000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.317000,-0.000000,5.729000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.811000,-0.000000,5.729000>}
box{<0,0,-0.152400><0.494000,0.035000,0.152400> rotate<0,0.000000,0> translate<11.317000,-0.000000,5.729000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.391000,-0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.811000,-0.000000,7.620000>}
box{<0,0,-0.152400><0.420000,0.035000,0.152400> rotate<0,0.000000,0> translate<11.391000,-0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.811000,-0.000000,7.479000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.811000,-0.000000,7.620000>}
box{<0,0,-0.152400><0.141000,0.035000,0.152400> rotate<0,90.000000,0> translate<11.811000,-0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.825000,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.938000,-1.535000,4.318000>}
box{<0,0,-0.152400><0.113000,0.035000,0.152400> rotate<0,0.000000,0> translate<11.825000,-1.535000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.938000,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.938000,-1.535000,6.363000>}
box{<0,0,-0.152400><2.045000,0.035000,0.152400> rotate<0,90.000000,0> translate<11.938000,-1.535000,6.363000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.938000,-1.535000,6.363000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.938000,-1.535000,7.163000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,90.000000,0> translate<11.938000,-1.535000,7.163000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.938000,-1.535000,11.163000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.938000,-1.535000,10.363000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,-90.000000,0> translate<11.938000,-1.535000,10.363000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<11.811000,-0.000000,5.729000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.446000,-0.000000,5.715000>}
box{<0,0,-0.152400><0.635154,0.035000,0.152400> rotate<0,1.262926,0> translate<11.811000,-0.000000,5.729000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.725400,-1.535000,6.350400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.725400,-1.535000,6.350000>}
box{<0,0,-0.101600><0.000400,0.035000,0.101600> rotate<0,-90.000000,0> translate<12.725400,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.725400,-1.535000,6.350400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.725400,-1.535000,7.150400>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,90.000000,0> translate<12.725400,-1.535000,7.150400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.725400,-1.535000,11.150400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.725400,-1.535000,10.363200>}
box{<0,0,-0.152400><0.787200,0.035000,0.152400> rotate<0,-90.000000,0> translate<12.725400,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.725400,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.737800,-1.535000,10.363200>}
box{<0,0,-0.101600><0.012400,0.035000,0.101600> rotate<0,0.000000,0> translate<12.725400,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.725400,-1.535000,6.350400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.738000,-1.535000,6.363000>}
box{<0,0,-0.101600><0.017819,0.035000,0.101600> rotate<0,-44.997030,0> translate<12.725400,-1.535000,6.350400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.738000,-1.535000,5.169000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.738000,-1.535000,6.363000>}
box{<0,0,-0.152400><1.194000,0.035000,0.152400> rotate<0,90.000000,0> translate<12.738000,-1.535000,6.363000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.725400,-1.535000,7.150400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.738000,-1.535000,7.163000>}
box{<0,0,-0.101600><0.017819,0.035000,0.101600> rotate<0,-44.997030,0> translate<12.725400,-1.535000,7.150400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.737800,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.738000,-1.535000,10.363000>}
box{<0,0,-0.101600><0.000283,0.035000,0.101600> rotate<0,44.997030,0> translate<12.737800,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.725400,-1.535000,11.150400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<12.738000,-1.535000,11.163000>}
box{<0,0,-0.101600><0.017819,0.035000,0.101600> rotate<0,-44.997030,0> translate<12.725400,-1.535000,11.150400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.827000,-0.000000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.827000,-0.000000,3.810000>}
box{<0,0,-0.203200><1.905000,0.035000,0.203200> rotate<0,-90.000000,0> translate<12.827000,-0.000000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.446000,-0.000000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.827000,-0.000000,5.715000>}
box{<0,0,-0.152400><0.381000,0.035000,0.152400> rotate<0,0.000000,0> translate<12.446000,-0.000000,5.715000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.827000,-0.000000,5.715000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-0.000000,6.223000>}
box{<0,0,-0.203200><0.718420,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.827000,-0.000000,5.715000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-0.000000,6.223000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-0.000000,9.652000>}
box{<0,0,-0.203200><3.429000,0.035000,0.203200> rotate<0,90.000000,0> translate<13.335000,-0.000000,9.652000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.487400,-1.535000,9.550400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.500000,-1.535000,9.563000>}
box{<0,0,-0.152400><0.017819,0.035000,0.152400> rotate<0,-44.997030,0> translate<13.487400,-1.535000,9.550400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.500000,-1.535000,9.563000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.538000,-1.535000,9.563000>}
box{<0,0,-0.152400><0.038000,0.035000,0.152400> rotate<0,0.000000,0> translate<13.500000,-1.535000,9.563000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<13.538000,-1.535000,7.963000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<13.550800,-1.535000,7.950200>}
box{<0,0,-0.101600><0.018102,0.035000,0.101600> rotate<0,44.997030,0> translate<13.538000,-1.535000,7.963000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<13.538000,-1.535000,9.563000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<13.550800,-1.535000,9.575800>}
box{<0,0,-0.101600><0.018102,0.035000,0.101600> rotate<0,-44.997030,0> translate<13.538000,-1.535000,9.563000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<12.738000,-1.535000,5.169000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.589000,-1.535000,4.318000>}
box{<0,0,-0.152400><1.203496,0.035000,0.152400> rotate<0,44.997030,0> translate<12.738000,-1.535000,5.169000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.575000,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.589000,-1.535000,4.318000>}
box{<0,0,-0.152400><0.014000,0.035000,0.152400> rotate<0,0.000000,0> translate<13.575000,-1.535000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.575000,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.716000,-1.535000,4.191000>}
box{<0,0,-0.152400><0.189763,0.035000,0.152400> rotate<0,42.006883,0> translate<13.575000,-1.535000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.538000,-1.535000,6.363000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.938000,-1.535000,6.763000>}
box{<0,0,-0.152400><0.565685,0.035000,0.152400> rotate<0,-44.997030,0> translate<13.538000,-1.535000,6.363000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.538000,-1.535000,11.163000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.938000,-1.535000,10.763000>}
box{<0,0,-0.203200><0.565685,0.035000,0.203200> rotate<0,44.997030,0> translate<13.538000,-1.535000,11.163000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.335000,-0.000000,9.652000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.970000,-0.000000,9.652000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,0.000000,0> translate<13.335000,-0.000000,9.652000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.589000,-0.000000,9.666000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.970000,-0.000000,9.652000>}
box{<0,0,-0.203200><0.381257,0.035000,0.203200> rotate<0,2.104271,0> translate<13.589000,-0.000000,9.666000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.589000,-0.000000,11.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.970000,-0.000000,11.303000>}
box{<0,0,-0.203200><0.397404,0.035000,0.203200> rotate<0,16.518631,0> translate<13.589000,-0.000000,11.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.589000,-0.000000,11.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.970000,-0.000000,11.430000>}
box{<0,0,-0.203200><0.381257,0.035000,0.203200> rotate<0,-2.104271,0> translate<13.589000,-0.000000,11.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.097000,-0.000000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.097000,-0.000000,4.064000>}
box{<0,0,-0.203200><0.254000,0.035000,0.203200> rotate<0,90.000000,0> translate<14.097000,-0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.938000,-1.535000,10.763000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.287000,-1.535000,10.414000>}
box{<0,0,-0.203200><0.493561,0.035000,0.203200> rotate<0,44.997030,0> translate<13.938000,-1.535000,10.763000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.938000,-1.535000,6.763000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.325600,-1.535000,7.150600>}
box{<0,0,-0.152400><0.548149,0.035000,0.152400> rotate<0,-44.997030,0> translate<13.938000,-1.535000,6.763000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.325600,-1.535000,7.162800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.325600,-1.535000,7.150600>}
box{<0,0,-0.101600><0.012200,0.035000,0.101600> rotate<0,-90.000000,0> translate<14.325600,-1.535000,7.150600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.550800,-1.535000,9.575800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.325600,-1.535000,9.575800>}
box{<0,0,-0.152400><0.774800,0.035000,0.152400> rotate<0,0.000000,0> translate<13.550800,-1.535000,9.575800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.325600,-1.535000,9.575400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.325600,-1.535000,9.575800>}
box{<0,0,-0.101600><0.000400,0.035000,0.101600> rotate<0,90.000000,0> translate<14.325600,-1.535000,9.575800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.312400,-1.535000,10.388600>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.325600,-1.535000,10.388600>}
box{<0,0,-0.101600><0.013200,0.035000,0.101600> rotate<0,0.000000,0> translate<14.312400,-1.535000,10.388600> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.325600,-1.535000,10.375400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.325600,-1.535000,10.388600>}
box{<0,0,-0.101600><0.013200,0.035000,0.101600> rotate<0,90.000000,0> translate<14.325600,-1.535000,10.388600> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.325600,-1.535000,7.162800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.337800,-1.535000,7.162800>}
box{<0,0,-0.101600><0.012200,0.035000,0.101600> rotate<0,0.000000,0> translate<14.325600,-1.535000,7.162800> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.337800,-1.535000,7.162800>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.338000,-1.535000,7.163000>}
box{<0,0,-0.101600><0.000283,0.035000,0.101600> rotate<0,-44.997030,0> translate<14.337800,-1.535000,7.162800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.538000,-1.535000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.338000,-1.535000,8.763000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,0.000000,0> translate<13.538000,-1.535000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.325600,-1.535000,9.575400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.338000,-1.535000,9.563000>}
box{<0,0,-0.101600><0.017536,0.035000,0.101600> rotate<0,44.997030,0> translate<14.325600,-1.535000,9.575400> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.325600,-1.535000,10.375400>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.338000,-1.535000,10.363000>}
box{<0,0,-0.101600><0.017536,0.035000,0.101600> rotate<0,44.997030,0> translate<14.325600,-1.535000,10.375400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.550800,-1.535000,7.950200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.350800,-1.535000,7.950200>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,0.000000,0> translate<13.550800,-1.535000,7.950200> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.338000,-1.535000,7.963000>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.350800,-1.535000,7.950200>}
box{<0,0,-0.101600><0.018102,0.035000,0.101600> rotate<0,44.997030,0> translate<14.338000,-1.535000,7.963000> }
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.350800,-1.535000,7.950200>}
cylinder{<0,0,0><0,0.035000,0>0.101600 translate<14.351000,-1.535000,7.950200>}
box{<0,0,-0.101600><0.000200,0.035000,0.101600> rotate<0,0.000000,0> translate<14.350800,-1.535000,7.950200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.338000,-1.535000,10.363000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.351000,-1.535000,10.376000>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,-44.997030,0> translate<14.338000,-1.535000,10.363000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.351000,-1.535000,10.414000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.351000,-1.535000,10.376000>}
box{<0,0,-0.152400><0.038000,0.035000,0.152400> rotate<0,-90.000000,0> translate<14.351000,-1.535000,10.376000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.287000,-1.535000,10.414000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.351000,-1.535000,10.414000>}
box{<0,0,-0.152400><0.064000,0.035000,0.152400> rotate<0,0.000000,0> translate<14.287000,-1.535000,10.414000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.938000,-1.535000,10.763000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.478000,-1.535000,11.303000>}
box{<0,0,-0.203200><0.763675,0.035000,0.203200> rotate<0,-44.997030,0> translate<13.938000,-1.535000,10.763000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.097000,-0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.732000,-0.000000,4.826000>}
box{<0,0,-0.203200><0.991902,0.035000,0.203200> rotate<0,-50.191116,0> translate<14.097000,-0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.938000,-1.535000,6.763000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.859000,-1.535000,5.842000>}
box{<0,0,-0.152400><1.302491,0.035000,0.152400> rotate<0,44.997030,0> translate<13.938000,-1.535000,6.763000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.350800,-1.535000,7.950200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.417800,-1.535000,7.950200>}
box{<0,0,-0.152400><1.067000,0.035000,0.152400> rotate<0,0.000000,0> translate<14.350800,-1.535000,7.950200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.417800,-1.535000,7.950200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.748000,-1.535000,7.620000>}
box{<0,0,-0.152400><0.466973,0.035000,0.152400> rotate<0,44.997030,0> translate<15.417800,-1.535000,7.950200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.338000,-1.535000,9.563000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.913000,-1.535000,9.563000>}
box{<0,0,-0.203200><1.575000,0.035000,0.203200> rotate<0,0.000000,0> translate<14.338000,-1.535000,9.563000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.589000,-0.000000,9.666000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.988000,-0.000000,9.666000>}
box{<0,0,-0.203200><2.399000,0.035000,0.203200> rotate<0,0.000000,0> translate<13.589000,-0.000000,9.666000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.913000,-1.535000,9.563000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.002000,-1.535000,9.652000>}
box{<0,0,-0.203200><0.125865,0.035000,0.203200> rotate<0,-44.997030,0> translate<15.913000,-1.535000,9.563000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.988000,-0.000000,9.666000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.002000,-0.000000,9.652000>}
box{<0,0,-0.203200><0.019799,0.035000,0.203200> rotate<0,44.997030,0> translate<15.988000,-0.000000,9.666000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.970000,-0.000000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.002000,-0.000000,11.303000>}
box{<0,0,-0.203200><2.032000,0.035000,0.203200> rotate<0,0.000000,0> translate<13.970000,-0.000000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.478000,-1.535000,11.303000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.002000,-1.535000,11.303000>}
box{<0,0,-0.203200><1.524000,0.035000,0.203200> rotate<0,0.000000,0> translate<14.478000,-1.535000,11.303000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.859000,-1.535000,5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.623000,-1.535000,5.842000>}
box{<0,0,-0.152400><1.764000,0.035000,0.152400> rotate<0,0.000000,0> translate<14.859000,-1.535000,5.842000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.623000,-1.535000,5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.637000,-1.535000,5.729000>}
box{<0,0,-0.152400><0.113864,0.035000,0.152400> rotate<0,82.931924,0> translate<16.623000,-1.535000,5.842000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.748000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.637000,-1.535000,7.620000>}
box{<0,0,-0.152400><0.889000,0.035000,0.152400> rotate<0,0.000000,0> translate<15.748000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.637000,-1.535000,7.479000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.637000,-1.535000,7.620000>}
box{<0,0,-0.152400><0.141000,0.035000,0.152400> rotate<0,90.000000,0> translate<16.637000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<14.338000,-1.535000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.145000,-1.535000,8.763000>}
box{<0,0,-0.152400><2.807000,0.035000,0.152400> rotate<0,0.000000,0> translate<14.338000,-1.535000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.653000,-1.535000,4.699000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.161000,-1.535000,5.207000>}
box{<0,0,-0.203200><0.718420,0.035000,0.203200> rotate<0,-44.997030,0> translate<17.653000,-1.535000,4.699000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.161000,-1.535000,5.207000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.161000,-1.535000,5.729000>}
box{<0,0,-0.203200><0.522000,0.035000,0.203200> rotate<0,90.000000,0> translate<18.161000,-1.535000,5.729000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.161000,-1.535000,7.747000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.161000,-1.535000,7.479000>}
box{<0,0,-0.152400><0.268000,0.035000,0.152400> rotate<0,-90.000000,0> translate<18.161000,-1.535000,7.479000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.145000,-1.535000,8.763000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.161000,-1.535000,7.747000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,44.997030,0> translate<17.145000,-1.535000,8.763000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.923000,-1.535000,9.920000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.923000,-1.535000,9.144000>}
box{<0,0,-0.203200><0.776000,0.035000,0.203200> rotate<0,-90.000000,0> translate<18.923000,-1.535000,9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.780000,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.923000,-1.535000,11.684000>}
box{<0,0,-0.203200><1.143000,0.035000,0.203200> rotate<0,0.000000,0> translate<17.780000,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.923000,-1.535000,11.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.923000,-1.535000,11.684000>}
box{<0,0,-0.203200><0.014000,0.035000,0.203200> rotate<0,90.000000,0> translate<18.923000,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.923000,-1.535000,9.920000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.937000,-1.535000,9.920000>}
box{<0,0,-0.152400><0.014000,0.035000,0.152400> rotate<0,0.000000,0> translate<18.923000,-1.535000,9.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.937000,-1.535000,9.920000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.304000,-1.535000,10.287000>}
box{<0,0,-0.152400><0.519016,0.035000,0.152400> rotate<0,-44.997030,0> translate<18.937000,-1.535000,9.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.290000,-1.535000,10.287000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.304000,-1.535000,10.287000>}
box{<0,0,-0.152400><0.014000,0.035000,0.152400> rotate<0,0.000000,0> translate<19.290000,-1.535000,10.287000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.685000,-0.000000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.685000,-0.000000,4.699000>}
box{<0,0,-0.127000><0.889000,0.035000,0.127000> rotate<0,90.000000,0> translate<19.685000,-0.000000,4.699000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.685000,-1.535000,4.699000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.685000,-1.535000,5.754000>}
box{<0,0,-0.127000><1.055000,0.035000,0.127000> rotate<0,90.000000,0> translate<19.685000,-1.535000,5.754000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.685000,-1.535000,7.454000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.685000,-1.535000,7.366000>}
box{<0,0,-0.152400><0.088000,0.035000,0.152400> rotate<0,-90.000000,0> translate<19.685000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.304000,-1.535000,10.287000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.193000,-1.535000,10.287000>}
box{<0,0,-0.152400><0.889000,0.035000,0.152400> rotate<0,0.000000,0> translate<19.304000,-1.535000,10.287000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.179000,-1.535000,10.301000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.193000,-1.535000,10.287000>}
box{<0,0,-0.127000><0.019799,0.035000,0.127000> rotate<0,44.997030,0> translate<20.179000,-1.535000,10.301000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.298000,-1.535000,9.962000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.298000,-1.535000,9.928000>}
box{<0,0,-0.127000><0.034000,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.298000,-1.535000,9.928000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.193000,-1.535000,10.287000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.298000,-1.535000,10.287000>}
box{<0,0,-0.127000><0.105000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.193000,-1.535000,10.287000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.298000,-1.535000,9.928000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.298000,-1.535000,10.287000>}
box{<0,0,-0.127000><0.359000,0.035000,0.127000> rotate<0,90.000000,0> translate<20.298000,-1.535000,10.287000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.298000,-1.535000,10.287000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.298000,-1.535000,10.612000>}
box{<0,0,-0.127000><0.325000,0.035000,0.127000> rotate<0,90.000000,0> translate<20.298000,-1.535000,10.612000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.298000,-1.535000,9.928000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,9.906000>}
box{<0,0,-0.127000><0.031113,0.035000,0.127000> rotate<0,44.997030,0> translate<20.298000,-1.535000,9.928000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<19.685000,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.916000,-1.535000,7.366000>}
box{<0,0,-0.152400><1.231000,0.035000,0.152400> rotate<0,0.000000,0> translate<19.685000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.955000,-0.000000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.955000,-0.000000,4.699000>}
box{<0,0,-0.203200><0.889000,0.035000,0.203200> rotate<0,90.000000,0> translate<20.955000,-0.000000,4.699000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.916000,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.955000,-1.535000,7.327000>}
box{<0,0,-0.152400><0.055154,0.035000,0.152400> rotate<0,44.997030,0> translate<20.916000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.955000,-1.535000,7.327000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.955000,-1.535000,7.366000>}
box{<0,0,-0.152400><0.039000,0.035000,0.152400> rotate<0,90.000000,0> translate<20.955000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.955000,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.996000,-1.535000,7.407000>}
box{<0,0,-0.152400><0.057983,0.035000,0.152400> rotate<0,-44.997030,0> translate<20.955000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.955000,-1.535000,7.327000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.082000,-1.535000,7.327000>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.955000,-1.535000,7.327000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.082000,-1.535000,7.327000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.082000,-1.535000,7.366000>}
box{<0,0,-0.152400><0.039000,0.035000,0.152400> rotate<0,90.000000,0> translate<21.082000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.082000,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.123000,-1.535000,7.366000>}
box{<0,0,-0.152400><0.041000,0.035000,0.152400> rotate<0,0.000000,0> translate<21.082000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.123000,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.123000,-1.535000,8.487000>}
box{<0,0,-0.152400><1.121000,0.035000,0.152400> rotate<0,90.000000,0> translate<21.123000,-1.535000,8.487000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.082000,-1.535000,7.327000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.170000,-1.535000,7.327000>}
box{<0,0,-0.127000><0.088000,0.035000,0.127000> rotate<0,0.000000,0> translate<21.082000,-1.535000,7.327000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.170000,-1.535000,7.327000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.209000,-1.535000,7.366000>}
box{<0,0,-0.127000><0.055154,0.035000,0.127000> rotate<0,-44.997030,0> translate<21.170000,-1.535000,7.327000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.209000,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.209000,-1.535000,7.479000>}
box{<0,0,-0.127000><0.113000,0.035000,0.127000> rotate<0,90.000000,0> translate<21.209000,-1.535000,7.479000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.209000,-1.535000,5.729000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.971000,-1.535000,5.729000>}
box{<0,0,-0.203200><0.762000,0.035000,0.203200> rotate<0,0.000000,0> translate<21.209000,-1.535000,5.729000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.971000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.971000,-1.535000,5.729000>}
box{<0,0,-0.203200><0.649000,0.035000,0.203200> rotate<0,90.000000,0> translate<21.971000,-1.535000,5.729000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.971000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.225000,-1.535000,4.699000>}
box{<0,0,-0.203200><0.457905,0.035000,0.203200> rotate<0,56.306216,0> translate<21.971000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.423000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.423000,-1.535000,8.487000>}
box{<0,0,-0.152400><0.867000,0.035000,0.152400> rotate<0,90.000000,0> translate<22.423000,-1.535000,8.487000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.423000,-1.535000,11.613000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.423000,-1.535000,12.087000>}
box{<0,0,-0.203200><0.474000,0.035000,0.203200> rotate<0,90.000000,0> translate<22.423000,-1.535000,12.087000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.971000,-1.535000,5.729000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.733000,-1.535000,5.729000>}
box{<0,0,-0.203200><0.762000,0.035000,0.203200> rotate<0,0.000000,0> translate<21.971000,-1.535000,5.729000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.733000,-1.535000,7.479000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.733000,-1.535000,7.366000>}
box{<0,0,-0.127000><0.113000,0.035000,0.127000> rotate<0,-90.000000,0> translate<22.733000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.733000,-1.535000,7.479000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.733000,-1.535000,7.493000>}
box{<0,0,-0.152400><0.014000,0.035000,0.152400> rotate<0,90.000000,0> translate<22.733000,-1.535000,7.493000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.423000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.733000,-1.535000,7.620000>}
box{<0,0,-0.152400><0.310000,0.035000,0.152400> rotate<0,0.000000,0> translate<22.423000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.733000,-1.535000,7.479000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.733000,-1.535000,7.620000>}
box{<0,0,-0.152400><0.141000,0.035000,0.152400> rotate<0,90.000000,0> translate<22.733000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.098000,-1.535000,10.287000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.923500,-1.535000,11.112500>}
box{<0,0,-0.203200><1.167433,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.098000,-1.535000,10.287000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.423000,-1.535000,11.613000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.923500,-1.535000,11.112500>}
box{<0,0,-0.203200><0.707814,0.035000,0.203200> rotate<0,44.997030,0> translate<22.423000,-1.535000,11.613000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.923500,-1.535000,11.112500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.495000,-1.535000,10.541000>}
box{<0,0,-0.203200><0.808223,0.035000,0.203200> rotate<0,44.997030,0> translate<22.923500,-1.535000,11.112500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.495000,-1.535000,10.541000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,10.541000>}
box{<0,0,-0.203200><0.381000,0.035000,0.203200> rotate<0,0.000000,0> translate<23.495000,-1.535000,10.541000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,10.541000>}
box{<0,0,-0.203200><0.049000,0.035000,0.203200> rotate<0,-90.000000,0> translate<23.876000,-1.535000,10.541000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,11.176000>}
box{<0,0,-0.203200><0.508000,0.035000,0.203200> rotate<0,90.000000,0> translate<23.876000,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,10.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.898000,-1.535000,10.612000>}
box{<0,0,-0.203200><0.031113,0.035000,0.203200> rotate<0,-44.997030,0> translate<23.876000,-1.535000,10.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.898000,-1.535000,9.962000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.898000,-1.535000,10.612000>}
box{<0,0,-0.203200><0.650000,0.035000,0.203200> rotate<0,90.000000,0> translate<23.898000,-1.535000,10.612000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.898000,-1.535000,10.646000>}
box{<0,0,-0.203200><0.031113,0.035000,0.203200> rotate<0,44.997030,0> translate<23.876000,-1.535000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.898000,-1.535000,10.612000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.898000,-1.535000,10.646000>}
box{<0,0,-0.203200><0.034000,0.035000,0.203200> rotate<0,90.000000,0> translate<23.898000,-1.535000,10.646000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.898000,-1.535000,11.198000>}
box{<0,0,-0.203200><0.031113,0.035000,0.203200> rotate<0,-44.997030,0> translate<23.876000,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.898000,-1.535000,11.198000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.898000,-1.535000,11.262000>}
box{<0,0,-0.203200><0.064000,0.035000,0.203200> rotate<0,90.000000,0> translate<23.898000,-1.535000,11.262000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-0.000000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-0.000000,4.445000>}
box{<0,0,-0.127000><0.635000,0.035000,0.127000> rotate<0,90.000000,0> translate<24.130000,-0.000000,4.445000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-0.000000,4.445000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.257000,-0.000000,4.699000>}
box{<0,0,-0.127000><0.283981,0.035000,0.127000> rotate<0,-63.430762,0> translate<24.130000,-0.000000,4.445000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.257000,-1.535000,4.699000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.257000,-1.535000,5.754000>}
box{<0,0,-0.127000><1.055000,0.035000,0.127000> rotate<0,90.000000,0> translate<24.257000,-1.535000,5.754000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.733000,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.384000,-1.535000,7.366000>}
box{<0,0,-0.127000><1.651000,0.035000,0.127000> rotate<0,0.000000,0> translate<22.733000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.257000,-1.535000,7.454000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.384000,-1.535000,7.366000>}
box{<0,0,-0.127000><0.154509,0.035000,0.127000> rotate<0,34.716315,0> translate<24.257000,-1.535000,7.454000> }
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
texture{col_pol}
}
#end
union{
//Holes(fast)/Vias
cylinder{<20.955000,0.038000,4.699000><20.955000,-1.538000,4.699000>0.175000 }
cylinder{<18.923000,0.038000,9.144000><18.923000,-1.538000,9.144000>0.175000 }
cylinder{<10.541000,0.038000,4.953000><10.541000,-1.538000,4.953000>0.175000 }
cylinder{<16.002000,0.038000,9.652000><16.002000,-1.538000,9.652000>0.175000 }
cylinder{<19.685000,0.038000,4.699000><19.685000,-1.538000,4.699000>0.175000 }
cylinder{<24.257000,0.038000,4.699000><24.257000,-1.538000,4.699000>0.175000 }
cylinder{<17.780000,0.038000,11.684000><17.780000,-1.538000,11.684000>0.175000 }
cylinder{<14.732000,0.038000,4.826000><14.732000,-1.538000,4.826000>0.175000 }
cylinder{<9.017000,0.038000,11.684000><9.017000,-1.538000,11.684000>0.175000 }
cylinder{<22.225000,0.038000,4.699000><22.225000,-1.538000,4.699000>0.175000 }
cylinder{<22.098000,0.038000,10.287000><22.098000,-1.538000,10.287000>0.175000 }
cylinder{<17.653000,0.038000,4.699000><17.653000,-1.538000,4.699000>0.175000 }
cylinder{<16.002000,0.038000,11.303000><16.002000,-1.538000,11.303000>0.175000 }
cylinder{<7.874000,0.038000,9.906000><7.874000,-1.538000,9.906000>0.175000 }
cylinder{<9.525000,0.038000,4.953000><9.525000,-1.538000,4.953000>0.175000 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.287000,-1.536000,7.329000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.287000,-1.536000,5.879000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<16.287000,-1.536000,5.879000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.987000,-1.536000,5.879000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.987000,-1.536000,7.329000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<16.987000,-1.536000,7.329000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<16.637000,-1.536000,7.229000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<16.637000,-1.536000,5.979000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<11.975000,-1.536000,3.968000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.425000,-1.536000,3.968000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<11.975000,-1.536000,3.968000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.425000,-1.536000,4.668000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<11.975000,-1.536000,4.668000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<11.975000,-1.536000,4.668000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<12.075000,-1.536000,4.318000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<13.325000,-1.536000,4.318000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.939000,0.000000,11.266000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.939000,0.000000,9.816000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.939000,0.000000,9.816000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.239000,0.000000,9.816000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.239000,0.000000,11.266000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<13.239000,0.000000,11.266000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<13.589000,0.000000,11.166000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<13.589000,0.000000,9.916000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<11.461000,0.000000,5.879000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<11.461000,0.000000,7.329000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<11.461000,0.000000,7.329000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.161000,0.000000,7.329000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.161000,0.000000,5.879000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<12.161000,0.000000,5.879000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<11.811000,0.000000,5.979000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<11.811000,0.000000,7.229000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.800000,0.000000,10.637000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<10.250000,0.000000,10.637000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<8.800000,0.000000,10.637000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<10.250000,0.000000,9.937000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.800000,0.000000,9.937000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<8.800000,0.000000,9.937000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<8.900000,0.000000,10.287000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<10.150000,0.000000,10.287000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.811000,-1.536000,7.329000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.811000,-1.536000,5.879000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<17.811000,-1.536000,5.879000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.511000,-1.536000,5.879000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.511000,-1.536000,7.329000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<18.511000,-1.536000,7.329000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<18.161000,-1.536000,7.229000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<18.161000,-1.536000,5.979000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<6.889000,-1.536000,8.345000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<6.889000,-1.536000,6.895000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<6.889000,-1.536000,6.895000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<7.589000,-1.536000,6.895000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<7.589000,-1.536000,8.345000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<7.589000,-1.536000,8.345000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<7.239000,-1.536000,8.245000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<7.239000,-1.536000,6.995000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.573000,-1.536000,11.520000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.573000,-1.536000,10.070000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<18.573000,-1.536000,10.070000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.273000,-1.536000,10.070000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.273000,-1.536000,11.520000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<19.273000,-1.536000,11.520000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<18.923000,-1.536000,11.420000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<18.923000,-1.536000,10.170000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.083000,-1.536000,5.879000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.083000,-1.536000,7.329000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<23.083000,-1.536000,7.329000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.383000,-1.536000,7.329000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.383000,-1.536000,5.879000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<22.383000,-1.536000,5.879000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<22.733000,-1.536000,5.979000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<22.733000,-1.536000,7.229000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.859000,-1.536000,7.329000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.859000,-1.536000,5.879000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<20.859000,-1.536000,5.879000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.559000,-1.536000,5.879000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.559000,-1.536000,7.329000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<21.559000,-1.536000,7.329000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<21.209000,-1.536000,7.229000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<21.209000,-1.536000,5.979000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.438000,-1.536000,5.263000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.188000,-1.536000,5.263000>}
box{<0,0,-0.063500><0.750000,0.036000,0.063500> rotate<0,0.000000,0> translate<8.438000,-1.536000,5.263000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.188000,-1.536000,5.263000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.438000,-1.536000,5.263000>}
box{<0,0,-0.063500><6.250000,0.036000,0.063500> rotate<0,0.000000,0> translate<9.188000,-1.536000,5.263000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.438000,-1.536000,5.263000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.438000,-1.536000,12.263000>}
box{<0,0,-0.063500><7.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<15.438000,-1.536000,12.263000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.438000,-1.536000,12.263000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.438000,-1.536000,12.263000>}
box{<0,0,-0.063500><7.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<8.438000,-1.536000,12.263000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.438000,-1.536000,12.263000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.438000,-1.536000,6.013000>}
box{<0,0,-0.063500><6.250000,0.036000,0.063500> rotate<0,-90.000000,0> translate<8.438000,-1.536000,6.013000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.438000,-1.536000,6.013000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.438000,-1.536000,5.263000>}
box{<0,0,-0.063500><0.750000,0.036000,0.063500> rotate<0,-90.000000,0> translate<8.438000,-1.536000,5.263000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.438000,-1.536000,6.013000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.188000,-1.536000,5.263000>}
box{<0,0,-0.063500><1.060660,0.036000,0.063500> rotate<0,44.997030,0> translate<8.438000,-1.536000,6.013000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.613000,-1.536000,7.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.613000,-1.536000,6.172000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.613000,-1.536000,6.172000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.901000,-1.536000,6.172000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.901000,-1.536000,7.036000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.901000,-1.536000,7.036000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<24.257000,-1.536000,5.969000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<24.257000,-1.536000,7.239000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.957000,0.000000,6.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.093000,0.000000,6.960000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.093000,0.000000,6.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.093000,0.000000,6.248000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.957000,0.000000,6.248000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.093000,0.000000,6.248000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<8.890000,0.000000,6.604000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<10.160000,0.000000,6.604000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.093000,0.000000,8.280000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.957000,0.000000,8.280000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.093000,0.000000,8.280000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.957000,0.000000,8.992000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.093000,0.000000,8.992000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<9.093000,0.000000,8.992000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<10.160000,0.000000,8.636000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<8.890000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.041000,-1.536000,7.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.041000,-1.536000,6.172000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,-90.000000,0> translate<20.041000,-1.536000,6.172000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.329000,-1.536000,6.172000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.329000,-1.536000,7.036000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.329000,-1.536000,7.036000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<19.685000,-1.536000,5.969000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-270.000000,0> translate<19.685000,-1.536000,7.239000>}
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<20.098000,-1.536000,12.287000>}
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<20.098000,-1.536000,8.287000>}
box{<0,0,-0.050000><4.000000,0.036000,0.050000> rotate<0,-90.000000,0> translate<20.098000,-1.536000,8.287000> }
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<20.098000,-1.536000,8.287000>}
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<24.098000,-1.536000,8.287000>}
box{<0,0,-0.050000><4.000000,0.036000,0.050000> rotate<0,0.000000,0> translate<20.098000,-1.536000,8.287000> }
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<24.098000,-1.536000,8.287000>}
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<24.098000,-1.536000,12.287000>}
box{<0,0,-0.050000><4.000000,0.036000,0.050000> rotate<0,90.000000,0> translate<24.098000,-1.536000,12.287000> }
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<24.098000,-1.536000,12.287000>}
cylinder{<0,0,0><0,0.036000,0>0.050000 translate<20.098000,-1.536000,12.287000>}
box{<0,0,-0.050000><4.000000,0.036000,0.050000> rotate<0,0.000000,0> translate<20.098000,-1.536000,12.287000> }
difference{
cylinder{<20.828000,0,11.557000><20.828000,0.036000,11.557000>0.192300 translate<0,-1.536000,0>}
cylinder{<20.828000,-0.1,11.557000><20.828000,0.135000,11.557000>0.166900 translate<0,-1.536000,0>}}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  IMU_YZ(-15.875000,0,-8.255000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//C15	22nF	C0603K
//C16	22nF	C0603K
//C17	100nF	C0603K
//C18	100nF	C0603K
//C19	100nF	C0603K
//C20	47nF	C0603K
//C21	22nF	C0603K
//C23	100nF	C0603K
//C33	100nF	C0603K
//C34	100nF	C0603K
//U$1	SOLDER_PAD	SOLDER_PAD
//U$4	SOLDER_PAD	SOLDER_PAD
//U$5	SOLDER_PAD	SOLDER_PAD
//U$6	SOLDER_PAD	SOLDER_PAD
//U$7	SOLDER_PAD	SOLDER_PAD
//U$8	SOLDER_PAD	SOLDER_PAD
