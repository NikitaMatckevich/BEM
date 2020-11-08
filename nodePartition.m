function node = nodePartition(indices, lvlId, colId, coordsGlo, Nlist)

node.lvlId = lvlId;
node.colId = colId;

Nloc = length(indices);

if Nloc <= Nlist
    node.indices = indices;
    %node.nbOwnedNodes = 1;
else
    maxLoc = max(coordsGlo(indices,:));
    minLoc = min(coordsGlo(indices,:));
    
    [~,sep] = max(maxLoc - minLoc);
    xsep = 0.5*(maxLoc(sep) + minLoc(sep));
        
    iLeftLoc = find(coordsGlo(indices,sep) < xsep);
    iRightLoc = 1:Nloc;
    iRightLoc(iLeftLoc) = [];
        
    node.left = nodePartition(indices(iLeftLoc), lvlId + 1, 2*colId - 1,...
                              coordsGlo, Nlist);
    node.right = nodePartition(indices(iRightLoc), lvlId + 1, 2*colId,...
                               coordsGlo, Nlist);
    
    node.indices = [];
    %node.nbOwnedNodes = node.left.nbOwnedNodes + node.right.nbOwnedNodes;
end