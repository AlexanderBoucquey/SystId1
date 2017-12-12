clear all;
close all;
% initaliseer de parameters.
N_est = 1000;
N_val = 10000;
K_est = zeros(N_est);
D_est = zeros(N_est);
D_val = zeros(N_val);
sigma_ny = 0.5;
sigma_u0 = 1;
I = 100;

% Maak de noise, de filter co�fficienten, de ingang en uitgangssignalen.
ny_est = rand(N_est,1);
ny_est = sigma_ny*ny_est/std(ny_est);
ny_val = rand(N_val,1);
ny_val = sigma_ny*ny_val/std(ny_val);
[b,a] = cheby1(3,0.5,[2*0.15 2*0.3]);

% Maak signaal voor estimator
u0_est = randn(N_est,1);
y0_est = filter (b,a,u0_est);
y_est = y0_est + ny_est;

% Maak signaal voor validator.
u0_val = randn(N_val,1);
y0_val = filter (b,a,u0_val);
y_val = y0_val + ny_val;
theta = zeros(I,1);

% Plot de filter.
figure();
freqz(b,a);
ylim([-5,1]);

% Stel de matrix G (implus responsie) op.
for j = 1:I
    K_est = toeplitz(u0_est(:,1), [u0_est(1,1) zeros(1,I)] );
end

for j = 1:I
    K_val = toeplitz(u0_val(:,1), [u0_val(1,1) zeros(1,I)] );
end

% Make y_hoed voor I = 1 tot 100.
g_est = K_est\y_est;
g_est = g_est';
g_val = K_val\y_val;
g_val = g_val';
figure()
V_ls = zeros(I,1);
V_aic = zeros(I,1);
for t = 1:I
    yh = filter(g_est(1,1:t),1,u0_est);
    V_ls(t,1) = 0;
    for i = 1:N_est
        V_ls(t,1) = V_ls(t,1) + (y_est(i,1)-yh(i,1))^2;
    end
    V_ls(t,1) = V_ls(t,1)/N_est;
    V_aic(t,1) = V_ls(t,1)*(1+2*t/N_est);
end
 
grid = linspace(1,100);
plot(grid,V_ls(:,1),'--');
hold on
plot(grid,V_aic(:,1),'-');
hold on
V_ls = zeros(I,1);
for t = 1:I
    yh = filter(g_val(1,1:t),1,u0_val);
    V_ls(t,1) = 0;
    for i = 1:N_val
        V_ls(t,1) = V_ls(t,1) + (y_val(i,1)-yh(i,1))^2;
    end
    V_ls(t,1) = V_ls(t,1)/N_val;
end
plot(grid,V_ls(:,1), '-.');
legend('est', 'AIC','val');