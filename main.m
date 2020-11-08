function main()

%M1 = rand(2000, 100);
%M2 = rand(100, 2000);
%M = M1*M2;
%[U,V] = fullACA(M);

%blockInfo.imin = 2;
%blockInfo.imax = 4;
%blockInfo.jmin = 24;
%blockInfo.jmax = 37;
%[U,V] = partialACA(blockInfo);

coords = [xGen(1:40) xGen(1:40)];
tree = nodePartition(1:40, 0, 1, coords, 5);

%visitorTreeParser(tree);

eta = 3;
HM = [];
HM = visitorAdmissibility(eta, HM, tree, tree, coords);
visitorHMatrix(HM);

