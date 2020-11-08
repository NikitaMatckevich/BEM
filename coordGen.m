function [coords, N, R, k] = coordGen(ids)

dens = 40;
R = 1;    % rayon de disque
k = pi/2; % nombre d'onde

N = ceil(dens*2*k*R);
dphi = 2*pi/N;
theta = (ids*dphi)';

coords = R*[cos(theta) sin(theta)];