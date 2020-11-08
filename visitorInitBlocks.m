function HMatrix = visitorInitBlocks(HMatrix, tree)

Nblocks = length(HMatrix);

for blockId = 1:Nblocks
    block = HMatrix(blockId);
    iIndices = visitorGetOwnedIds([], tree, block.xId(1), block.xId(2));
    jIndices = visitorGetOwnedIds([], tree, block.yId(1), block.yId(2));
    if HMatrix(blockId).isAdmissible
        [block.U, block.V] = partialACA(iIndices, jIndices);
    else
        block.A = zeros(length(iIndices), length(jIndices));
        for i = 1:length(iIndices)
            block.A(i,:) = rowGen(iIndices(i), jIndices);
        end
    end
    HMatrix(blockId) = block;
end
    
    
    
    

