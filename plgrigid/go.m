% first convert ndigital data files

!opto2ascii c#002.tri tri2.asc % triangle scan
!opto2ascii c#001.cln cln1.asc % clench trial
!opto2ascii c#001.dms dms1.asc % jaw, head marker data during speech

!opto2ascii rig#001.dms rig1.asc % ndigital's solution
% (the rig#001.dms file associated with c#001.dms has been included here
%  so that we can compare our rigid body routine with ndigital's)

% first load the triangle scan and get head rigid body

load tri2.asc
markers = size(tri2,2)/3;
tri2 = missing_data(tri2); % interpolate over missing pts
tri2 = reshape(mean(tri2),3,markers)';
tri_tem(1:4,:) = ones(4,3)*NaN;
tri_tem(5:7,:) = [-37 NaN 78; ...
		  -37 0 NaN; ...
		  -37 NaN 78]; % NaN are "unknown" coordinates to be solved
head_xfm = rigdxfrm(tri2,tri_tem);
head = xfrmbdy(tri2,head_xfm);
head = head(1:4,:) % HEAD RIGID BODY
type head.rig
save head_rig head
save head_xfm head_xfm

% now load the clench file and get jaw rigid body

load cln1.asc
cln1 = missing_data(cln1);
markers = size(cln1,2)/3;
cln1 = reshape(mean(cln1),3,markers)';
cln_tem(1:4,:) = head;
cln_tem(5:8,:) = ones(4,3)*NaN;
jaw_xfm = rigdxfrm(cln1,cln_tem);
jaw = xfrmbdy(cln1,jaw_xfm);
jaw = jaw(5:8,:) % JAW RIGID BODY
type jaw.rig
save jaw_rig jaw
save jaw_xfm jaw_xfm

% now use head and jaw rigid bodies to compute time-varying
% rotations and translations of the jaw relative to the head

load dms1.asc
load head_rig
load jaw_rig
[rigid,jaw3d] = plgrigid(dms1,head,jaw);

load rig1.asc
rig1 = missing_data(rig1);

figure
subplot(2,1,1)
hold on
plot(rig1(:,8:10),'--') % ndigital's solution
plot(rigid(:,1:3),'-') % our solution
subplot(2,1,2)
hold on
plot(rig1(:,11:13),'--') % ndigital's solution
plot(rigid(:,4:6),'-') % our solution

% 3d plot of jaw marker positions
figure
plot3(jaw3d(:,3:3:12),jaw3d(:,2:3:12),jaw3d(:,1:3:12))
grid on
axis equal
rotate3d
