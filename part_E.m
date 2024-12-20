%PART E CHECK FOR OBSERVABILITY 

clear

x = sym('x');
xDot = sym('xdot');
theta1 = sym("theta1");
theta1Dot = sym("theta1Dot");
theta2 = sym("theta2");
theta2Dot = sym("theta2Dot");
F = sym("F");
M = sym("M");
m1 = sym("m1");
m2 = sym("m2");
l1 = sym("l1");
l2 = sym("l2");
g = sym("g");


A = [0 , 1, 0, 0, 0, 0;
    0, 0, (-g*m1)/M, 0, (-g*m2)/M, 0;
    0, 0, 0, 1, 0, 0;
    0, 0, (-g*(M + m1))/(M*l1), 0, (-g*m2)/(M*l1), 0;
    0, 0, 0, 0, 0, 1;
    0, 0, (-g*m1)/(M*l2), 0, (-g*(M + m2))/(M*l2), 0];

% First Output Vector

C1 = [1, 0, 0, 0, 0, 0];

C1A = C1 * A;

C1_2_A = C1A * A;

C1_3_A = C1_2_A * A;

C1_4_A = C1_3_A * A;

C1_5_A = C1_4_A * A;

O1 = [C1;
      C1A;
      C1_2_A;
      C1_3_A;
      C1_4_A;
      C1_5_A];

disp('rank of output vector [x(t)]:')
disp(rank(O1))

% Second Output Vector

C2 = [0, 0, 1, 0, 0, 0;
      0, 0, 0, 0, 1, 0];

C2A = C2 * A;

C2_2_A = C2A * A;

C2_3_A = C2_2_A * A;

C2_4_A = C2_3_A * A;

C2_5_A = C2_4_A * A;

O2 = [C2;
      C2A;
      C2_2_A;
      C2_3_A;
      C2_4_A;
      C2_5_A];

disp('rank of output vector [theta1(t), theta2(t)]:')
disp(rank(O2))

% Third Output Vector

C3 = [1, 0, 0, 0, 0, 0;
      0, 0, 0, 0, 1, 0];

C3A = C3 * A;

C3_2_A = C3A * A;

C3_3_A = C3_2_A * A;

C3_4_A = C3_3_A * A;

C3_5_A = C3_4_A * A;

O3 = [C3;
      C3A;
      C3_2_A;
      C3_3_A;
      C3_4_A;
      C3_5_A];

disp('rank of output vector [x(t), theta2(t)]:')
disp(rank(O3))

% Fourth Output Vector

C4 = [1, 0, 0, 0, 0, 0;
      0, 0, 1, 0, 0, 0;
      0, 0, 0, 0, 1, 0];

C4A = C4 * A;

C4_2_A = C4A * A;

C4_3_A = C4_2_A * A;

C4_4_A = C4_3_A * A;

C4_5_A = C4_4_A * A;

O4 = [C4;
      C4A;
      C4_2_A;
      C4_3_A;
      C4_4_A;
      C4_5_A];

disp('rank of output vector [x(t), theta1(t), theta2(t)]:')
disp(rank(O4))
