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


A = [0 , 1, 0, 0, 0, 0;
    0, 0, (-g*m1)/M, 0, (-g*m2)/M, 0;
    0, 0, 0, 1, 0, 0;
    0, 0, (-g*(M + m1))/(M*l1), 0, (-g*m2)/(M*l1), 0;
    0, 0, 0, 0, 0, 1;
    0, 0, (-g*m1)/(M*l2), 0, (-g*(M + m2))/(M*l2), 0];

eig(A)

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


% create the state space representation for the linearized system
sys = ss(A, B, C4, []);

t = 0:0.01:50;

%     x, xd, t1,  t1d,  t2,  t2d
x0 = [1; 0; pi/2; 0; -pi/10; 0;];

% Simulate and plot the initial condition response
[y, t] = initial(sys, x0, t);


% Plot multiple outputs
figure;

subplot(3, 1, 1)
plot(t, y(:, 1), 'LineWidth', 1);  % First output
title('X')
xlabel('Time (s)');
ylabel('Distance (m)');

subplot(3, 1, 2)
plot(t, y(:, 2), 'LineWidth', 1);  % Second output
title('Theta 1')
xlabel('Time (s)');
ylabel('Angle (rad)');

subplot(3, 1, 3)
plot(t, y(:, 3), 'LineWidth', 1);  % Third Output
title('Theta 2')
xlabel('Time (s)');
ylabel('Angle (rad)');



% Add legend for multiple outputs
%legend('X', 'Theta 1', 'Theta 2', 'Location', 'best');
