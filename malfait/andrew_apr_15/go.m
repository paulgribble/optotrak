function grapho(filename);

load filename.asc
plot3 (filename(:,1), filename(:,2), filename(:,3))
axis equal
