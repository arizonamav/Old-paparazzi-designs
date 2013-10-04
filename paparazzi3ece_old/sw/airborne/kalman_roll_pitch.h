#ifndef KALMAN_ROLL_PITCH_H
#define KALMAN_ROLL_PITCH_H

#ifdef KALMAN_ROLL_PITCH
void kalman_roll_pitch_init(void);
void kalman_roll_pitch_update(void);
inline void kalman_Q_R_init(void);
#endif

/* attitude in radians */
float estimator_kalman_phi;
float estimator_kalman_theta;

/* covariance factors */
float estimator_kalman_q_angle;
float estimator_kalman_q_gyro;
float estimator_kalman_r_angle;

#endif //KALMAN_ROLL_PITCH_H

