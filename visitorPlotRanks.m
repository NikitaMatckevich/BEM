function compressionRate = visitorPlotRanks(HMatrix, tree)

num = 0;
den = 0;

set(gca, 'YDir','reverse'); % inverted y axis 

for block = HMatrix
    iIndices = sort(visitorGetOwnedIds([], tree, block.xId(1), block.xId(2)));
    jIndices = sort(visitorGetOwnedIds([], tree, block.yId(1), block.yId(2)));
    
    iConsecutive = find(diff(iIndices)==1);
    if length(iConsecutive) ~= length(iIndices)-1
        fprintf("Patch error with i ids:\n");
        disp(iIndices);
        continue;
    end
    
    jConsecutive = find(diff(jIndices)==1);
    if length(jConsecutive) ~= length(jIndices)-1
        fprintf("Patch error with j ids:\n");
        disp(jIndices);
        continue;
    end
    
    x = [jIndices(1), jIndices(end), jIndices(end), jIndices(1)];
    y = [iIndices(end), iIndices(end), iIndices(1), iIndices(1)];
    
    midj = 0.5*(jIndices(1) + jIndices(end));
    midi = 0.5*(iIndices(1) + iIndices(end));
    
    if block.isAdmissible
        rank = size(block.U,2);
        m = size(block.U,1);
        n = size(block.V,2);
        num = num + rank*(m + n);
        den = den + m*n;
        patch(x,y,'green');
        text(midj, midi, string(rank));
    else
        m = size(block.A,1);
        n = size(block.A,2);
        s = m*n;
        num = num + s;
        den = den + s;
        patch(x,y,'red');
    end
end

compressionRate = 1. * num / den;