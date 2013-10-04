
#include "matrix.h"
#include "kalman_roll_pitch.h"
#include "airframe.h"


#define dt 0.05 //must be exactly same as measurement dt, currently 20Hz
static float H[]={1,0,0,0,1,0};
static float A[]={1,0,-dt,0,1,-dt,0,0,1}; 
static float B[]={dt,0,0,dt,0,0};
float Q[9];
float R[4];
float P_last[9];
float P[9];
float K[6];
float x_[3]={0,0,0};
float x__[3]={0,0,0};
float x_dot[2]={0,0};
float z[2]={0,0};
float tmp9_1[9];
float tmp9_2[9];
float tmp9_3[9];
float tmp6_1[6];
float tmp6_2[6];
//float tmp6_3[6];
float tmp4_1[4];
float tmp4_2[4];
float tmp3_1[3];
float tmp3_2[3];
float tmp2_1[2];
float tmp2_2[2];

/* rates in radians per second */
extern float estimator_p;
extern float estimator_q;


inline void kalman_Q_R_init(void)
{
	diag3x3(estimator_kalman_q_angle, estimator_kalman_q_angle, estimator_kalman_q_gyro,Q);
	diag2x2(estimator_kalman_r_angle,estimator_kalman_r_angle,R);
}

void kalman_roll_pitch_init(void)
{
	float bias=0;
	//get angular velocities
	x_dot[0]=estimator_q;
	x_dot[1]=estimator_p;
	//get angle measurement
	x_[0]=estimator_kalman_theta;
	x_[1]=estimator_kalman_phi;
	x_[2]=bias;
	ones3x3(P_last);
	estimator_kalman_q_angle=KALMAN_Q_ANGLE;
	estimator_kalman_q_gyro=KALMAN_Q_GYRO;
	estimator_kalman_r_angle=KALMAN_R_ANGLE;
	kalman_Q_R_init();
}



void kalman_roll_pitch_update(void)
{
	float det;
	//update covariance matrices
	kalman_Q_R_init();
	//time update
	
	//get angle measurement
	z[0]=estimator_kalman_theta;
	z[1]=estimator_kalman_phi;
	//x__=A*x_+B*x_dot
	mult3x3by3x1(A,x_,tmp3_1);
	mult3x2by2x1(B,x_dot,tmp3_2);
	sum3x1and3x1(tmp3_1,tmp3_2,x__);
	//P=A*P_last*A'+Q
	transpose3x3(A,tmp9_2);
	mult3x3by3x3(A,P_last,tmp9_1);
	mult3x3by3x3(tmp9_1,tmp9_2,tmp9_3);
	sum3x3and3x3(tmp9_3,Q,P);

	//measurement update

	//K=P*H'*inv(H*P*H'+R);
	transpose2x3(H,tmp6_2);
	mult2x3by3x3(H,P,tmp6_1);
	mult2x3by3x2(tmp6_1,tmp6_2,tmp4_1);
	sum2x2and2x2(tmp4_1,R,tmp4_2);
	inv2x2(tmp4_2,tmp4_1,det);
	mult3x3by3x2(P,tmp6_2,tmp6_1);
	mult3x2by2x2(tmp6_1,tmp4_1,K);
	//x_=x__+K*(z-H*x__);
	mult2x3by3x1(H,x__,tmp2_1);
	multconstby2x1(-1,tmp2_1);
	sum2x1and2x1(z,tmp2_1,tmp2_2);
	mult3x2by2x1(K,tmp2_2,tmp3_1);
	sum3x1and3x1(x__,tmp3_1,x_);
	//P_last=(eye(3)-K*H)*P;
	diag3x3(1,1,1,tmp9_1);
	mult3x2by2x3(K,H,tmp9_2);
	multconstby3x3(-1,tmp9_2);
	sum3x3and3x3(tmp9_1,tmp9_2,tmp9_3);
	mult3x3by3x3(tmp9_3,P,P_last);
	//assign output variables
	estimator_kalman_theta=x_[0];
	estimator_kalman_phi=x_[1];
	//get angular velocities for the next iteration
	x_dot[0]=estimator_q;
	x_dot[1]=estimator_p;

}



