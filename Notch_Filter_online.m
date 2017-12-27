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
k = 880

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
    X(i,:) = x;
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
plot(X(:,1),'b');
hold on
plot(X(:,2),'r');
xlabel('$k$');
ylabel('$x_i$');

