% Demo of extending our proposed disk conformal mapping algorithms for
% further minimizing the area distortion while maintaining the conformality
%
% If you use this code in your own work, please cite the following papers:
% [1] P. T. Choi and L. M. Lui, 
%     "Fast Disk Conformal Parameterization of Simply-Connected Open Surfaces."
%     Journal of Scientific Computing, 65(3), pp. 1065-1090, 2015.
%
% (For mobius_area_correction_disk)
% [2] G. P. T. Choi, Y. Leung-Liu, X. Gu, and L. M. Lui, 
%     "Parallelizable global conformal parameterization of simply-connected surfaces via partial welding."
%     SIAM Journal on Imaging Sciences, 2020.

% Copyright (c) 2014-2020, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

addpath('mfile')
addpath('extension') % contain the codes for area-preserving map

%% load data
load('human_face.mat');
plot_mesh(v,f); view([0 90]); 

%% our disk conformal map method (Choi and Lui, J. Sci. Comput. 2015)
map = disk_conformal_map(v,f);

plot_mesh(map,f); view([-90 90]); title('Disk conformal map')

%% evaluate the angle and area distortion
d = angle_distortion(v,f,map);
a = area_distortion(v,f,map);

fprintf('Mean(angle distortion) = %.4f\n',mean(abs(d)));
fprintf('SD(angle distortion) = %.4f\n',std(abs(d)));
fprintf('Mean(area distortion) = %.4f\n',mean(abs(a)));
fprintf('SD(area distortion) = %.4f\n',std(abs(a)));

%% our disk conformal map method (Choi and Lui, J. Sci. Comput. 2015) together with a Mobius area correction (Choi et al., SIAM J. Imaging Sci. 2020)
map = disk_conformal_map(v,f);
map_mobius_disk = mobius_area_correction_disk(v,f,map);

plot_mesh(map_mobius_disk,f); view([-90 90]); title('Disk conformal map with Mobius area correction')

%% evaluate the angle and area distortion
d = angle_distortion(v,f,map_mobius_disk);
a = area_distortion(v,f,map_mobius_disk);

fprintf('Mean(angle distortion) = %.4f\n',mean(abs(d)));
fprintf('SD(angle distortion) = %.4f\n',std(abs(d)));
fprintf('Mean(area distortion) = %.4f\n',mean(abs(a)));
fprintf('SD(area distortion) = %.4f\n',std(abs(a)));
