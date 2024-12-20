% PART D LQR

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


AB = A*B;

A2B = A * AB;

A3B = A * A2B;

A4B = A * A3B;

A5B = A * A4B;

C_AB = [B, AB, A2B, A3B, A4B, A5B];

rank(C_AB)
det(C_AB)

Q = [1, 0, 0, 0, 0, 0;
     0, 5, 0, 0, 0, 0;
     0, 0, 100, 0, 0, 0;
     0, 0, 0, 100, 0, 0;
     0, 0, 0, 0, 100, 0;
     0, 0, 0, 0, 0, 100;];

R = [0.0001];

[K, S, P] = lqr(A, B, Q, R);

K
