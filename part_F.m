% PART F: LUENBERGER OBSERVER

clear

x = sym('x');
xDot = sym('xdot');
theta1 = sym("theta1");
theta1Dot = sym("theta1Dot");
theta2 = sym("theta2");
theta2Dot = sym("theta2Dot");
F = sym("F");

g = 9.8;
M = 1000;
m1 = 100;
m2 = 100;
l1 = 20;
l2 = 10;

q0 = [2 0 deg2rad(17) 0 deg2rad(30) 0];

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


% Define our outputs as x
C1 = [1, 0, 0, 0, 0, 0];

% Define our outputs as x and t2
C3 = [1, 0, 0, 0, 0, 0;
      0, 0, 0, 0, 1, 0];

% Define our outputs as x, t1, and t2
C4 = [1, 0, 0, 0, 0, 0;
     0, 0, 1, 0, 0, 0;
     0, 0, 0, 0, 1, 0];

% Create the state space representation for the linearized system
sys1 = ss(A, B, C1, []);
sys3 = ss(A, B, C3, [0;0]);
sys4 = ss(A, B, C4, [0;0;0]);

% Setting up simulation time initial conditions
t = 0:0.01:50;

% real state i.c.
x0 = [1; 0; pi/2; 0; -pi/10; 0;];
% estimated state i.c.
xhat0 = [0; 0; 0; 0; 0; 0];

% Using lqe to calculate L for observer gain
% Process noise covariance
Q1 = 0.1 * eye(6); 
Q3 = 0.1 * eye(6); 
Q4 = 0.1 * eye(6); 

 % Measurement noise covariance
R1 = 0.01 * eye(1);
R3 = 0.01 * eye(2);
R4 = 0.01 * eye(3); 

% Compute observer gain
[L1, P1, E1] = lqe(A, Q1, C1, Q1, R1);
[L3, P3, E3] = lqe(A, Q3, C3, Q3, R3);
[L4, P4, E4] = lqe(A, Q4, C4, Q4, R4);

% Display results
disp('Observer Gain Matrix L1:');
disp(L1);

disp('Observer Gain Matrix L3:');
disp(L3);

disp('Observer Gain Matrix L4:');
disp(L4);


disp('Eigenvalues of A - L1C (error dynamics):');
disp(E1);

disp('Eigenvalues of A - L3C (error dynamics):');
disp(E3);

disp('Eigenvalues of A - L4C (error dynamics):');
disp(E4);


% Constructing Observer state-space models for Observable output vectors

% Vector 1 [x(t)]
A1_obs = A - (L1 * C1); 
B1_obs = [B, L1];    
D1_obs = 0; 

obs_sys1 = ss(A1_obs, B1_obs, C1, D1_obs);

% Vector 3 [x(t), theta2(t)]
A3_obs = A - (L3 * C3); 
B3_obs = [B, L3];    
D3_obs = 0; 

obs_sys3 = ss(A3_obs, B3_obs, C3, D3_obs);

% Vector 4 [x(t), theta_1(t), theta2(t)]
A4_obs = A - (L4 * C4); 
B4_obs = [B, L4];    
D4_obs = 0; 

obs_sys4 = ss(A4_obs, B4_obs, C4, D4_obs);


% Creating U for intial condition simualtions (no control input)
u1 = zeros(size(t));
u3 = zeros(size(t));
u4 = zeros(size(t));


% SIMULATION 1: OUTPUT VECTOR 1, WITH ONLY INITIAL CONDITIONS

[y1, t] = initial(sys1, x0, t);
[y1_est, t_est] = lsim(obs_sys1,[u1; y1'], t);


% Plot multiple outputs
figure(1);

plot(t, y1(:, 1), 'LineWidth', 1);  % First output
hold on;
plot(t_est, y1_est(:, 1), 'r--', 'LineWidth', 1);  % First output
title('X')
xlabel('Time (s)');
ylabel('Distance (m)');
legend('X', 'X hat', 'Location', 'best');



% SIMULATION 2: OUTPUT VECTOR 3, WITH ONLY INITIAL CONDITIONS

[y3, t] = initial(sys3, x0, t);
[y3_est, t_est] = lsim(obs_sys3,[u3; y3'], t);


% Plot multiple outputs
figure(2);

subplot(2, 1, 1)
plot(t, y3(:, 1), 'LineWidth', 1);  % First output
hold on;
plot(t_est, y3_est(:, 1), 'r--', 'LineWidth', 1);  % First output
title('X')
xlabel('Time (s)');
ylabel('Distance (m)');
legend('X', 'X hat', 'Location', 'best');

subplot(2, 1, 2)
plot(t, y3(:, 2), 'LineWidth', 1);  % Second output
hold on;
plot(t_est, y3_est(:, 2), 'r--', 'LineWidth', 1);  % Second output
title('Theta 2')
xlabel('Time (s)');
ylabel('Angle (rad)');
legend('Theta2', 'Theta2 hat', 'Location', 'best');

% SIMULATION 3: OUTPUT VECTOR 1, WITH ONLY INITIAL CONDITIONS

[y4, t] = initial(sys4, x0, t);
[y4_est, t_est] = lsim(obs_sys4,[u4; y4'], t);


% Plot multiple outputs
figure(3);

subplot(3, 1, 1)
plot(t, y4(:, 1), 'LineWidth', 1);  % First output
hold on;
plot(t_est, y4_est(:, 1), 'r--', 'LineWidth', 1);  % First output
title('X')
xlabel('Time (s)');
ylabel('Distance (m)');
legend('X', 'X hat', 'Location', 'best');

subplot(3, 1, 2)
plot(t, y4(:, 2), 'LineWidth', 1);  % Second output
hold on;
plot(t_est, y4_est(:, 2), 'r--', 'LineWidth', 1);  % Second output
title('Theta 1')
xlabel('Time (s)');
ylabel('Angle (rad)');
legend('Theta1', 'Theta1 hat', 'Location', 'best');

subplot(3, 1, 3)
plot(t, y4(:, 3), 'LineWidth', 1);  % Third Output
hold on;
plot(t_est, y4_est(:, 3), 'r--', 'LineWidth', 1);  % Second output
title('Theta 2')
xlabel('Time (s)');
ylabel('Angle (rad)');
legend('Theta2', 'Theta2 hat', 'Location', 'best');


% SIMULATION 4: OUTPUT VECTOR 1, WITH STEP 

[y1, t] = step(sys1, t);
[y1_est, t_est] = lsim(obs_sys1,[u1; y1'], t);


% Plot multiple outputs
figure(4);

plot(t, y1(:, 1), 'LineWidth', 1);  % First output
hold on;
plot(t_est, y1_est(:, 1), 'r--', 'LineWidth', 1);  % First output
title('X')
xlabel('Time (s)');
ylabel('Distance (m)');
legend('X', 'X hat', 'Location', 'best');



% SIMULATION 5: OUTPUT VECTOR 3, WITH STEP

[y3, t] = step(sys3, t);
[y3_est, t_est] = lsim(obs_sys3,[u3; y3'], t);

% Plot multiple outputs
figure(5);

subplot(2, 1, 1)
plot(t, y3(:, 1), 'LineWidth', 1);  % First output
hold on;
plot(t_est, y3_est(:, 1), 'r--', 'LineWidth', 1);  % First output
title('X')
xlabel('Time (s)');
ylabel('Distance (m)');
legend('X', 'X hat', 'Location', 'best');

subplot(2, 1, 2)
plot(t, y3(:, 2), 'LineWidth', 1);  % Second output
hold on;
plot(t_est, y3_est(:, 2), 'r--', 'LineWidth', 1);  % Second output
title('Theta 2')
xlabel('Time (s)');
ylabel('Angle (rad)');
legend('Theta2', 'Theta2 hat', 'Location', 'best');

% SIMULATION 6: OUTPUT VECTOR 1, WITH ONLY INITIAL CONDITIONS

[y4, t] = step(sys4, t);
[y4_est, t_est] = lsim(obs_sys4,[u4; y4'], t);


% Plot multiple outputs
figure(6);

subplot(3, 1, 1)
plot(t, y4(:, 1), 'LineWidth', 1);  % First output
hold on;
plot(t_est, y4_est(:, 1), 'r--', 'LineWidth', 1);  % First output
title('X')
xlabel('Time (s)');
ylabel('Distance (m)');
legend('X', 'X hat', 'Location', 'best');

subplot(3, 1, 2)
plot(t, y4(:, 2), 'LineWidth', 1);  % Second output
hold on;
plot(t_est, y4_est(:, 2), 'r--', 'LineWidth', 1);  % Second output
title('Theta 1')
xlabel('Time (s)');
ylabel('Angle (rad)');
legend('Theta1', 'Theta1 hat', 'Location', 'best');

subplot(3, 1, 3)
plot(t, y4(:, 3), 'LineWidth', 1);  % Third Output
hold on;
plot(t_est, y4_est(:, 3), 'r--', 'LineWidth', 1);  % Second output
title('Theta 2')
xlabel('Time (s)');
ylabel('Angle (rad)');
legend('Theta2', 'Theta2 hat', 'Location', 'best');