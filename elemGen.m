function elem = elemGen(i, j)

Ng = 2;
[witemp, xitemp] = gaussQuad(Ng);

[ai,~,~,k] = coordGen([i i+1]);
if i == j
    gam = 0.5772156649;
    tau = (ai(2,:) - ai(1,:))';
    nrm = norm(tau,2);
    tau = tau / nrm;
    fun = @(x)(-1/(2*pi))*(log(norm(ai(2,:) - x))*(ai(2,:) - x)*tau -...
                           log(norm(ai(1,:) - x))*(ai(1,:) - x)*tau -...
                       nrm) + (0.25*1i - 1/(2*pi)*(log(0.5*k) + gam))*nrm;
    elem = quadra1(fun, ai(1,:), ai(2,:), witemp, xitemp);
else
    elem = 0;
    [aj] = coordGen([j j+1]);
    integrals = zeros(1, length(witemp));
    ci = 0.5*(ai(2,:) + ai(1,:));
    di = 0.5*(ai(2,:) - ai(1,:));
    for l = 1:length(witemp)
        bl = ci + xitemp(l)*di;
        fun = @(y)0.25*1i*besselh(0, k*norm(bl - y));
        integrals(l) = quadra1(fun, aj(1,:), aj(2,:), witemp, xitemp);
        elem = elem + witemp(l)*integrals(l);
    end
    elem = norm(di)*elem;
end