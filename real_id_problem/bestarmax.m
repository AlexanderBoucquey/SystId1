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
 u = randn(1000,1);

 [b,a] = butter(4,0.33);

 ul = filter(b,a,u);
index = ul<=3;
ul = ul(index);
index = ul>=-3;
ul = ul(index);
yl=exercise2(ul);
yl1 = pkshave(yl, [25,35], 1);
yl = detrend(yl1);
shift=13;
yl=yl(shift+1:end);
ul=ul(1:end-shift);
sysarxl = armax_model(ul,yl);
figure
pzmap(sysarxl);



[b,a] = butter(4,0.33,'high');
uh = filter(b,a,u);
index = uh<=3;
uh = uh(index);
index = uh>=-3;
uh = uh(index);
yh=exercise2(uh);
figure;
yh1 = pkshave(yh, [25,35], 1);
yh = detrend(yh1);
shift=13;
yh=yh(shift+1:end);
uh=uh(1:end-shift);
sysarxh = armax_model(uh,yh);
figure
pzmap(sysarxh);
% figure
% bode(sysarxl);
[pl,zl]=pzmap(sysarxl);
arx_fitl = sysarxl.Report.Fit.FitPercent;
[ph,zh]=pzmap(sysarxh);
arx_fith = sysarxh.Report.Fit.FitPercent;
% Zero input signal
% u = zeros(1000,1);

% Colored noise
% sigma_u = 0.5;
% u = randn(1000,1);
% u = sigma_u*u;
% [b_butter, a_butter] = butter(4,0.2,'high');
% u = filter(b_butter,a_butter,u);

% Sinus wave
%u = sin(2*pi*F*t');

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
% figure();
% plot(u,'r');
% title('Input signaal');
% hold off

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


% b = ones(1,10)/10;
% 
% y2 = filtfilt(b,1,y1);
% figure
% plot(y);
% Preprocessing stap 3: Verwijderen van trends.
y = detrend(y1);
shift=14;
y=y(shift+1:end);
u=u(1:end-shift);
figure()
plot(y1,'b');
hold on
plot(y,'r');
legend('pkshave','detrend');
title('Output signaal, gedetrend and pkshaved');

% figure()
% plot(y)

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
% figure
% plot(f,P1)
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% xlim([0 100]);
% hold off
% 
% % Verschillende modellen
sysarmax = armax_model(u,y);
% sysarmax = armax_model(u,y);
% sysoe = oe_model(u,y);
% sysbj = bj_model(u,y);

% Kijk na hoe correct deze modellen gefit worden d.m.v. het fit rapport;
arx_fit = sysarmax.Report.Fit.FitPercent;
% armax_fit = sysarmax.Report.Fit.FitPercent;
% oe_fit = sysoe.Report.Fit.FitPercent;
% bj_fit = sysbj.Report.Fit.FitPercent;

% Plot de verschillende opties
% figure()
% fits = [arx_fit armax_fit oe_fit bj_fit];
% bar(fits)
% title('Verschillende fit opties');
% ylabel('Procentuele fitting');
% legend('arx',  'armax', 'oe', 'bj');
figure
pzmap(sysarmax);
figure
bode(sysarmax,sysarxl,sysarxh),legend('white noise input','low pass input','high pass input');
[p,z]=pzmap(sysarmax);
a=angle(p);
save real_problem_2;