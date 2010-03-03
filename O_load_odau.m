function [TA,A,hdr] = O_load_odau(fname)

% [TA,A,hdr] = load_odau(fname)

fid=fopen(fname,'r','ieee-le');
% read the header
filetype=fread(fid,1,'uchar');
items=fread(fid,1,'int16');
subitems=fread(fid,1,'int16');
numframes=fread(fid,1,'int32');
frequency=fread(fid,1,'float32');

disp([fname,': ',num2str(items),' items, ',num2str(subitems),' subitems, ', ...
      num2str(numframes),' frames, at ',num2str(frequency),' Hz']);

% go to beginning of data (end of header)
fseek(fid,256,-1);

% now read marker data
A=ones(numframes,subitems+1)*NaN;
for i=1:numframes
  for k=1:subitems
    A(i,k)=fread(fid,1,'float32');
  end;
  A(i,subitems+1)=fread(fid,1,'int16'); % read digital bytes
end;

fclose(fid);

hdr.subitems=subitems;
hdr.frequency=frequency;
hdr.numframes=numframes;

TA=linspace(0,(numframes-1)/frequency,numframes)';
