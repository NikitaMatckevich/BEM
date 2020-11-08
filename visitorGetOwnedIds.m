function indices = visitorGetOwnedIds(indices, tree, lvlId, colId)

if lvlId > tree.lvlId
    if colId <= 2^(lvlId - tree.lvlId - 1)*(2*tree.colId - 1)
        indices = visitorGetOwnedIds(indices, tree.left, lvlId, colId);
    else
        indices = visitorGetOwnedIds(indices, tree.right, lvlId, colId);
    end
else
    if isempty(tree.indices)
        indices = visitorGetOwnedIds(indices, tree.left, lvlId, colId);
        indices = visitorGetOwnedIds(indices, tree.right, lvlId, colId);
    else
        indices = [indices tree.indices];
    end
end