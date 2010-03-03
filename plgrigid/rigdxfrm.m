function XFM = rigdxfrm(scan1,scan2)


% Optimization with (Finds a constrained minimum)
% Modifications design to follow the matlab optimization functions upgrade

% modifyed by GGH 03-12-2003
defaultopt = struct('Display','iter','TolX',1e-4,'TolFun',1e-4,...
'TolCon',1e-6,'DiffMinChange',1e-8,'DiffMaxChange',0.1,...
'MaxFunEvals',50000,'MaxIter',50000);
opt=optimset('fmincon');
opt=optimset(opt,defaultopt);

d = 1e-12;
guess = randn(1,6);
vlb = [-pi,-pi,-pi,-Inf,-Inf,-Inf]+d;   
%vlb = [0,-pi,-pi,-Inf,-Inf,-Inf]+d;   % <<<<<<<< changed
vub = [pi,pi,pi,Inf,Inf,Inf]-d;
guess=fmincon('rigdxfrm_opt',guess,[],[],[],[],vlb,vub,[],opt,scan1,scan2);
XFM=guess;


%old PLG version:
%opt=foptions;
%opt(1)=1; opt(14)=50000;
%
%guess = zeros(1,6);
%d = 1e-12;
%vlb = [-pi,-pi,-pi,-Inf,-Inf,-Inf]+d;
%vub = [pi,pi,pi,Inf,Inf,Inf]-d;
%guess = constr('rigdxfrm_opt',guess,opt,vlb,vub,[],scan1,scan2);
%XFM=guess;

