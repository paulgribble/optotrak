function trialout = O_score_trial(trialin)

trialout=trialin;

% find movement onset and end
tv=trialin.markers_tv(:,1);
ni=size(tv,1);
[yy,ii]=max(tv);
i1=max(find(tv(1:ii)<=yy*.05));
i2=max(find(tv(ii:ni)>=yy*.05))+ii-1;
trialout.movpts = trialin.time_markers([i1 i2]);

% compute some movement parameters
trialout.movtime = trialout.movpts(2)-trialout.movpts(1);
s=size(trialin.markers);
nm=s(2);
for i=1:nm
  mi=squeeze(trialin.markers(:,i,:));
  trialout.movdist(i)=norm(mi(i2,:)-mi(i1,:));
end;
