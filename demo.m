% A fast algorithm for computing disk conformal mapping of simply-connected open triangle meshes
%
% Main program: 
% map = disk_conformal_map(v,f)
%
% Input:
% v: nv x 3 vertex coordinates of a simply-connected open triangle mesh
% f: nf x 3 triangulations of a simply-connected open triangle mesh

% Output:
% map: nv x 2 vertex coordinates of the disk conformal parameterization
% 
% If you use this code in your own work, please cite the following paper:
% [1] P. T. Choi and L. M. Lui, 
%     "Fast Disk Conformal Parameterization of Simply-Connected Open Surfaces."
%     Journal of Scientific Computing, 65(3), pp. 1065-1090, 2015.
%
% Copyright (c) 2014-2018, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

addpath('mfile')

%% Example 1: Face

load('human_face.mat');

plot_mesh(v,f); view([0 90]);

map = disk_conformal_map(v,f);

plot_mesh(map,f); view([-90 90]);

% evaluate the angle distortion
angle_distortion(v,f,map);

%% Example 2: Chinese Lion

load('chinese_lion.mat');

% plot_mesh(v,f); view([0 80]);
% can also include the third input if an additional quantity is defined on vertices
plot_mesh(v,f,mean_curv); view([0 80]); 

map = disk_conformal_map(v,f);

% plot_mesh(map,f); view([-180 90]);
% can also include the third input if an additional quantity is defined on vertices
plot_mesh(map,f,mean_curv); view([-180 90]); 

% evaluate the angle distortion
angle_distortion(v,f,map);

%% Example 3: Human Brain

load('human_brain.mat')

% plot_mesh(v,f); view([90 0]);
% can also include the third input if an additional quantity is defined on vertices
plot_mesh(v,f,mean_curv); view([90 0]); 

map = disk_conformal_map(v,f);

% plot_mesh(map,f); 
% can also include the third input if an additional quantity is defined on vertices
plot_mesh(map,f,mean_curv); 

% evaluate the angle distortion
angle_distortion(v,f,map);

%% Example 4: Hand

load('hand.mat')

% plot_mesh(v,f); view([40 70]); 
% can also include the third input if an additional quantity is defined on vertices
plot_mesh(v,f,mean_curv); view([40 70]); 

map = disk_conformal_map(v,f);

% plot_mesh(map,f); view([0 90]);
% can also include the third input if an additional quantity is defined on vertices
plot_mesh(map,f,mean_curv); view([0 90]); 

% evaluate the angle distortion
angle_distortion(v,f,map);