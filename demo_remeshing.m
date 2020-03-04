% A simple demo of remeshing a simply-connected open surface via disk
% conformal parameterization
%
% If you use this code in your own work, please cite the following papers:
% (For the parameterization)
% [1] P. T. Choi and L. M. Lui, 
%     "Fast Disk Conformal Parameterization of Simply-Connected Open Surfaces."
%     Journal of Scientific Computing, 65(3), pp. 1065-1090, 2015.
%
% (For the remeshing)
% [2] G. P. T. Choi, Y. Leung-Liu, X. Gu, and L. M. Lui, 
%     "Parallelizable global conformal parameterization of simply-connected surfaces via partial welding."
%     SIAM Journal on Imaging Sciences, 2020.
%
% Copyright (c) 2019-2020, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

addpath('mfile')

%% load data
load('human_face.mat');
plot_mesh(v,f); view([0 90]);

%% disk conformal parameterization

map = disk_conformal_map(v,f);
plot_mesh(map,f); view([-90 90]);

%% remeshing
density = 2;
[v_remeshed,f_remeshed] = remeshing(v,f,map,density);

plot_mesh(v_remeshed,f_remeshed); view([0 90]);