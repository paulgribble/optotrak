% myCorrelation:
function myCor = myCorrelation(u,v)
    myCor = Covariance(u,v)/sqrt(Covariance(u,u))/sqrt(Covariance(v,v));
