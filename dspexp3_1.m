clc; clear; close all;
% Specifications
Fs=2000; Rp=1; Rs=40;
Wp=[300 600]/(Fs/2);
Ws=[200 700]/(Fs/2);
% Butterworth Filter
[n1,W1]=buttord(Wp,Ws,Rp,Rs); [b1,a1]=butter(n1,W1,'bandpass');
% Chebyshev Type-I Filter
[n2,W2]=cheb1ord(Wp,Ws,Rp,Rs); [b2,a2]=cheby1 (n2,Rp,W2,'bandpass');
% Magnitude Response figure; freqz(b1,a1); title('Butterworth Filter');
figure;
freqz(b2,a2); title('Chebyshev Type-I Filter');
% Group Delay
figure;
grpdelay(b1,a1); hold on;
grpdelay(b2,a2);
legend('Butterworth','Chebyshev-I');
% Pole-Zero Plot
figure;
subplot(121),zplane(b1,a1),title('Butterworth')
subplot(122),zplane(b2,a2),title('Chebyshev-I')
% Impulse Response
figure;
subplot(211),impz(b1,a1),title('Butterworth Impulse')
subplot(212),impz(b2,a2),title('Chebyshev Impulse')
% Pole Magnitude
figure;
subplot(121),stem(abs(roots(a1)),'filled')
title('Butterworth Pole Magnitude')
subplot(122),stem(abs(roots(a2)),'filled')
title('Chebyshev Pole Magnitude')
disp(['Butterworth Order = ',num2str(n1)])
disp(['Chebyshev Order = ',num2str(n2)])