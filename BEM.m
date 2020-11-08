function [perr, uerr, ctime, etime] = BEM()
[~, N, R, k] = coordGen(1);
a = coordGen(0:N-1);

tBegCPU  = cputime;
tBegWALL = tic;
thetar = 0; % direction of solution vector

%% Gauss quadrature
Ng = 2; % nb of points
[witemp, xitemp] = gaussQuad(Ng);

%% p - numerical solution
B = zeros(N,1);
fun = @(x) -exp(-1i*k*x(1,1));
for i=1:N-1
    B(i,1) = quadra1(fun, a(i,:), a(i+1,:), witemp, xitemp);
end
B(N,1) = quadraJessie(fun, a(N,:), a(1,:), witemp, xitemp);

tree = nodePartition(1:N, 0, 1, a, sqrt(N));

eta = 3;
HM = visitorAdmissibility(eta, [], tree, tree, a);

HM = visitorInitBlocks(HM, tree);

visitorHMatrixParser(HM);

max_iter = 20;
tol = 1e-6;
p_numeric = HMgmres(HM, tree, B, zeros(N,1), max_iter, tol);

%p_numeric = A\B;
p_exact = pExactSol(N, k, R);
perr = norm(p_numeric - p_exact)/sqrt(N);

%% u - numerical solution
dr = 0.02*R;
r = (R:dr:5*R)';
Nr = size(r,1);
X = [r*cos(thetar) r*sin(thetar)]; % volume points 
 
mat = zeros(Nr,N);
% TODO: vectorize the loop
for i=1:Nr
    fun = @(y)0.25*1i*besselh(0, k*norm((X(i,:) - y)'));
    mat(i,1) = quadra2(fun, a(1,:), a(2,:), a(N,:), witemp, xitemp);
    for j=2:N-1
        mat(i,j) = quadra2(fun, a(j,:), a(j+1,:), a(j-1,:), witemp, xitemp);
    end
    mat(i,N) = quadra2(fun, a(N,:), a(1,:), a(N-1,:), witemp, xitemp);
end
u_numeric = mat * p_numeric;
u_exact = uExactSol(r, thetar, k, R);
uerr = norm(u_numeric - u_exact);

ctime = cputime - tBegCPU;
etime = toc(tBegWALL);

%% figures
theta = 2*pi*(0:N-1)/N;

figure()
plot(theta, real(p_numeric), "+");
hold on
plot(theta, real(p_exact));
hold off

figure()
plot(theta, imag(p_numeric), "+");
hold on
plot(theta, imag(p_exact));
hold off

figure()
plot(r, real(u_numeric), "+");
hold on
plot(r, real(u_exact));
hold off
