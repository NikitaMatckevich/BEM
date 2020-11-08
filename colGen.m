function col = colGen(jId, iIds)

col = zeros(length(iIds),1);
for i = 1:length(iIds)
    col(i,1) = elemGen(iIds(i),jId);
end