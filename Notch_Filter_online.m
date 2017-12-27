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
x = linspace(0, 2*pi, L);

% Opgave 2.3
