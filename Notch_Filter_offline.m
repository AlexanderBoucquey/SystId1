clear variables;
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
k = 1;

N2 = 25;
fs2 = 1/N2;
f2 = 0:fs2:fs2*(N-1);
f_cos2 = repmat(cos(f2*2*pi),[1 20]);
f_sin2 = repmat(sin(f2*2*pi),[1 20]);
x = linspace(0, 2*pi, L);
figure()


% Opgave 2.2
Fs = 1;
b = y;
A = [f_cos' f_sin'];
xh = A\b;
Y = fft(A*xh-b);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

% Plot figure
semilogy(f,P1) 
xlim([0 0.1])

title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% In frequentiedomein
b_f = fft(y);
F = 1/N;
H = ones(L,1);
H(F*L+1) = 0;
xh_f = b_f.* H;
P2 = abs(xh_f/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

% Plot figure
figure()
semilogy(f, P1);
xlim([0 0.1])

title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% Opgave 2.3
A_data = [f_cos' f_sin'];
a = A_data(1,:);
x = A_data(1,:)\y(1);
P = eye(2);
A = P*a'/(1+a*P*a');
for i = 1:k
    a = A_data(i,:);
    x = x - A*(a*x-y(i));
    A = P*a'/(1+a*P*a');
    P = P - P*a'*a*P/(1+a*P*a');
    X(i) = norm(xh-x);
end

Y = fft(A_data*x-y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = (0:(L/2))/L;
figure()
semilogy(f, P1);
xlim([0 0.1])

title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
hold on
Y = fft(y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = (0:(L/2))/L;
semilogy(f,P1,'r');
legend('Filtered Signal','Original Signal');

figure();
semilogy(X,'b');
xlabel('$k$');
ylabel('||x_(exact)-x_(estimated)');

% Plot the original signal, the LS frequency filtered signal, the RLS
% filtered signal.
figure()
plot(y,'r');
hold on
plot(y-A_data*xh, 'b');
hold on
plot(y-A_data*x, 'g');
xlim([0 10]);
legend('Original Signal','Offline Filtered Signal', 'Online Filtered Signal', 'Location','northwest');