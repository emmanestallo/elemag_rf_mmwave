wire_radius = 0.5;
center_sep = 4;

%define the shape
r1 = [3;4;-6;6;6;-6;-6;-6;6;6];
c1 = [1;-0.5*center_sep;0;wire_radius;zeros(6,1)];
c2 = [1;0.5*center_sep;0;wire_radius;zeros(6,1)];

%obtain the desired shape using set notation
figure
gd = [r1,c1,c2];
ns = char('r1','c1','c2')';
sf = 'r1-c1-c2';
dl = decsg(gd,sf,ns);
pdegplot(dl,'EdgeLabels','on','FaceLabels','on')

%create pde model 
figure
model = createpde;
geometryFromEdges(model,dl);
def_mesh = generateMesh(model);
smaller_mesh = generateMesh(model,'Hmax',0.25);
pdeplot(smaller_mesh)

%apply potential
V1 = 20;
V2 = -0.5;
applyBoundaryCondition(model,'dirichlet','Edge',5:8,'u',V1);
applyBoundaryCondition(model,'dirichlet','Edge',9:12,'u',0);
specifyCoefficients(model,'m',0,'d',0,'c',-1,'a',0,'f',0);

results = solvepde(model);
figure
ux = results.XGradients;
uy = results.YGradients;
pdeplot(model,'XYData',results.NodalSolution,'FlowData',-[ux,uy])










