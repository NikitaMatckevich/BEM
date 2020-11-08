function [coords, N, R, k] = coordGen(ids)

dens = 10;
R = 1;    % rayon de disque
k = 2*pi; % nombre d'onde

N = ceil(dens*2*k*R);
dphi = 2*pi/N;
theta = (ids*dphi)';

coords = R*[cos(theta) sin(theta)];