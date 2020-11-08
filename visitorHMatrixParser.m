function visitorHMatrixParser(HM)

for block = HM
    if block.isAdmissible
        fprintf("admissible\n");
        fprintf("U = \n");
        disp(block.U);
        fprintf("V = \n");
        disp(block.V);
    else
        fprintf("not admissible\n");
        fprintf("A = \n");
        disp(block.A);
    end
    fprintf("X part:\n");
    fprintf("    level  = %d\n", block.xId(1));
    fprintf("    column = %d\n", block.xId(2));
    fprintf("Y part:\n");
    fprintf("    level  = %d\n", block.yId(1));
    fprintf("    column = %d\n", block.yId(2));
    fprintf("\n");
end