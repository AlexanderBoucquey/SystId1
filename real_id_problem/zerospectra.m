clear variables
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialisatie van het probleem. (bepaal input u).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ref=[];
%for F=0.01:0.01:50
%for F=0.20
    
%F = 0.5;         % Frequentie
% Fs = 100;      % Sample frequentie
% T = 1/Fs;       % Sample periode
% L = 1000;       % Lengte van signaal
% t = (0:L-1).*T;  % Tijdsvector

L=1000;
 u = zeros(L,1);
y = exercise2(u);

y = pkshave(y, [25,35], 1);


y = detrend(y);
% FFT 
Y = fft(y);
P2 = abs(Y/L);

f = (0:(L-1))./L;
figure
plot(2*pi.*f(1:500),P2(1:500));
ref=[ref;std(y)/std(u);];

%save real_problem;