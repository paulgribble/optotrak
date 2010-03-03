function x = ellipdisp(C,std,n)

% x = ellipdisp(C,std,n)
%
%     computes 2D dispersion ellipsis from covariance matrix
%     x = ellipdisp(C) returns the matrix x represent the contour for
%     the probability distribution whose covariance matrix is C.  Use
%     plot(x(:,1),x(:,2)) to plot the dispersion ellipsis. 
%
%     x = ellipdisp(C,std)  returns the contour for std multiplied
%     by the standard deviation (default std = 1).
%
%     x = ellipdisp(C,std,n)  specifies the number of points of the contour
%     (default n = 50).

[l,m]=size(C);

if nargin<3
  n = 50;
  if nargin<2
    std = 1.0;
  end
end

[V,D] = eig(C);
th = 0:(2*pi)/(n-1):2*pi;
D = diag(D);
x1 = std*sqrt(D(1))*cos(th);
x2 = std*sqrt(D(2))*sin(th);
x=[x1' x2']*V';

