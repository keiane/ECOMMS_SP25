% ECE 09433 - Lab 2 - Section 0.1
% Digital Synthesis of Arbitrary Waveforms with Specified SNR
% Group 3

% This program generates a 1-second duration
% Steps 1-5
% A# signal (466.16 Hz) with a specified SNR

% specify SNR in dB
snr = 10;

% generate Original A# signal
fs = 8000; % Sampling frequency (Hz)
t = 0:1/fs:1-1/fs; % Time vector (1 second duration)
s = 0.5 * sin(2 * pi * 466.16 * t); % A# tone

% play the clean signal
sound(s, fs);
pause(1.5); % Pause to allow playback

% compute signal variance correctly
var_s = var(s);

% calculate required noise variance
var_noise = var_s / (10^(snr/10));

% generate Gaussian noise
n = sqrt(var_noise) * randn(size(s));

% create noisy signal
m = s + n;

% play the noisy signal
sound(m, fs);
pause(1.5); % Pause to allow playback

% plot the clean sine wave (full duration)
figure;
plot(t, s);
title('Clean Sinusoidal Waveform');
xlabel('Time');
ylabel('Amplitude');
grid on;

% plot noisy sine wave (SNR = 10 dB)
figure;
plot(t, m);
title('Noisy Waveform (SNR = 10 dB)');
xlabel('Time');
ylabel('Amplitude');
grid on;

% plot zoomed-in clean sine wave (first 10ms)
figure;
plot(t, s);
title('Zoomed Clean Wave (First 10ms)');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0 0.01 -0.6 0.6]); % Zoom into first 10ms

% extract exactly 1 cycle of noisy waveform (Fixed)
T_cycle = 1 / 466.16; % Period of one cycle (seconds)
num_samples = round(T_cycle * fs); % Number of samples in one cycle
t_cycle = t(1:num_samples); % Extract corresponding time values
m_cycle = m(1:num_samples); % Extract corresponding noisy signal values

% plot one full cycle of the noisy waveform
figure;
plot(t_cycle, m_cycle, '-o'); % Add markers to visualize individual points
title('One Cycle of Noisy Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% generate/plot One Cycle of Varied Frequency and Amplitude Signal
A_new = 0.8; % New amplitude
f_new = 750; % New frequency (Hz)
T_cycle_new = 1 / f_new; % Period of one cycle
num_samples_new = round(T_cycle_new * fs); % Number of samples for one cycle
t_cycle_new = t(1:num_samples_new); % Extract time values for one cycle
s_varied = A_new * sin(2 * pi * f_new * t_cycle_new); % One cycle of new sine wave

% compute variance and add noise
var_s_varied = var(s_varied);
var_noise_varied = var_s_varied / (10^(snr/10));
n_varied = sqrt(var_noise_varied) * randn(size(s_varied));
m_varied = s_varied + n_varied; % Noisy signal for one cycle

% plot new noisy waveform for one cycle
figure;
plot(t_cycle_new, m_varied, '-o');
title(['One Cycle of Noisy Waveform with Changed Frequency (' num2str(f_new) ' Hz) and Amplitude (' num2str(A_new) ')']);
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
