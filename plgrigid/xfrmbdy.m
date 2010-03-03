function scanout = xfrmbdy(scanin,XFM)

R = XFM(1:3);
T = XFM(4:6);

[r,c]=size(scanin);

scanout = scanin*Euler(R) + (T'*ones(1,r))';
