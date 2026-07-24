clc;clear
Fs=10000;Fp=3000;Fst=2000;
[N,Wn]=buttord(Fp/(Fs/2),Fst/(Fs/2),1,60);
[b,a]=butter(N,Wn,'high');

%Magnitude&Phase
freqz(b,a)

%Impulse Response
figure
[h,n]=impz(b,a,50);
stem(n,h),grid on
title('Impulse Response')

% Step response
figure
grpdelay(b,a)
title('Step Response')

% Group Delay
figure
grpdelay(b,a)
title('Group Delay')

% Pole-Zero Plot
figure
zplane(b,a)
title('Pole-Zero Plot')

fprintf('Minimum Filterr Order(N)=%d\n',N);
fprintf('Cutoff Frequency(Wn)=%.4f\n',Wn);