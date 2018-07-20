
close all

ref=[];
for F=0.01:0.01:100
%for F=0.20
    
%F = 0.5;         % Frequentie
Fs = 100;      % Sample frequentie
T = 1/Fs;       % Sample periode
L = 1000;       % Lengte van signaal
t = (0:L-1).*T;  % Tijdsvector


 u = sin(2*pi*F*t');
 y=sim(syspoly,u);
 Y = fft(y);
P2 = abs(Y./L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
f = Fs.*(0:(L-1))./L;
ref=[ref;std(y)/std(u);];
end