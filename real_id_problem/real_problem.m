clear variables
close all

% Initialisatie van het probleem. (bepaal input u).
u = randn(1000,1);
index = u<=3;
u = u(index);
index = u>=-3;
u = u(index);
%u=zeros(1000,1);
u(1) = 1;

% Experiment + output (y);
y = exercise2(u);
poly = spline(u,y);

% Preprocessing stap 1: Verwijderen van delay.
cra([y,u]);

% Preprocessing stap 2: Verwijderen pieken).
y = pkshave(y, [-2,2], 1);
save real_problem;