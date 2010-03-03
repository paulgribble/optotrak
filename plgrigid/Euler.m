function A = Euler(rot)

s = sin(rot);
c = cos(rot);
B = [1,0,0;0,c(1),s(1);0,-s(1),c(1)]; % roll matrix
C = [c(2),0,-s(2);0,1,0;s(2),0,c(2)]; % pitch matrix
D = [c(3),s(3),0;-s(3),c(3),0;0,0,1]; % yaw matrix
A = B*C*D;
