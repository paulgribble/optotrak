function scanout = xfrmbdy(scanin,XFM)

% function scanout = xfrmbdy(scanin,XFM)
% scanin is n x 3 (n markers, 3 coords x,y,z)
%           in optotrak coordinates
% XFM is 1 x 6 row vector of rotations (1:3) and translations (4:6)
% scanout is transformed data

R = XFM(1:3);
T = XFM(4:6);

[r,c]=size(scanin);

scanout = scanin*Euler(R) + (T'*ones(1,r))';
