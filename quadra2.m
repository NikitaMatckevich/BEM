function [y] = quadra2(f,a,b,c,w,x)
n = length(w);
y = 0;

cx = 0.5*(b+a);
dx = 0.5*(b-a);
for i=1:n
    y = y + 0.25 * norm(b-a) * w(i) * (1 - x(i)) * f(cx + x(i)*dx);
end

cx = 0.5*(a+c);
dx = 0.5*(a-c);
for i=1:n
    y = y + 0.25 * norm(a-c) * w(i) * (1 + x(i)) * f(cx + x(i)*dx);
end

end