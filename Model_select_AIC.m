clear all;
close all;
N_est = 1000;
N_val = 10000;
D_est = zeros(N_est);
D_val = zeros(N_val);
sigma_ny = 0.5;
sigma_u0 = 1;
ny = rand(N_est,1);
ny = sigma_ny*ny/std(ny);
[b,a] = cheby1(3,0.5,[2*0.15 2*0.3]);
u0 = randn(N_est,1);
y0 = filter (b,a,u0);
y = y0 + ny;
figure();
freqz(b,a);
ylim([-5,1]);

% Linear Least Squares
for i = 1:N_est
    D_est(i) = y;
end