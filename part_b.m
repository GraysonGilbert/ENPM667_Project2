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

eq2 = (F - ...
    m1*l1*sin(theta1)*theta1Dot^2 - ...
    m2*l2*sin(theta2)*theta2Dot^2 - ...
    m1*g*cos(theta1)*sin(theta1) - ...
    m2*g*cos(theta2)*sin(theta2) ) / ...
    (M+m1*sin(theta1)^2+m2*sin(theta2)^2);

eq4 = (cos(theta1)/l1) * ...
      ((F - m1*l1*sin(theta1)*theta1Dot^2 - m2*l2*sin(theta2)*theta2Dot^2 - ...
      m1*g*cos(theta1)*sin(theta1) - m2*g*cos(theta2)*sin(theta2))  / ...
      (M+m1*(sin(theta1))^2 + m2*(sin(theta2))^2))  - ...
      (g*sin(theta1)/l1);

eq6 = (cos(theta2)/l2) * ...
      ((F - m1*l1*sin(theta1)*theta1Dot^2 - m2*l2*sin(theta2)*theta2Dot^2 - ...
      m1*g*cos(theta1)*sin(theta1) - m2*g*cos(theta2)*sin(theta2))  / ...
      (M+m1*(sin(theta1))^2 + m2*sin((theta2))^2)) - ...
      (g*sin(theta2)/l2);


deriv = diff(eq6,theta1)

theta1 = 0;
theta1Dot = 0;
theta2 = 0;
theta2Dot = 0;

subs(deriv)