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
u = randn(1000,1);

% Zero input signal
% u = zeros(1000,1);


% Colored noise
% sigma_u = 0.5;
% u = randn(1000,1);
% u = sigma_u*u;
% [b_butter, a_butter] = butter(4,0.2,'high');
% u = filter(b_butter,a_butter,u);

% Sinus wave
% u = sin(2*pi*F*t');

% Step function
% u = ones(1000,1);
%u(1) = 0;

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

% figure()
plot(y,'r');
title('Output signaal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing stap 1: Verwijderen pieken).
y1 = pkshave(y, [25,35], 1);

% Preprocessing stap 3: Laagdoorlaat filter om hoogfrequente ruis
% te elimineren.
b = ones(1,2)/2;
y2 = filtfilt(b,1,y1);

% Preprocessing stap 2: Verwijderen van trends.
y = detrend(y2);

% Bekijk de kwaliteit in mate van standaarddeviatie
arx_std = std(y)/std(u);

figure()
plot(y1,'b');
hold on
plot(y,'r');
legend('pkshave','detrend');
title('Output signaal, gedetrend en pkshaved');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Identificeren van model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

% Verschillende modellen
sysarx = arx_model(u,y);
sysarmax = armax_model(u,y);
sysoe = oe_model(u,y);
sysbj = bj_model(u,y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Valideren van model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Simulatie en Predictie van het model, wanneer de timehorizon 1 is, gaat
% het over een predictie, als er geen tijdshorizon is meegegeven over een
% simulatie.

opt = compareOptions('InitialCondition','e');
figure
compare([y u],sysarx,1,opt);
figure
compare([y u],sysarx, opt);
figure
compare([y u],sysarmax,1,opt);
figure
compare([y u],sysarmax, opt);
figure
compare([y u],sysoe,1,opt);
figure
compare([y u],sysoe, opt);
figure
compare([y u],sysbj,1,opt);
figure
compare([y u],sysbj, opt);

% Residual analyses
figure()
data = iddata(y,u,1);
resid(data,sysarx,'rx',sysarmax, 'gx',sysoe,'bx',sysbj, 'yx');

figure()
data2 = fft(data);
resid(data2,sysarx,'rx',sysarmax, 'gx',sysoe,'bx',sysbj, 'yx');

save real_problem;