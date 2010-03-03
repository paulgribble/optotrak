% ExpectedValue:
function E = ExpectedValue(u)
    n = size(u,1);
    d = size(u,2);
    ep = zeros(1,d);
    for i = 1:d
	    ep(i) = sum(u(:,i))/n;
    end
    E = repmat(ep,n,1);
