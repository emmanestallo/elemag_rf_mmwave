%for a circle
%shape id = 1
%x coordinate of the center 
%y coordinate of the center 
%radius

%for a rectangle 
%shape id = 3
%number of line segments = 4
%x coordinates in counterclockwise order from the bot left
%corresponding y coordinates 

c1 = [1; 0.5; 0.5; 0.2; zeros(6,1)];
c2 = [1; 1.5; 0.5; 0.2; zeros(6,1)];
r = [3; 4; 0; 2; 2; 0; 0; 0; 1; 1;];

gd = [r, c1, c2];

ns = char('r1','c1','c2')';
sf = 'r1-c1-c2';
dl = decsg(gd,sf,ns);

model = createpde;
geometryFromEdges(model,dl);
generateMesh(model);
pdeplot(model);
