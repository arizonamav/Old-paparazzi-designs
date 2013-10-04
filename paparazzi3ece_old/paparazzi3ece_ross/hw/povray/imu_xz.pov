//POVRay-File created by 3d41.ulp v1.03
///home/poine/work/paparazzi_savannah/paparazzi3/hw/in_progress/imu_xz.brd
//11/12/2005 00:51:07 

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
#local cam_y = 43;
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

#local lgt1_pos_x = 4;
#local lgt1_pos_y = 7;
#local lgt1_pos_z = 5;
#local lgt1_intense = 0.701843;
#local lgt2_pos_x = -4;
#local lgt2_pos_y = 7;
#local lgt2_pos_z = 5;
#local lgt2_intense = 0.701843;
#local lgt3_pos_x = 4;
#local lgt3_pos_y = 7;
#local lgt3_pos_z = -3;
#local lgt3_intense = 0.701843;
#local lgt4_pos_x = -4;
#local lgt4_pos_y = 7;
#local lgt4_pos_z = -3;
#local lgt4_intense = 0.701843;

//Do not change these values
#declare pcb_hight = 1.500000;
#declare pcb_cuhight = 0.035000;
#declare pcb_x_size = 12.700000;
#declare pcb_y_size = 10.160000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(621);
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
	//translate<-6.350000,0,-5.080000>
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


#macro IMU_XZ(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,19
<0.635000,2.921000><0.635000,10.541000>
<(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,0.000000,0>)+<3.175000,0,10.541000>).x,(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,0.000000,0>)+<3.175000,0,10.541000>).z>
<(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,10.001111,0>)+<3.175000,0,10.541000>).x,(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,10.001111,0>)+<3.175000,0,10.541000>).z>
<(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,20.002222,0>)+<3.175000,0,10.541000>).x,(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,20.002222,0>)+<3.175000,0,10.541000>).z>
<(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,30.003334,0>)+<3.175000,0,10.541000>).x,(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,30.003334,0>)+<3.175000,0,10.541000>).z>
<(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,40.004445,0>)+<3.175000,0,10.541000>).x,(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,40.004445,0>)+<3.175000,0,10.541000>).z>
<(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,50.005556,0>)+<3.175000,0,10.541000>).x,(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,50.005556,0>)+<3.175000,0,10.541000>).z>
<(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,60.006667,0>)+<3.175000,0,10.541000>).x,(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,60.006667,0>)+<3.175000,0,10.541000>).z>
<(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,70.007779,0>)+<3.175000,0,10.541000>).x,(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,70.007779,0>)+<3.175000,0,10.541000>).z>
<(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,80.008890,0>)+<3.175000,0,10.541000>).x,(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,80.008890,0>)+<3.175000,0,10.541000>).z>
<(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,90.010001,0>)+<3.175000,0,10.541000>).x,(vrotate(<0.635000,0,10.541000>-<3.175000,0,10.541000>,<0,90.010001,0>)+<3.175000,0,10.541000>).z>
<3.175000,13.081000>
<3.175000,13.081000><13.335000,13.081000>
<13.335000,13.081000><13.335000,2.921000>
<13.335000,2.921000><0.635000,2.921000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_GYRO_Y) #declare global_pack_GYRO_Y=yes; object {USER_ADXR_GYRO()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<6.604000,-1.500000,8.509000>translate<0,-0.035000,0> }#end		//Analog device ADRX320 gyro  GYRO_Y ADXR BC-32
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_SMD_CHIP_0603("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<4.191000,-0.000000,6.223000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R1  R0603
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_SMD_CHIP_0603("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<4.191000,-0.000000,8.255000>translate<0,0.035000,0> }#end		//SMD Resistor 0603 R2  R0603
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<8.382000,0.000000,7.733000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<8.382000,0.000000,5.983000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<6.999000,-1.537000,4.064000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<8.749000,-1.537000,4.064000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<6.477000,0.000000,8.114000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<6.477000,0.000000,6.364000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<8.382000,0.000000,9.412000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<8.382000,0.000000,11.162000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<3.316000,0.000000,10.160000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<5.066000,0.000000,10.160000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<11.049000,-1.537000,8.495000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<11.049000,-1.537000,6.745000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<2.159000,-1.537000,7.733000>}
object{TOOLS_PCB_SMD(1.050000,1.080000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<2.159000,-1.537000,5.983000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<5.004000,-1.537000,6.109000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<5.804000,-1.537000,6.109000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<6.604000,-1.537000,6.109000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<7.404000,-1.537000,6.109000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<8.204000,-1.537000,6.109000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<4.204000,-1.537000,6.909000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<5.804000,-1.537000,6.909000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<6.604000,-1.537000,6.909000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<7.404000,-1.537000,6.909000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<9.004000,-1.537000,6.909000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<4.204000,-1.537000,7.709000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<5.004000,-1.537000,7.709000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<8.204000,-1.537000,7.709000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<9.004000,-1.537000,7.709000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<4.204000,-1.537000,8.509000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<5.004000,-1.537000,8.509000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<8.204000,-1.537000,8.509000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<9.004000,-1.537000,8.509000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<4.204000,-1.537000,9.309000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<5.004000,-1.537000,9.309000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<8.204000,-1.537000,9.309000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<9.004000,-1.537000,9.309000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<4.204000,-1.537000,10.109000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<5.804000,-1.537000,10.109000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<6.604000,-1.537000,10.109000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<7.404000,-1.537000,10.109000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<9.004000,-1.537000,10.109000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<5.004000,-1.537000,10.909000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<5.804000,-1.537000,10.909000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<6.604000,-1.537000,10.909000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<7.404000,-1.537000,10.909000>}
object{TOOLS_PCB_SMD(0.500000,0.500000,0.037000,100) rotate<0,-0.000000,0> texture{col_pds} translate<8.204000,-1.537000,10.909000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<5.041000,0.000000,6.223000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<3.341000,0.000000,6.223000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<3.341000,0.000000,8.255000>}
object{TOOLS_PCB_SMD(1.000000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<5.041000,0.000000,8.255000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<3.048000,0.000000,3.556000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<4.953000,0.000000,3.556000>}
object{TOOLS_PCB_SMD(1.270000,0.635000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<6.858000,0.000000,3.556000>}
//Pads/Vias
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.204000,-1.535000,6.908500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.204000,-1.535000,6.909000>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,90.000000,0> translate<4.204000,-1.535000,6.909000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.204000,-1.535000,10.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.204000,-1.535000,10.109500>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,90.000000,0> translate<4.204000,-1.535000,10.109500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.204000,-1.535000,7.709000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.991000,-1.535000,7.709000>}
box{<0,0,-0.152400><0.787000,0.035000,0.152400> rotate<0,0.000000,0> translate<4.204000,-1.535000,7.709000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.204000,-1.535000,9.309000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.991000,-1.535000,9.309000>}
box{<0,0,-0.152400><0.787000,0.035000,0.152400> rotate<0,0.000000,0> translate<4.204000,-1.535000,9.309000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.204000,-1.535000,6.908500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,6.108500>}
box{<0,0,-0.152400><1.131371,0.035000,0.152400> rotate<0,44.997030,0> translate<4.204000,-1.535000,6.908500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,6.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,6.108500>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,-90.000000,0> translate<5.004000,-1.535000,6.108500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.991000,-1.535000,7.709000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,7.696000>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,44.997030,0> translate<4.991000,-1.535000,7.709000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,7.709000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,7.696000>}
box{<0,0,-0.152400><0.013000,0.035000,0.152400> rotate<0,-90.000000,0> translate<5.004000,-1.535000,7.696000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.204000,-1.535000,8.509000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,8.509000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,0.000000,0> translate<4.204000,-1.535000,8.509000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.991000,-1.535000,9.309000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,9.322000>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,-44.997030,0> translate<4.991000,-1.535000,9.309000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,9.309000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,9.322000>}
box{<0,0,-0.152400><0.013000,0.035000,0.152400> rotate<0,90.000000,0> translate<5.004000,-1.535000,9.322000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,10.909500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,10.909000>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,-90.000000,0> translate<5.004000,-1.535000,10.909000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<4.204000,-1.535000,10.109500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,10.909500>}
box{<0,0,-0.152400><1.131371,0.035000,0.152400> rotate<0,-44.997030,0> translate<4.204000,-1.535000,10.109500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,6.108500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.016500,-1.535000,6.096000>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,44.997030,0> translate<5.004000,-1.535000,6.108500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,7.696000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.016500,-1.535000,7.683500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,44.997030,0> translate<5.004000,-1.535000,7.696000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,8.509000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.016500,-1.535000,8.509000>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,0.000000,0> translate<5.004000,-1.535000,8.509000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,9.322000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.016500,-1.535000,9.334500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,-44.997030,0> translate<5.004000,-1.535000,9.322000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.004000,-1.535000,10.909500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.016500,-1.535000,10.922000>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,-44.997030,0> translate<5.004000,-1.535000,10.909500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.778500,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.791500,-1.535000,6.109000>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,-44.997030,0> translate<5.778500,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.791500,-1.535000,6.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.804000,-1.535000,6.109000>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,0.000000,0> translate<5.791500,-1.535000,6.109000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.791500,-1.535000,6.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.804000,-1.535000,6.121500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,-44.997030,0> translate<5.791500,-1.535000,6.109000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.804000,-1.535000,6.909000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.804000,-1.535000,6.121500>}
box{<0,0,-0.152400><0.787500,0.035000,0.152400> rotate<0,-90.000000,0> translate<5.804000,-1.535000,6.121500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.778500,-1.535000,10.096500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.804000,-1.535000,10.096500>}
box{<0,0,-0.152400><0.025500,0.035000,0.152400> rotate<0,0.000000,0> translate<5.778500,-1.535000,10.096500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.804000,-1.535000,10.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.804000,-1.535000,10.096500>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,-90.000000,0> translate<5.804000,-1.535000,10.096500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.804000,-1.535000,10.096500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<5.804000,-1.535000,10.909000>}
box{<0,0,-0.152400><0.812500,0.035000,0.152400> rotate<0,90.000000,0> translate<5.804000,-1.535000,10.909000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.604000,-1.535000,6.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.604000,-1.535000,6.096000>}
box{<0,0,-0.152400><0.013000,0.035000,0.152400> rotate<0,-90.000000,0> translate<6.604000,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.604000,-1.535000,6.909000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.604000,-1.535000,6.109000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,-90.000000,0> translate<6.604000,-1.535000,6.109000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.604000,-1.535000,10.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<6.604000,-1.535000,10.909000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,90.000000,0> translate<6.604000,-1.535000,10.909000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.404000,-1.535000,6.909000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.404000,-1.535000,6.121500>}
box{<0,0,-0.152400><0.787500,0.035000,0.152400> rotate<0,-90.000000,0> translate<7.404000,-1.535000,6.121500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.404000,-1.535000,10.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.404000,-1.535000,10.096500>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,-90.000000,0> translate<7.404000,-1.535000,10.096500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.404000,-1.535000,10.096500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.404000,-1.535000,10.909000>}
box{<0,0,-0.152400><0.812500,0.035000,0.152400> rotate<0,90.000000,0> translate<7.404000,-1.535000,10.909000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.404000,-1.535000,6.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.416500,-1.535000,6.109000>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,0.000000,0> translate<7.404000,-1.535000,6.109000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.404000,-1.535000,6.121500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.416500,-1.535000,6.109000>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,44.997030,0> translate<7.404000,-1.535000,6.121500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.416500,-1.535000,6.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.429500,-1.535000,6.096000>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,44.997030,0> translate<7.416500,-1.535000,6.109000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.404000,-1.535000,10.096500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<7.429500,-1.535000,10.096500>}
box{<0,0,-0.152400><0.025500,0.035000,0.152400> rotate<0,0.000000,0> translate<7.404000,-1.535000,10.096500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.204000,-1.535000,6.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.204500,-1.535000,6.109000>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,0.000000,0> translate<8.204000,-1.535000,6.109000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.204000,-1.535000,10.909000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.204500,-1.535000,10.909000>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,0.000000,0> translate<8.204000,-1.535000,10.909000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.204000,-1.535000,7.709000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.979000,-1.535000,7.709000>}
box{<0,0,-0.152400><0.775000,0.035000,0.152400> rotate<0,0.000000,0> translate<8.204000,-1.535000,7.709000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.204000,-1.535000,9.309000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.991500,-1.535000,9.309000>}
box{<0,0,-0.152400><0.787500,0.035000,0.152400> rotate<0,0.000000,0> translate<8.204000,-1.535000,9.309000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.979000,-1.535000,7.709000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,7.734000>}
box{<0,0,-0.152400><0.035355,0.035000,0.152400> rotate<0,-44.997030,0> translate<8.979000,-1.535000,7.709000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,7.709000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,7.734000>}
box{<0,0,-0.152400><0.025000,0.035000,0.152400> rotate<0,90.000000,0> translate<9.004000,-1.535000,7.734000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.204000,-1.535000,8.509000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,8.509000>}
box{<0,0,-0.152400><0.800000,0.035000,0.152400> rotate<0,0.000000,0> translate<8.204000,-1.535000,8.509000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.991500,-1.535000,9.309000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,9.321500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,-44.997030,0> translate<8.991500,-1.535000,9.309000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,9.309000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,9.321500>}
box{<0,0,-0.152400><0.012500,0.035000,0.152400> rotate<0,90.000000,0> translate<9.004000,-1.535000,9.321500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.204500,-1.535000,6.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004500,-1.535000,6.909000>}
box{<0,0,-0.152400><1.131371,0.035000,0.152400> rotate<0,-44.997030,0> translate<8.204500,-1.535000,6.109000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,6.909000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004500,-1.535000,6.909000>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,0.000000,0> translate<9.004000,-1.535000,6.909000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<8.204500,-1.535000,10.909000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004500,-1.535000,10.109000>}
box{<0,0,-0.152400><1.131371,0.035000,0.152400> rotate<0,44.997030,0> translate<8.204500,-1.535000,10.909000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,10.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004500,-1.535000,10.109000>}
box{<0,0,-0.152400><0.000500,0.035000,0.152400> rotate<0,0.000000,0> translate<9.004000,-1.535000,10.109000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004500,-1.535000,6.909000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.017000,-1.535000,6.921500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,-44.997030,0> translate<9.004500,-1.535000,6.909000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,7.734000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.017000,-1.535000,7.747000>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,-44.997030,0> translate<9.004000,-1.535000,7.734000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,8.509000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.017000,-1.535000,8.509000>}
box{<0,0,-0.152400><0.013000,0.035000,0.152400> rotate<0,0.000000,0> translate<9.004000,-1.535000,8.509000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004000,-1.535000,9.321500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.017000,-1.535000,9.334500>}
box{<0,0,-0.152400><0.018385,0.035000,0.152400> rotate<0,-44.997030,0> translate<9.004000,-1.535000,9.321500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.004500,-1.535000,10.109000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<9.017000,-1.535000,10.096500>}
box{<0,0,-0.152400><0.017678,0.035000,0.152400> rotate<0,44.997030,0> translate<9.004500,-1.535000,10.109000> }
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
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.732000,0.000000,7.583000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.732000,0.000000,6.133000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<8.732000,0.000000,6.133000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.032000,0.000000,6.133000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.032000,0.000000,7.583000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<8.032000,0.000000,7.583000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<8.382000,0.000000,7.483000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<8.382000,0.000000,6.233000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<7.149000,-1.536000,3.714000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.599000,-1.536000,3.714000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<7.149000,-1.536000,3.714000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.599000,-1.536000,4.414000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<7.149000,-1.536000,4.414000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<7.149000,-1.536000,4.414000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<7.249000,-1.536000,4.064000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<8.499000,-1.536000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<6.827000,0.000000,7.964000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<6.827000,0.000000,6.514000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<6.827000,0.000000,6.514000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<6.127000,0.000000,6.514000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<6.127000,0.000000,7.964000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<6.127000,0.000000,7.964000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<6.477000,0.000000,7.864000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<6.477000,0.000000,6.614000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.032000,0.000000,9.562000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.032000,0.000000,11.012000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<8.032000,0.000000,11.012000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.732000,0.000000,11.012000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<8.732000,0.000000,9.562000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<8.732000,0.000000,9.562000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<8.382000,0.000000,9.662000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-90.000000,0> translate<8.382000,0.000000,10.912000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<3.466000,0.000000,10.510000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<4.916000,0.000000,10.510000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<3.466000,0.000000,10.510000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<4.916000,0.000000,9.810000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<3.466000,0.000000,9.810000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,0.000000,0> translate<3.466000,0.000000,9.810000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<3.566000,0.000000,10.160000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-0.000000,0> translate<4.816000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<10.699000,-1.536000,8.345000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<10.699000,-1.536000,6.895000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<10.699000,-1.536000,6.895000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<11.399000,-1.536000,6.895000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<11.399000,-1.536000,8.345000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<11.399000,-1.536000,8.345000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<11.049000,-1.536000,8.245000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<11.049000,-1.536000,6.995000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.809000,-1.536000,7.583000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<1.809000,-1.536000,6.133000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,-90.000000,0> translate<1.809000,-1.536000,6.133000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<2.509000,-1.536000,6.133000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<2.509000,-1.536000,7.583000>}
box{<0,0,-0.050800><1.450000,0.036000,0.050800> rotate<0,90.000000,0> translate<2.509000,-1.536000,7.583000> }
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<2.159000,-1.536000,7.483000>}
box{<-0.175000,0,-0.400000><0.175000,0.036000,0.400000> rotate<0,-270.000000,0> translate<2.159000,-1.536000,6.233000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.104000,-1.536000,5.009000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.854000,-1.536000,5.009000>}
box{<0,0,-0.063500><0.750000,0.036000,0.063500> rotate<0,0.000000,0> translate<3.104000,-1.536000,5.009000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.854000,-1.536000,5.009000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.104000,-1.536000,5.009000>}
box{<0,0,-0.063500><6.250000,0.036000,0.063500> rotate<0,0.000000,0> translate<3.854000,-1.536000,5.009000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.104000,-1.536000,5.009000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.104000,-1.536000,12.009000>}
box{<0,0,-0.063500><7.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<10.104000,-1.536000,12.009000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.104000,-1.536000,12.009000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.104000,-1.536000,12.009000>}
box{<0,0,-0.063500><7.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<3.104000,-1.536000,12.009000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.104000,-1.536000,12.009000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.104000,-1.536000,5.759000>}
box{<0,0,-0.063500><6.250000,0.036000,0.063500> rotate<0,-90.000000,0> translate<3.104000,-1.536000,5.759000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.104000,-1.536000,5.759000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.104000,-1.536000,5.009000>}
box{<0,0,-0.063500><0.750000,0.036000,0.063500> rotate<0,-90.000000,0> translate<3.104000,-1.536000,5.009000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.104000,-1.536000,5.759000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.854000,-1.536000,5.009000>}
box{<0,0,-0.063500><1.060660,0.036000,0.063500> rotate<0,44.997030,0> translate<3.104000,-1.536000,5.759000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.623000,0.000000,6.579000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.759000,0.000000,6.579000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.759000,0.000000,6.579000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.759000,0.000000,5.867000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.623000,0.000000,5.867000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.759000,0.000000,5.867000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<3.556000,0.000000,6.223000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-180.000000,0> translate<4.826000,0.000000,6.223000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.759000,0.000000,7.899000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.623000,0.000000,7.899000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.759000,0.000000,7.899000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.623000,0.000000,8.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.759000,0.000000,8.611000>}
box{<0,0,-0.076200><0.864000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.759000,0.000000,8.611000> }
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<4.826000,0.000000,8.255000>}
box{<-0.203200,0,-0.431800><0.203200,0.036000,0.431800> rotate<0,-0.000000,0> translate<3.556000,0.000000,8.255000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  IMU_XZ(-6.985000,0,-8.001000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//C8	22nF	C0603K
//C9	22nF	C0603K
//C10	100nF	C0603K
//C11	100nF	C0603K
//C12	100nF	C0603K
//C13	47nF	C0603K
//C14	22nF	C0603K
//U$1	SOLDER_PAD	SOLDER_PAD
//U$2	SOLDER_PAD	SOLDER_PAD
//U$3	SOLDER_PAD	SOLDER_PAD
