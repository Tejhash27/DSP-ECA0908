clc;
clear;
close all;
%% --- Input Parameters ---
fp = 1000;
% Passband cutoff (Hz)
fs = 4000;
% Sampling frequency (Hz)
N = 50; % Filter order (even number preferred)
wc = fp/(fs/2); % Normalized cutoff frequency (0 to 1)
%% --- FIR Low Pass using Hanning Window ---
b_hann = fir1(N, wc, 'low', hanning(N+1));
disp('--- Hanning Window Coefficients ---');
disp(b_hann');
%% --- Plot Frequency Responses --- figure;
freqz(b_hann,1);
title('Low-pass FIR using Hanning Window');