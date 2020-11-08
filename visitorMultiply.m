function res = visitorMultiply(HMatrix, tree, b)

res = zeros(size(b,1),1);

for block = HMatrix
    iIndices = visitorGetOwnedIds([], tree, block.xId(1), block.xId(2));
    jIndices = visitorGetOwnedIds([], tree, block.yId(1), block.yId(2));
    if block.isAdmissible
        res(iIndices) = res(iIndices) + block.U *(block.V * b(jIndices,1));
    else
        res(iIndices) = res(iIndices) + block.A * b(jIndices,1);
    end
end