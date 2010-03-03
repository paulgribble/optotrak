function [T,M,hdr] = O_load_opto(fname)

% [T,M,hdr] = load_opto(fname)

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
M=ones(numframes,items,subitems)*NaN;
for i=1:numframes
  for j=1:items
    for k=1:subitems
      M(i,j,k)=fread(fid,1,'float32');
    end;
  end;
end;

fclose(fid);

hdr.items=items;
hdr.subitems=subitems;
hdr.frequency=frequency;
hdr.numframes=numframes;

T=linspace(0,(numframes-1)/frequency,numframes)';