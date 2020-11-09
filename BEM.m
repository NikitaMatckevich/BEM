function [perr, uerr, ctime, etime] = BEM()

tStartCPU  = cputime;
tStartWALL = tic;

[~, N, R, k] = coordGen(1);
a = coordGen(1:N)';
b = coordGen([2:N 1])';
thetar = 0;
dphi = 2*pi/N;
theta = dphi*(1:N)';
Nb_modes = 60;

%% nb of Gauss points
Ng = 2;

%% get Gauss quadrature coefficients
[w, x] = gaussQuad(Ng);

%% computation of BB
uinc = @(x)exp(-1i*k*x(1));
BB = zeros(N,1);
for i=1:N
    BB(i) = -quadra1(uinc,a(:,i),b(:,i),w,x);
end

%% p numeric

% create binary tree of indices
tree = nodePartition(1:N, 0, 1, a', 10);

% create empty HMatrix using binary tree
eta = 3;
HM = visitorInitHMatrix(eta, [], tree, tree, a');

% create matrix blocks for HM 
% HM = visitorInitBlocks(HM, tree);

% dump info
%visitorHMatrixParser(HM);

% calculate the compression of the storage
compressionRate = visitorPlotRanks(HM, tree);
fprintf("compression rate = %.3e\n", compressionRate);

% inverse H-matrix using gmres
max_iter = 30;
tol = 1e-6;
p_num = HMgmres(HM, tree, BB, zeros(N,1), max_iter, tol);

%% p exact
n = (-Nb_modes:1:Nb_modes);
der_hankel = k*(besselh(n'-1,k*R)-besselh(n'+1,k*R))/2;
p_exa = zeros(N,1);
for ind = 1:N
    p_exa(ind,1) = ((-1i).^n.*(besselj(n,k*R)./besselh(n,1,k*R)).*exp(1i*n*theta(ind)))*der_hankel +...
               1i*k*exp(-1i*k*R*cos(theta(ind)))*cos(theta(ind));
end

perr = norm(p_num - p_exa)/sqrt(N);

%% u numeric
r = R:0.01:5*R;
Nr = size(r,2);
X(1,:) = r*cos(thetar);
X(2,:) = r*sin(thetar);
mat = zeros(Nr,N);
for i=1:Nr
    fun = @(y)1i/4*besselh(0, k*norm(X(:,i) - y));
    for j=1:N
        mat(i,j) = quadra1(fun, a(:,j), b(:,j), w, x);
    end
end
u_num = mat*p_num;

%% u exact
u_exa(1:Nr) = 0;
for n = (-Nb_modes:1:Nb_modes)
    vec_hankel = besselh(n,1,k*r);
    u_exa = u_exa - (-1i)^n*besselj(n,k*R)/besselh(n,1,k*R).*vec_hankel*exp(1i*n*thetar);
end
u_exa = transpose(u_exa);

uerr = norm(u_num - u_exa);

ctime = cputime - tStartCPU;
etime = toc(tStartWALL);

figure()
plot(theta,real(p_num),'*')
hold on
plot(theta,real(p_exa))
hold off

figure()
plot(r, real(u_num),'+');
hold on
plot(r, real(u_exa));
hold off
legend('numeric solution', 'exact solution')

figure()
plot(r, imag(u_num),'+');
hold on
plot(r, imag(u_exa));
hold off
legend('numeric solution', 'exact solution')