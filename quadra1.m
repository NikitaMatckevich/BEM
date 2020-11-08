function [y] = quadra1(f,a,b,w,x)
n = length(w);
y = 0;

cx = 0.5*(b+a);
dx = 0.5*(b-a);

for i=1:n
    y = y + w(i) * f(cx + dx*x(i));
end
y = 0.5*norm(b-a)*y;
end