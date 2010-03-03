% Covariance:
function cov = Covariance(u,v)
    n = size(u,1);
    uD= (u - ExpectedValue(u));
    vD = (v - ExpectedValue(v));
    cov = InnerProduct(uD,vD)/n;
