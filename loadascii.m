function [nmarkers,nframes,srate,data] = loadascii(fname)

fid=fopen(fname,'r');
l=fgets(fid);
l=fgets(fid);
l=fgets(fid);
l=fgets(fid);
l=fgets(fid);
nmarkers=str2num(l(findstr(l,':')+2:length(l)));
l=fgets(fid);
nsubitems=str2num(l(findstr(l,':')+2:length(l)));
l=fgets(fid);
nframes=str2num(l(findstr(l,':')+2:length(l)));
l=fgets(fid);
srate=str2num(l(findstr(l,':')+2:length(l)));
for i=1:5
  l=fgets(fid);
end;
for i=1:nframes
  l=sscanf(fgets(fid),'%f');
  l=l(2:length(l));
  l=reshape(l,nsubitems,nmarkers)';
  data(i,1:nmarkers,1:nsubitems)=l;
end;
fclose(fid);

