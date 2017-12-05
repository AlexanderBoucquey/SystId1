clear all;
close all

r = 41;
N = 20 + floor(r/10*6);
L = 20*N;
y = randn(L,1);
y = y/(std(y));
fs = 1/N;
f = 0:fs:fs*(N-1);
f_cos = repmat(cos(f*2*pi),[1 20]);
f_sin = repmat(sin(f*2*pi),[1 20]);

x = linspace(0, 2*pi, L);
figure()
%plot(x, f_cos(1:N))
%hold on
%plot(x, f_sin(1:N))
%hold off

% Opgave 2.2
Fs = 1;
b = y;
A = [f_cos' f_sin'];
xh = A\b;
plot(x, A*xh-b)
Y = fft(A*xh-b);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
semilogy(f,P1) 
xlim([0 0.1])
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% In frequentiedomein
b_f = fft(y);
H = ones(L,1);
H(N) = 0;
xh_f = b_f.* H;
figure()
P2 = abs(xh_f/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L-1)/2)/L;
semilogy(f, P2);

