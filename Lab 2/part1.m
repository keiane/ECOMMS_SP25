% ECE 09433 - Lab 2 - Section 0.1
% Digital Synthesis of Arbitrary Waveforms with Specified SNR
% Group 3

clc; clear; close all;

% define parameters
fs = 8000;          % Sampling frequency (8 kHz)
T = 1;              % Duration (1 second)
f0 = 466.16;        % A# (466.16 Hz)
t = 0:1/fs:T-1/fs;  % Time vector

% generate clean sinusoidal signal
A = 1;               % Amplitude
s = A * sin(2 * pi * f0 * t);

% compute signal power
sigma_s2 = var(s);   % Power of signal

% compute required noise power for SNR = 10 dB
SNR_dB = 10; 
SNR = 10^(SNR_dB/10); % Convert dB to linear scale
sigma_n2 = sigma_s2 / SNR; % Noise power
sigma_n = sqrt(sigma_n2);  % Noise standard deviation

% generate Gaussian noise
n = sigma_n * randn(size(t));

% add noise to signal
m = s + n;

% plot original and noisy signals
figure;
subplot(2,1,1);
plot(t, s);
title('Original A# (466.16 Hz) Signal');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, m);
title(['Noisy Signal with SNR = ', num2str(SNR_dB), ' dB']);
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% play the signals
disp('Playing original tone...');
sound(s, fs);
pause(2);

disp('Playing noisy tone...');
sound(m, fs);
pause(2);

% Synthesize 1 cycle of noisy waveform
T_one_cycle = 1/f0; % Period of one cycle
t_cycle = 0:1/fs:T_one_cycle-1/fs;
m_cycle = A * sin(2 * pi * f0 * t_cycle) + sigma_n * randn(size(t_cycle));

figure;
plot(t_cycle, m_cycle);
title('One Cycle of Noisy Waveform');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% change frequency and amplitude
A2 = 0.5;           % New amplitude
f2 = 880;           % New frequency
s2 = A2 * sin(2 * pi * f2 * t);
m2 = s2 + sigma_n * randn(size(t));

figure;
plot(t, m2);
title(['Noisy Signal with Different Frequency (', num2str(f2), ' Hz)']);
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% do for different SNRs
SNR_dB_list = [5, 15, 20];
figure;
for i = 1:length(SNR_dB_list)
    SNR_i = 10^(SNR_dB_list(i)/10);
    sigma_n2_i = sigma_s2 / SNR_i;
    sigma_n_i = sqrt(sigma_n2_i);
    n_i = sigma_n_i * randn(size(t));
    m_i = s + n_i;
    
    subplot(length(SNR_dB_list),1,i);
    plot(t, m_i);
    title(['Noisy Signal with SNR = ', num2str(SNR_dB_list(i)), ' dB']);
    xlabel('Time (s)'); ylabel('Amplitude');
    grid on;
end

% repeat for other waveforms
fm = 50;  % Modulating frequency
fc = 500; % Carrier frequency
Ac = 1;   % Amplitude
beta = 5; % Modulation index

s_fm = Ac * cos(2 * pi * fc * t + beta * sin(2 * pi * fm * t));
s_am = Ac * (1 + cos(2 * pi * fm * t)) .* cos(2 * pi * fc * t);

m_fm = s_fm + sigma_n * randn(size(t));
m_am = s_am + sigma_n * randn(size(t));

% AM/FM noise plots
figure;
subplot(2,1,1);
plot(t, m_fm);
title('FM Signal with Noise');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, m_am);
title('AM Signal with Noise');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

disp('Done.');
