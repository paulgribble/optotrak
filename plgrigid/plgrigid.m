function [rigid,jaw3d] = plgrigid(data,head,jaw)

data = missing_data(data);
markers = size(data,2)/3;
Orientation=zeros(size(data,1),3);
Position=zeros(size(data,1),3);
jaw3d=zeros(size(data,1),12);
for i=1:size(data,1)
	fprintf([13,'%d/%d'],i,size(data,1));
	m = reshape(data(i,:),3,markers)';
	refpt = m(1,:);
	refpt = (refpt'*ones(1,markers))';
	m = m-refpt;
	head_trial = m(1:4,:);
	jaw_trial = m(5:8,:);
	
	% first remove head motion
	[rot,trans]=HornRigid(head_trial,head);
	newjaw = xfrmbdy(jaw_trial,[rot,trans]);
	% now find rigid body trans and rot for jaw
	[rot,trans]=HornRigid(jaw,newjaw);
	Orientation(i,:) = rot;
	Position(i,:) = trans;
	jaw3d(i,:) = reshape(newjaw',1,12);
end; fprintf('\n');

rigid = [Orientation*180/pi,Position];
