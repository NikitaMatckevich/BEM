function HM = visitorInitHMatrix(eta, HM, X, Y, coords)

[maxX, minX] = visitorGetMaxMinCoords(X, coords);
diamBoxX = norm(maxX - minX);

[maxY, minY] = visitorGetMaxMinCoords(Y, coords);
diamBoxY = norm(maxY - minY);

distXY = sqrt(sum(max([zeros(1,2); minX - maxY]).^2) + ...
              sum(max([zeros(1,2); minY - maxX]).^2));
          
if min([diamBoxX diamBoxY]) < eta*distXY
    block.isAdmissible = true;
    iIndices = visitorGetOwnedIds([], X, X.lvlId, X.colId);
    jIndices = visitorGetOwnedIds([], Y, Y.lvlId, Y.colId);
    block.A = [];
    [block.U, block.V] = partialACA(iIndices, jIndices);
    block.xId = [X.lvlId X.colId];
    block.yId = [Y.lvlId Y.colId];
    HM = [HM block];
else
    if not(isempty(X.indices) && isempty(Y.indices))
        block.isAdmissible = false;
        iIndices = visitorGetOwnedIds([], X, X.lvlId, X.colId);
        jIndices = visitorGetOwnedIds([], Y, Y.lvlId, Y.colId);
        block.A = zeros(length(iIndices), length(jIndices));
        for i = 1:length(iIndices)
            block.A(i,:) = rowGen(iIndices(i), jIndices);
        end
        block.U = [];
        block.V = [];
        block.xId = [X.lvlId X.colId];
        block.yId = [Y.lvlId Y.colId];
        HM = [HM block];
    else
        HM = visitorAdmissibility(eta, HM, X.left , Y.left , coords);
        HM = visitorAdmissibility(eta, HM, X.left , Y.right, coords);
        HM = visitorAdmissibility(eta, HM, X.right, Y.left , coords);
        HM = visitorAdmissibility(eta, HM, X.right, Y.right, coords);
    end
end