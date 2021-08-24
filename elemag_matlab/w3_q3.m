c_in = [1;-1;0;0.5];
c_out = [1;0;0;2];


gd = [c_in,c_out];
ns = char('c_in','c_out')';
sf = 'c_out-c_in';
dl = decsg(gd,sf,ns);
pdegplot(dl,'EdgeLabels','on','FaceLabels','on')


model=createpde;
geometryFromEdges(model,dl);
smaller_mesh = generateMesh(model,'Hmax',0.20);
pdeplot(smaller_mesh)

V_in = 5;
V_out = -5;
applyBoundaryCondition(model,'dirichlet','Edge',1:4,'u',V_in);
applyBoundaryCondition(model,'dirichlet','Edge',5:8,'u',V_out);
specifyCoefficients(model,'m',0,'d',0,'c',-1,'a',0,'f',0);
results = solvepde(model);

figure
ux = results.XGradients;
uy = results.YGradients;
pdeplot(model,'XYData',results.NodalSolution,'FlowData',-[ux,uy])
axis equal
hold on
plot([-1.6,0,0,-1.6,-1.6], [-0.8,-0.8,0.8,0.8,-0.8],'k--','LineWidth',2);

Nsamp = 500;
query_x = linspace(-1.6, -0.8, Nsamp);
query_y = linspace(-1.6, 0.8, Nsamp);
[Ex, ~] = evaluateGradient(results,query_x, query_y);  
Ex = -Ex;                                               
trapz(query_y, Ex)











