function visitorTreeParser(tree)

if isempty(tree.indices)
    fprintf("-> L:\n");
    visitorParser(tree.left);
    fprintf("-> R:\n");
    visitorParser(tree.right);
else
    disp(tree.indices);
end