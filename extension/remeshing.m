function [v_remeshed,f_remeshed] = remeshing(v,f,map,density)
% Remeshing a simply-connected open surface using the parameterization
%
% v: nv x 3 vertex coordinates of the original mesh
% f: nf x 3 triangulations
% map: nv x 2 coordinates of the parameterization
% density: target mesh density (default: 1)
%
% If you use this code in your own work, please cite the following paper:
% [1] G. P. T. Choi, Y. Leung-Liu, X. Gu, and L. M. Lui, 
%     "Parallelizable global conformal parameterization of simply-connected surfaces via partial welding."
%     SIAM Journal on Imaging Sciences, 2020.
%
% Copyright (c) 2019-2020, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

if nargin < 4
    density = 1;
end

TR = TriRep(f,map); 
B = freeBoundary(TR); 
bdy_index = B(:,1);
z = complex(map(:,1), map(:,2));
z_bdy = z(bdy_index);
% set target edge size
edge_size = mean(abs(z_bdy - z_bdy([2:end,1])))/density;

% generate interior points
[X,Y] = meshgrid(min(real(z_bdy)):edge_size:max(real(z_bdy)), min(imag(z_bdy)):edge_size:max(imag(z_bdy))); 
X(2:2:end,:) = X(2:2:end,:) + edge_size/2; % Shift even rows
X = X(:); Y = Y(:);
newv = find(inpolygon(X,Y,real(z_bdy),imag(z_bdy)));
new_vertices = [X(newv), Y(newv)];

v_new = [real(z_bdy),imag(z_bdy);new_vertices];
if exist('delaunayTriangulation')
    DT = delaunayTriangulation(v_new,[(1:length(z_bdy))',[2:length(z_bdy),1]']);
    f_new = (DT.ConnectivityList);
else DT = DelaunayTri(v_new,[(1:length(z_bdy))',[2:length(z_bdy),1]']);
    f_new = DT.Triangulation;
end

% clean triangles outside the boundary
centroid = (v_new(f_new(:,1),:) + v_new(f_new(:,2),:) + v_new(f_new(:,3),:))/3;
IN2 = ~inpolygon(centroid(:,1), centroid(:,2), real(z_bdy), imag(z_bdy));
f_new(IN2,:) = [];

% interpolant
F1 = TriScatteredInterp(map,v(:,1),'natural');
F2 = TriScatteredInterp(map,v(:,2),'natural');
F3 = TriScatteredInterp(map,v(:,3),'natural');

v_remeshed = zeros(size(v_new,1),3);
v_remeshed(:,1) = F1(v_new(:,1),v_new(:,2));
v_remeshed(:,2) = F2(v_new(:,1),v_new(:,2));
v_remeshed(:,3) = F3(v_new(:,1),v_new(:,2));

f_remeshed = f_new;
