clear variables
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialisatie van het probleem. (bepaal input u).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% White noise
u = randn(1000,1);

% Zero input signal
% u = zeros(1000,1);

% Colored noise
% u = randn(1000,1);
% [b_butter, a_butter] = butter(4,0.2,'high');
% u = filter(b_butter,a_butter,u);

% Sinus wave
% F = 20; % Frequentie
% grid = 0:F*2*pi/1000:F*2*pi;
% u = sin(grid);

% Step function
% u = ones(1000,1);
% u(1) = 0;

% Impulse function
% u = zeros(1000,1);
% u(1) = 1;

index = u<=3;
u = u(index);
index = u>=-3;
u = u(index);

% Plot input signal
figure();
plot(u,'r');
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experiment + output (y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = exercise2(u);
%poly = spline(u,y);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing stap 1: Verwijderen van delay.
% ir = cra([y,u],20,10,1);
% [~,R,~] = cra([y,u]);
% Preprocessing stap 2: Verwijderen pieken).
y = pkshave(y, [25,35], 1);

% Preprocessing stap 3: Verwijderen van trends.
y = detrend(y);


hold off;
plot(y,'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Identificeren van model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Schat aantal parameters mbv aic
N = 800;
I = 500;
grid = linspace(1,I,I);

% Bereken de Toeplitz matrix
for j = 1:I
    K = toeplitz(u(:,1), [u(1,1) zeros(1,I)] );
end
g = K\y;
g = g';

% Bereken de Kost functie AIC.
V_ls = zeros(I,1);
V_aic = zeros(I,1);
for t = 1:I
    yh = filter(g(1,1:t),1,u);
    V_ls(t,1) = 0;
    for i = 1:N
        V_ls(t,1) = V_ls(t,1) + (y(i,1)-yh(i,1))^2;
    end
    V_aic(t,1) = V_ls(t,1)*(1+2*t/N)/N;
end

figure()
plot(grid,V_aic(:,1),'-');

save real_problem;