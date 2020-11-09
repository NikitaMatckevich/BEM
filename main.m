function main()

%% === TESTS ===

%M1 = rand(2000, 100);
%M2 = rand(100, 2000);
%M = M1*M2;
%[U,V] = fullACA(M);

%blockInfo.imin = 2;
%blockInfo.imax = 4;
%blockInfo.jmin = 24;
%blockInfo.jmax = 37;
%[U,V] = partialACA(blockInfo);

%% === BEM ===

[perr, uerr, ctime, etime] = BEM();

fprintf("error of p computation = %.5e\n", perr);
fprintf("error of u computation = %.5e\n", uerr);
fprintf("cputime = %.5e\n", ctime);
fprintf("elapsed time = %.5e\n", etime);