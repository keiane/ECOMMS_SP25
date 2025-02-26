% ECE 09433 - Lab 2 - Section 0.2
% Fourier Transform Analysis
% Group 3

% this program generates a 1-second duration
% A# signal (466.16 Hz) with a specified SNR

% define parameters
fs = 8000; % sampling frequency (Hz)
t = 0:1/fs:1-1/fs; % time vector (1 second duration)
f_tone = 466.16; % frequency of A# tone
A_tone = 0.5; % amplitude of A# tone
s = A_tone * sin(2 * pi * f_tone * t); % A# tone signal

% extract exactly 1 cycle of the waveform
T_cycle = 1 / f_tone; % period of one cycle (seconds)
num_samples = round(T_cycle * fs); % number of samples in one cycle
t_cycle = t(1:num_samples); % extract corresponding time values
s_cycle = s(1:num_samples); % extract one cycle of the signal

% define SNR values to test
snr_values = [30, 20, 10, 5]; % various SNR levels

% loop through each SNR and generate a new noisy waveform
for i = 1:length(snr_values)
    snr = snr_values(i); % select SNR value

    % compute noise variance for the current SNR
    var_s = var(s_cycle); % compute variance of the signal
    var_noise = var_s / (10^(snr/10)); % compute noise variance
    n_cycle = sqrt(var_noise) * randn(size(s_cycle)); % generate noise

    % create noisy single-cycle signal
    m_cycle = s_cycle + n_cycle;

    % plot noisy single-cycle waveform for this SNR
    figure;
    plot(t_cycle, m_cycle, '-o'); % plot with markers
    title(['One Cycle of Noisy Sinusoidal Waveform (SNR = ' num2str(snr) ' dB)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
end
