% InnerProduct:
function ip = InnerProduct(u,v)
    ip = 0;
    n = size(u,1);
    for i = 1:n
	    ip = ip + dot(u(i,:),v(i,:));
    end



