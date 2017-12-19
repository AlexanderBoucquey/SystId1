clear all
close all
u = randn(1000,1);
index = u<=3;
u = u(index);
index = u>=-3;
u = u(index);
%u=zeros(1000,1);
u(1) = 1;
y = exercise2(u);
poly = spline(u,y);


cra([y,u]);

save real_problem;