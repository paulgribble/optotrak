function XFM = rigdxfrm(scan1,scan2)

opt=foptions;
opt(1)=1; opt(14)=50000;

guess = zeros(1,6);
d = 1e-12;
vlb = [-pi,-pi,-pi,-Inf,-Inf,-Inf]+d;
vub = [pi,pi,pi,Inf,Inf,Inf]-d;
guess = constr('rigdxfrm_opt',guess,opt,vlb,vub,[],scan1,scan2);
XFM=guess;
