function [U,V] = fullACA(A)

tStartWALL = tic;

norm0 = norm(A, 'fro');
normk = norm0;
eps = 1e-10;
iter = 0;

U = [];
V = [];
while normk > eps*norm0
    
    iter = iter + 1;
    
    [val,i] = max(abs(A));
    [~,  j] = max(val);
    i = i(j);
    u = A(:,j);
    v = A(i,:)/A(i,j);
    
    U = [U  u];
    V = [V; v];
    
    A = A - u*v;
    normk = norm(A,'fro');
end

etime = toc(tStartWALL);
fprintf("full ACA converged succesfully\n");
fprintf("\t final iteration = %d\n", iter);
fprintf("\t elapsed time = %5.3e\n", etime);