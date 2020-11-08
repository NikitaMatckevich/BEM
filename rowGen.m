function row = rowGen(iId, jIds)

row = zeros(1, length(jIds));
for j = 1:length(jIds)
    row(1,j) = elemGen(iId, jIds(j));
end