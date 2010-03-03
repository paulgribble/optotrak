function [err,g] = rigdxfrm_opt(guess,scan1,scan2)

newscan = xfrmbdy(scan1,guess);

err = newscan-scan2;

err(isnan(err))=0;

err = sum(sum(err.^2));
g=[];
