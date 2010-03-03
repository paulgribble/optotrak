% corrvec:
function out = corrvec(u,v)
    out = Covariance(u,v)/sqrt(Covariance(u,u))/sqrt(Covariance(v,v));

% Covariance:
function cov = Covariance(u,v)
    n = size(u,1);
    uD= (u - ExpectedValue(u));
    vD = (v - ExpectedValue(v));
    cov = InnerProduct(uD,vD)/n;

    % ExpectedValue:
function E = ExpectedValue(u)
    n = size(u,1);
    d = size(u,2);
    ep = zeros(1,d);
    for i = 1:d
	    ep(i) = sum(u(:,i))/n;
    end
    E = repmat(ep,n,1);

% InnerProduct:
function ip = InnerProduct(u,v)
    ip = 0;
    n = size(u,1);
    for i = 1:n
	    ip = ip + dot(u(i,:),v(i,:));
    end



