function trial = O_process_trial(tm,m,hm,ta,a,ha,opto2table)

s=size(m);
nmarkers=s(2);

for i=1:nmarkers
  mi=squeeze(m(:,i,:));
  % transform to tabletop coordinates
  mi=xfrmbdy(mi,opto2table);
  % filter marker data
  mi=lowpass(mi,hm.frequency,15);
  % compute velocities
  [dum,miv]=gradient(mi,1/hm.frequency);
  % compute tangential velocities
  tvi=sqrt(miv(:,1).^2 + miv(:,2).^2);
  trial.markers(:,i,:)=mi;
  trial.markers_vel(:,i,:)=miv;
  trial.markers_tv(:,i)=tvi;
end;
trial.time_markers=tm;

% filter analog data
a=a(:,1:size(a,2)-1); % exclude digital data
a=bandpass(a,ha.frequency,[30 300]);
a=abs(a);
al=lowpass(a,ha.frequency,50);
trial.analog=a;
trial.analog_lowpass=al;
trial.time_analog=ta;
trial.markerfreq=hm.frequency;
trial.nmarkers=hm.items;
trial.analogfreq=ha.frequency;
trial.nanalog=ha.subitems;

