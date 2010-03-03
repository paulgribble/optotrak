function M2 = xfmopto2table(M,opto2tablexfm)

s=size(M);
M2=ones(size(M))*NaN;
for i=1:s(2)
  M2(:,i,:)=xfrmbdy(squeeze(M(:,i,:)),opto2tablexfm);
end;
