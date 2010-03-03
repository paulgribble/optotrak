function [R,T,S,Rmat] = HornRigid(M1,M2)

%  [R,T,S,Rmat] = HornRigid(M1,M2)
%
% finds translation T, rotation R (x,y,z form Euler angles)
% and scaling factor S associated with rigid body transformation
% from body M1 -> M2

[r,c]=size(M1);

% first find scaling factor S

dev1 = detrend(M1,0);
dev2 = detrend(M2,0);
%S = norm(dev2)/norm(dev1);
S = 1;

% now find rotation matrix Rmat and Euler angle vector R

M = dev1'*dev2;

Sxx=M(1,1); Sxy=M(1,2); Sxz=M(1,3);
Syx=M(2,1); Syy=M(2,2); Syz=M(2,3);
Szx=M(3,1); Szy=M(3,2); Szz=M(3,3);

N = [(Sxx+Syy+Szz) Syz-Szy Szx-Sxz Sxy-Syx; ...
     Syz-Szy (Sxx-Syy-Szz) Sxy+Syx Szx+Sxz; ...
     Szx-Sxz Sxy+Syx (-Sxx+Syy-Szz) Syz+Szy; ...
     Sxy-Syx Szx+Sxz Syz+Szy (-Sxx-Syy+Szz)];

%[u,s,v]=svd(N);
%q=v(:,1);
[e,d]=eig(N);
d=diag(d);
[yy,ii]=sort(d);
q=e(:,ii(4));
q0=q(1); qx=q(2); qy=q(3); qz=q(4);

Rmat = [ (q0^2 + qx^2 - qy^2 - qz^2) 2*(qx*qy - q0*qz) 2*(qx*qz + q0*qy); ...
	2*(qy*qx + q0*qz) (q0^2 - qx^2 + qy^2 - qz^2) 2*(qy*qz - q0*qx); ...
	2*(qz*qx - q0*qy) 2*(qz*qy + q0*qx) (q0^2 - qx^2 - qy^2 + qz^2)]';

T=[];

pitch = -asin(Rmat(1,3));
roll = atan2(Rmat(2,3),Rmat(3,3));
yaw = atan2(Rmat(1,2),Rmat(1,1));
R = [roll,pitch,yaw];

% now find translation vector T

T = mean(M2) - (mean(M1)*Rmat).*S;
