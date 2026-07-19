clc;
clear;
Fs=10000; Fp=1000; Fst=1500;
[N,Wn]=buttord(Fp/(Fs/2),Fst/(Fs/2),1,60);
[b,a]=butter(N,Wn);


freqz(b,a)       %Magnitude&Phase

figure
[h,n]=impz(b,a,50);
title('Impulse Response')
 

figure
stepz(b,a)


figure
zplane(b,a)


fprintf('Minimum Filter Order (N) = %d\n',N);

fprintf('Cutoff Frequency (Wn) = %.4f\n',Wn); Input

Passband Ripple (Rp) = 1 dB

Stopband Attenuation (Rs) = 20 dB

Passband Frequency (Fp) = 1000 Hz

Stopband Frequency (Fs) = 3000 Hz

Sampling Frequency (Fsampling) = 8000 Hz

Filter Choice = Low-Pass Filter (LPF)