function [map_mobius_disk,x] =  mobius_area_correction_disk(v,f,map)

% Find an optimal Mobius transformation for reducing the area distortion of a disk conformal parameterization using the method in [1].
%
% Input:
% v: nv x 3 vertex coordinates of a simply-connected open triangle mesh
% f: nf x 3 triangulations of a simply-connected open triangle mesh
% map: nv x 2 vertex coordinates of the disk conformal parameterization
% 
% Output:
% map_mobius_disk: nv x 2 vertex coordinates of the updated disk conformal parameterization
% x: the optimal parameters for the Mobius transformation, where
%    f(z) = \frac{z-a}{1-\bar{a} z}
%    x(1): |a| (0 ~ 1)        magnitude of a
%    x(2): arg(a) (0 ~ 2pi)   argument of a
%
% If you use this code in your own work, please cite the following paper:
% [1] G. P. T. Choi, Y. Leung-Liu, X. Gu, and L. M. Lui, 
%     "Parallelizable global conformal parameterization of simply-connected surfaces via partial welding."
%     SIAM Journal on Imaging Sciences, 2020.
%
% Copyright (c) 2019-2020, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

%%
% Compute the area with normalization
area_v = face_area(f,v); area_v = area_v/sum(area_v);

z = complex(map(:,1),map(:,2));

% Function for calculating the area after the Mobius transformation 
area_map = @(x) face_area(f,[real((z-x(1)*exp(1i*x(2)))./(1-conj(x(1)*exp(1i*x(2)))*z)),...
    imag((z-x(1)*exp(1i*x(2)))./(1-conj(x(1)*exp(1i*x(2)))*z))])/...
    sum(face_area(f,[real((z-x(1)*exp(1i*x(2)))./(1-conj(x(1)*exp(1i*x(2)))*z)),...
    imag((z-x(1)*exp(1i*x(2)))./(1-conj(x(1)*exp(1i*x(2)))*z))]));

% objective function: mean(abs(log(area_map./area_v)))
d_area = @(x) finitemean(abs(log(area_map(x)./area_v)));

% Optimization setup
x0 = [0,0]; % initial guess, try something diferent if the result is not good
lb = [0,0]; % lower bound for the parameters
ub = [1,2*pi]; % upper bound for the parameters
options = optimoptions('fmincon','Display','iter');

% Optimization (may further supply gradients for better result, not yet implemented)
x = fmincon(d_area,x0,[],[],[],[],lb,ub,[],options);

% obtain the conformal parameterization with area distortion corrected
fz = (z-x(1)*exp(1i*x(2)))./(1-conj(x(1)*exp(1i*x(2)))*z);
map_mobius_disk = [real(fz), imag(fz)];

end

function fa = face_area(f,v)
% Compute the area of every face of a triangle mesh.
v12 = v(f(:,2),:) - v(f(:,1),:);
v23 = v(f(:,3),:) - v(f(:,2),:);
v31 = v(f(:,1),:) - v(f(:,3),:);

a = sqrt(dot(v12,v12,2));
b = sqrt(dot(v23,v23,2));
c = sqrt(dot(v31,v31,2));

s = (a+b+c)/2;
fa = sqrt(s.*(s-a).*(s-b).*(s-c)); 
end

function m = finitemean(A)
% for avoiding the Inf values caused by division by a very small area
    m = mean(A(isfinite(A)));
end