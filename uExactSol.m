function u_exact = uExactSol(r, thetar, k, R)

Nb_modes = 100;
u_exact = zeros(size(r,2));
for n = -Nb_modes:1:Nb_modes
    vec_hankel = besselh(n,1,k*r);
    cf = (-1i)^n*besselj(n,k*R)/besselh(n,1,k*R);
    u_exact = u_exact - cf*vec_hankel*exp(1i*n*thetar);
end

u_exact = transpose(u_exact);