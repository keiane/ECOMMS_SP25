% ECE 09433 - Lab 2 - Section 0.3
% Spectral Analysis of AM Signals
% Group 3

clc; clear; close all;

% define parameters
fs = 100000;  % Sampling frequency (100 kHz)
T = 0.01;     % Duration (10 ms)
t = 0:1/fs:T-1/fs;  % Time vector

% define AM signal parameters
Ac = 1;       % Carrier amplitude
Am = 0.5;     % Modulation index
fm = 5000;    % Modulating frequency (5 kHz)
fc = 25000;   % Carrier frequency (25 kHz)

% generate AM signal: s(t) = Ac [1 + Am cos(2πfmt)] cos(2πfct)
s_am = Ac * (1 + Am * cos(2 * pi * fm * t)) .* cos(2 * pi * fc * t);

% plot time-domain AM signal
figure;
plot(t, s_am);
title('AM Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% compute FT
S_f = fft(s_am);
N = length(S_f);
f = fs * (-N/2:N/2-1) / N;  % Frequency vector (centered at 0 Hz)

% shift FFT for better visualization
S_magnitude = abs(fftshift(S_f)) / max(abs(S_f)); % Normalize

% plot Frequency Spectrum
figure;
plot(f, S_magnitude);
title('Spectrum of AM Signal');
xlabel('Frequency (Hz)');
ylabel('Normalized Amplitude');
grid on;
xlim([-fc-2*fm fc+2*fm]); % Focus on AM bandwidth

% add noise and analyze signal in time and frequency domain
SNR_dB = 10; % Define SNR
SNR = 10^(SNR_dB/10); % Convert dB to linear scale
sigma_s2 = var(s_am); % Compute signal power
sigma_n2 = sigma_s2 / SNR; % Compute required noise power
sigma_n = sqrt(sigma_n2); % Noise standard deviation

n = sigma_n * randn(size(t)); % Generate Gaussian noise
s_noisy = s_am + n; % Add noise

% plot time-domain noisy AM signal
figure;
plot(t, s_noisy);
title(['Noisy AM Signal with SNR = ', num2str(SNR_dB), ' dB']);
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% compute and plot frequency spectrum of noisy AM signal
S_f_noisy = fft(s_noisy);
S_magnitude_noisy = abs(fftshift(S_f_noisy)) / max(abs(S_f_noisy));

figure;
plot(f, S_magnitude_noisy);
title(['Spectrum of Noisy AM Signal (SNR = ', num2str(SNR_dB), ' dB)']);
xlabel('Frequency (Hz)');
ylabel('Normalized Amplitude');
grid on;
xlim([-fc-2*fm fc+2*fm]);

% experiment with various values for fm, fc, and SNR
fm_list = [2000, 7000];  % Different modulating frequencies
fc_list = [20000, 30000]; % Different carrier frequencies
SNR_list = [5, 20];       % Different SNR values

for i = 1:length(fm_list)
    for j = 1:length(fc_list)
        for k = 1:length(SNR_list)
            fm = fm_list(i);
            fc = fc_list(j);
            SNR_dB = SNR_list(k);
            
            % Generate new AM signal
            s_am = Ac * (1 + Am * cos(2 * pi * fm * t)) .* cos(2 * pi * fc * t);
            
            % Compute new noise
            SNR = 10^(SNR_dB/10);
            sigma_s2 = var(s_am);
            sigma_n2 = sigma_s2 / SNR;
            sigma_n = sqrt(sigma_n2);
            n = sigma_n * randn(size(t));
            
            % Add noise
            s_noisy = s_am + n;
            
            % Compute FFT
            S_f_noisy = fft(s_noisy);
            S_magnitude_noisy = abs(fftshift(S_f_noisy)) / max(abs(S_f_noisy));
            
            % Plot new spectrum
            figure;
            plot(f, S_magnitude_noisy);
            title(['Spectrum of AM Signal (fm=', num2str(fm), ' Hz, fc=', num2str(fc), ...
                   ' Hz, SNR=', num2str(SNR_dB), ' dB)']);
            xlabel('Frequency (Hz)');
            ylabel('Normalized Amplitude');
            grid on;
            xlim([-fc-2*fm fc+2*fm]);
        end
    end
end

disp('Done.');
