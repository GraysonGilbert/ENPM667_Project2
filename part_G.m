% PART D LQR

clear

g = 9.8;
M = 1000;
m1 = 100;
m2 = 100;
l1 = 20;
l2 = 10;


A = [0 , 1, 0, 0, 0, 0;
    0, 0, (-g*m1)/M, 0, (-g*m2)/M, 0;
    0, 0, 0, 1, 0, 0;
    0, 0, (-g*(M + m1))/(M*l1), 0, (-g*m2)/(M*l1), 0;
    0, 0, 0, 0, 0, 1;
    0, 0, (-g*m1)/(M*l2), 0, (-g*(M + m2))/(M*l2), 0];

B = [0;
    1/M;
    0;
    1/(M*l1);
    0;
    1/(M*l2)];

% Get all of our states from the system
% only x will be used for kalman filtering/control
% other states used for graphing
C_all = [1, 0, 0, 0, 0, 0;
     0, 1, 0, 0, 0, 0;
     0, 0, 1, 0, 0, 0;
     0, 0, 0, 1, 0, 0;
     0, 0, 0, 0, 1, 0;
     0, 0, 0, 0, 0, 1;];
% create a C matrix for the Kalman filter state model
C_obs = [1, 0, 0, 0, 0, 0;];

D_all = [0; 0; 0; 0; 0; 0];
D_obs = [0];


Q = [1, 0, 0, 0, 0, 0;
     0, 1, 0, 0, 0, 0;
     0, 0, 100, 0, 0, 0;
     0, 0, 0, 100, 0, 0;
     0, 0, 0, 0, 100, 0;
     0, 0, 0, 0, 0, 100;];

R = [0.00001];

[K, S, P] = lqr(A, B, Q, R);


% Define our covariance matrices for process noise (Q) and measurement
% noise (R). (N) is correlation between the two, which we set to 0. For
% SISO system we have scalers instead of matrices for (Q) and (R)
Q = 0.1;
R = 0.0001;
N = 0;


% Initial conditions
x0 = [1; 0; pi/2; 0; -pi/10; 0;];      % Initial system state
x_hat0 = [0; 0; 0; 0; 0; 0;];  % Initial state estimate 










