clear variables
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialisatie van het probleem. (bepaal input u).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ref=[];
for F=0.01:0.01:50
%for F=0.20
    
%F = 0.5;         % Frequentie
Fs = 100;      % Sample frequentie
T = 1/Fs;       % Sample periode
L = 1000;       % Lengte van signaal
t = (0:L-1).*T;  % Tijdsvector


 u = sin(2*pi*F*t');
% Y = fft(u);
% P2 = abs(Y/L);
% % P1 = P2(1:L/2+1);
% % P1(2:end-1) = 2*P1(2:end-1);
% f = Fs.*(0:(L-1))./L;
% 
% % Plot figure
% figure
% semilogx(f,P2)
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% %xlim([0 100]);
% hold off

%%
% Plot input signal
%figure();
%plot(u,'r');
% title('Input signaal');
% hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experiment + output (y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = exercise2(u);
%poly = spline(u,y);

% figure()
%plot(y,'r');
%title('Output signaal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing stap 1: Verwijderen pieken).
y = pkshave(y, [25,35], 1);

% Preprocessing stap 2: Laagdoorlaat filter om hoogfrequente ruis
% te elimineren.
% b = ones(1,2)/2;
% y2 = filtfilt(b,1,y1);

% Preprocessing stap 3: Verwijderen van trends.
y = detrend(y);

% Preprocessing stap 4: Hoogdoorlaat filter om laagfrequente ruis 
% te elimineren.
% [b,a] = butter(9,25/1000,'high');
% y = filter(b,a,y);

% Bekijk de kwaliteit in mate van standaarddeviatie
arx_std = std(y)/std(u);

% figure()
% plot(y1,'b');
% hold on
% plot(y,'r');
% legend('pkshave','detrend');
% title('Output signaal, gedetrend en pkshaved');
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Identificeren van model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FFT 
Y = fft(y);
P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
f = Fs.*(0:(L-1))./L;

% Plot figure
% figure
% semilogx(f,P2)
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% %xlim([0 100]);
% hold off

% % % Verschillende modellen
% sysarx = arx_model(u,y);
% sysarmax = armax_model(u,y);
% sysoe = oe_model(u,y);
% sysbj = bj_model(u,y);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Valideren van model
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Simulatie en Predictie van het model, wanneer de timehorizon 1 is, gaat
% % het over een predictie, als er geen tijdshorizon is meegegeven over een
% % simulatie.
% 
% opt = compareOptions('InitialCondition','e');
% figure
% compare([y u],sysarx,1,opt);
% figure
% compare([y u],sysarx, opt);
% figure
% compare([y u],sysarmax,1,opt);
% figure
% compare([y u],sysarmax, opt);
% figure
% compare([y u],sysoe,1,opt);
% figure
% compare([y u],sysoe, opt);
% figure
% compare([y u],sysbj,1,opt);
% figure
% compare([y u],sysbj, opt);
% 
% % Residual analyses
% figure()
% data = iddata(y,u,1);
% resid(data,sysarx,'rx',sysarmax, 'gx',sysoe,'bx',sysbj, 'yx');
% 
% figure()
% data2 = fft(data);
% resid(data2,sysarx,'rx',sysarmax, 'gx',sysoe,'bx',sysbj, 'yx');
ref=[ref;std(y)/std(u);];
end
save real_problem;