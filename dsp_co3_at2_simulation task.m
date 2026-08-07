clc;
clear;
close all;

%% Parameters
N = 8;                     % Number of antennas
theta = -90:0.1:90;        % Observation angles
d = 0.5;                   % Antenna spacing (lambda/2)
steerAngle = 20;           % Beam steering angle

wordLengths = [8 10 12];

%% Ideal Beamforming Weights
n = 0:N-1;

w = exp(-1j*2*pi*d*n'*sind(steerAngle));

% Normalize
w = w/max(abs(w));

%% Ideal Beam Pattern

AF_ideal = zeros(size(theta));

for k=1:length(theta)

    a = exp(1j*2*pi*d*n'*sind(theta(k)));

    AF_ideal(k) = abs(w'*a);

end

AF_ideal = AF_ideal/max(AF_ideal);

figure;
plot(theta,20*log10(AF_ideal),'k','LineWidth',2)
hold on

legendText = {'Ideal'};

fprintf('\n-------------------------------------\n');
fprintf('Quantization Analysis\n');
fprintf('-------------------------------------\n');

%% Loop for Different Word Lengths

for idx=1:length(wordLengths)

    B = wordLengths(idx);

    %% Quantization

    scale = 2^(B-1)-1;

    wr = round(real(w)*scale)/scale;
    wi = round(imag(w)*scale)/scale;

    wq = wr + 1j*wi;

    %% Beam Pattern

    AF = zeros(size(theta));

    for k=1:length(theta)

        a = exp(1j*2*pi*d*n'*sind(theta(k)));

        AF(k)=abs(wq'*a);

    end

    AF = AF/max(AF);

    plot(theta,20*log10(AF),'LineWidth',1.5)

    legendText{end+1}=sprintf('%d-bit',B);

    %% Quantization Error

    qError = norm(w-wq);

    %% Side Lobe Level

    pattern_dB = 20*log10(AF);

    [peak,loc]=max(pattern_dB);

    temp = pattern_dB;

    temp(max(1,loc-20):min(length(temp),loc+20))=-Inf;

    SLL=max(temp);

    fprintf('\nWord Length = %d bits\n',B);
    fprintf('Quantization Error = %.6f\n',qError);
    fprintf('Side Lobe Level = %.2f dB\n',SLL);

end

xlabel('Angle (Degrees)')
ylabel('Normalized Gain (dB)')
title('Beam Pattern Comparison')
grid on
axis([-90 90 -60 5])
legend(legendText)

%% Recommendation

fprintf('\n-------------------------------------\n');
fprintf('Recommendation\n');
fprintf('-------------------------------------\n');

fprintf(['8-bit : Lowest hardware cost but highest error.\n']);
fprintf(['10-bit: Good compromise between accuracy and complexity.\n']);
fprintf(['12-bit: Best beam pattern, lowest error, highest hardware cost.\n']);

fprintf('\nRecommended Word Length = 10 bits for most 5G DSP hardware.\n');