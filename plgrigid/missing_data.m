function out = missing_data(in)

[r,c] = size(in);

for i=1:c
	df = [0;diff(in(:,i))];
	f = find(abs(in(:,i))>1e4 | isnan(in(:,i)) | abs(df)>100);
	in(f,i) = ones(size(f))*NaN;

	if ~isempty(f)
		if f(1)==1
			ok = min(find(diff(f)>1))+1;
			if isempty(ok)
				ok = f(length(f))+1;
				in(1:ok,i)=ones(ok,1)*in(ok,i);
				f=f(ok:length(f));
			else
				in(f(1:ok-1),i)=ones(size(1:ok-1))'*in(ok,i);
				f = f(ok:length(f));
			end;
		end;
		
	if ~isempty(f)
		if f(length(f))==size(in,1)
			ok = max(find(diff(f)>1));
			if isempty(ok)
				in(f,i) = ones(size(f))*in(f(1)-1,i);
				f=[];
			else
				in(f(ok+1:length(f)),i)=ones(size(ok+1:length(f)))'*in(f(ok),i);
				f = f(1:ok);
			end;
		end;
 	end;

		while (~isempty(f))
			left = f(1)-1;
			where = find(diff(f)>1);
			if isempty(where)
				right = f(length(f))+1;
			else
				right = f(where(1))+1;
			end;
			if isempty(right)
				right = f(length(f))+1;
				f = [];
			else
				if length(where)>1
					f = f(where(1)+1:length(f));
				elseif length(where)==1
					f = f(where(1)+1:length(f));
				else
					f=[];
				end;
			end;
			if in(left,i)~=in(right,i)
				in(left:right,i) = linspace(in(left,i),in(right,i),right-left+1)';
			else
				in(left:right,i) = ones(right-left+1,1).*in(left,i);
			end;
		end;

	end;
end;
out = in;

