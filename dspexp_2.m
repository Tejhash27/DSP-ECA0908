clc; clear;
Wp = 0.4;
Ws = 0.55;
Rp = 1;
As = 40;

[N, Wn] = cheb1ord(Wp, Ws, Rp, As);
[b, a] = cheby1(N, Rp, Wn);

fprintf('Filter Order = %d\n', N);
fprintf('Cutoff Frequency = %.2f pi rad/sample\n', Wn);

if all(abs(roots(a)) < 1)
    disp('System is STABLE');
else
    disp('System is UNSTABLE');
end

figure; freqz(b, a);
figure; impz(b, a);
figure; grpdelay(b, a);
figure; zplane(b, a);