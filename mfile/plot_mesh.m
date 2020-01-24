function plot_mesh(v,f,arg3)
% Plot a mesh.
% 
% Input: 
% v: nv x 3 vertex coordinates
% f: nf x 3 triangulations
% arg3 (optional): nv x 1 quantity defined on vertices

% If you use this code in your own work, please cite the following paper:
% [1] P. T. Choi and L. M. Lui, 
%     "Fast Disk Conformal Parameterization of Simply-Connected Open Surfaces."
%     Journal of Scientific Computing, 65(3), pp. 1065-1090, 2015.
%
% Copyright (c) 2014-2018, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

figure; 
if nargin < 3
    patch('Faces',f,'Vertices',v,'FaceColor',[0.6,1,1],'LineWidth',0.5);

else
    patch('Faces',f,'Vertices',v,'FaceColor','flat','FaceVertexCData',arg3,...
        'EdgeColor','none', 'LineWidth',0.5);
    colormap('Copper');
    shading interp;
    set(gcf,'color','w'); 
    
end
axis equal tight off
ax = gca; ax.Clipping = 'off';