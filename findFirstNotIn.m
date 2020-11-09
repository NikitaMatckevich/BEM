function res = findFirstNotIn(array)

array = [0 array];
i = find(diff(array)>1);

if isempty(i)
    res = array(end) + 1;
else
    res = array(i(1)) + 1;
end