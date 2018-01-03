clear variables
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialisatie van het probleem. (bepaal input u).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = 20;         % Frequentie
Fs = 1000;      % Sample frequentie
T = 1/Fs;       % Sample periode
L = 1000;       % Lengte van signaal
t = (0:L-1)*T;  % Tijdsvector


% White noise
% sigma_u = 0.5;
% u = randn(1000,1);

% Zero input signal
% u = zeros(1000,1);

% Colored noise
sigma_u = 0.5;
u = randn(1000,1);
u = sigma_u*u;
[b_butter, a_butter] = butter(4,0.2,'high');
u = filter(b_butter,a_butter,u);

% Sinus wave
% u = sin(2*pi*F*t');

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
title('Input signaal');
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experiment + output (y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = exercise2(u);
%poly = spline(u,y);

figure()
plot(y,'r');
title('Output signaal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing stap 1: Verwijderen van delay.
% ir = cra([y,u],20,10,1);
% [~,R,~] = cra([y,u]);
% Preprocessing stap 2: Verwijderen pieken).
y1 = pkshave(y, [25,35], 1);

% Preprocessing stap 3: Verwijderen van trends.
y = detrend(y1);


figure()
plot(y1,'b');
hold on
plot(y,'r');
legend('pkshave','detrend');
title('Output signaal, gedetrend en pkshaved');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Identificeren van model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Schat aantal parameters mbv aic
N = L;
I = 900;
grid = linspace(1,I,I);

% Bereken de Toeplitz matrix
for j = 1:I
    K = toeplitz(u(:,1), [u(1,1) zeros(1,I-1)] );
end
g = K\y;
g = g';

% Bereken de Kost functie AIC.
V_ls = zeros(I,1);
V_aic = zeros(I,1);
for t = 1:I
    yh = filter(g(1,1:t),1,u);
    V_ls(t,1) = 0;
    for i = 1:size(yh(:,1))
        V_ls(t,1) = V_ls(t,1) + (y(i,1)-yh(i,1))^2;
    end
    V_aic(t,1) = V_ls(t,1)*(1+2*t/N)/(N*sigma_u^2);
    V_ls(t,1) = V_ls(t,1)/(N*sigma_u^2);
end

figure()
semilogy(grid,V_ls(:,1),'--');
hold on
semilogy(grid,V_aic(:,1),'-');
xlabel('Order');
ylabel('Cost');
xlim([0 I]);
legend('est', 'AIC');
title('Aantal param schatten');
%impulsresponsfunctie
% figure()
% IR = cra([y u]);


% FFT 
Y = fft(y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

% Plot figure
figure
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim([0 100]);
hold off

%verschillende modellen
% sysarx = arx([y u],[ 100 100 0]);
% sysarmax = armax([y u],[10 10 10 0]);
% sysoe = oe([y u], [10 10 0]);
% sysbj = bj([y u],[10 10 10 10 0]);
% save real_problem;