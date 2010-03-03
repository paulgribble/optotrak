function [T,H] = minjerk(H1,H2,t,n)

% [T,H] = minjerk(H1,H2,t,n)
%
% Given hand initial position H1, final position H2 and movement duration t,
% and the total number of desired sampled points n,
% Calculates the hand path H over time T that satisfies minimum-jerk.

T = linspace(0,t,n)';

for i=1:length(T)
	tau = T(i)/t;
	H(i,1) = H1(1) + ((H1(1)-H2(1))*(15*tau^4 - 6*tau^5 - 10*tau^3));
	H(i,2) = H1(2) + ((H1(2)-H2(2))*(15*tau^4 - 6*tau^5 - 10*tau^3));
end;
