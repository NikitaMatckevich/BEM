function [maxCoord, minCoord] = visitorGetMaxMinCoords(tree, coords)

if isempty(tree.indices)
    [maxLeft, minLeft] = visitorGetMaxMinCoords(tree.left, coords);
    [maxRight, minRight] = visitorGetMaxMinCoords(tree.right, coords);
    maxCoord = max([maxLeft; maxRight]);
    minCoord = min([minLeft; minRight]);
else
    maxCoord = max(coords(tree.indices,:));
    minCoord = min(coords(tree.indices,:));
end