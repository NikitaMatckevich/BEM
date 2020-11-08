function res = findFirstNotIn(array)
prev = 0;
for a = array
    next = a;
    if next - prev > 1
        break;
    end
    prev = next;
end
res = prev + 1;