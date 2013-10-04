#ifndef KALMAN_ROLL_PITCH_H
#define KALMAN_ROLL_PITCH_H

void kalman_roll_pitch_init();
void kalman_roll_pitch_update();

extern float estimator_kalman_phi;
extern float estimator_kalman_theta;

#endif //KALMAN_ROLL_PITCH_H

