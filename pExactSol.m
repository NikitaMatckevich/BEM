function p_exact = pExactSol(N, k, R)

dphi = 2*pi/N;

Nb_modes = 60;
n = -Nb_modes:1:Nb_modes;
der_hankel = 0.5*k*(besselh(n'-1,k*R)-besselh(n'+1,k*R));
p_exact = zeros(N,1);
for ind = 1:N
    p_exact(ind,1) = ((-1i).^n.*(besselj(n,k*R)./besselh(n, k*R)).*...
                       exp(1i*n*dphi*ind))*der_hankel +...
                       1i*k*exp(-1i*k*R*cos(dphi*ind))*cos(dphi*ind);
end

