clc;
clear;
close all;
%% --- Input Parameters ---
fp = 1000; % Passband cutoff (Hz)
fs = 4000; % Sampling frequency (Hz)
N = 50; % Filter order (even number preferred)
wc = fp/(fs/2); % Normalized cutoff frequency (0 to 1)
%% --- FIR Low Pass using Hamming Window ---
b_hamm = fir1(N, wc, 'low', hamming(N+1));
disp('--- Hamming Window Coefficients ---');
disp(b_hamm');
%% --- Plot Frequency Responses ---
figure;
freqz(b_hamm,1);
title('Low-pass FIR using Hamming Window');