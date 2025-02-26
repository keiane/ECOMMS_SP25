% ECE 09433 - Lab 2 - Section 0.2
% Fourier Transform Analysis
% Group 3

clc; clear; close all;

% define the continuous-time signal
fs = 1000;   % Sampling frequency (1 kHz)
T = 1;       % Signal duration (1 second)
t = 0:1/fs:T-1/fs;  % Time vector

% define the baseband signal (sum of sinusoids)
f1 = 50;  % First frequency (Hz)
f2 = 150; % Second frequency (Hz)
A1 = 1;   % Amplitude of first sinusoid
A2 = 0.5; % Amplitude of second sinusoid

x_t = A1 * cos(2 * pi * f1 * t) + A2 * cos(2 * pi * f2 * t); % Time-domain signal

% plot the time-domain signal
figure;
plot(t, x_t);
title('Original Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% compute Fourier Transform
X_f = fft(x_t);         % Compute FFT
N = length(X_f);        % Number of points
f = fs * (-N/2:N/2-1) / N;  % Frequency vector (centered at 0 Hz)

% single-sided magnitude spectrum
X_magnitude = abs(fftshift(X_f)) / max(abs(X_f)); % Normalize

% plot the magnitude spectrum
figure;
plot(f, X_magnitude);
title('Magnitude Spectrum of the Signal');
xlabel('Frequency (Hz)');
ylabel('Normalized Amplitude');
grid on;
xlim([-200 200]); % Focus on relevant frequency range

% analytical Fourier Transform using Symbolic Toolbox
syms t_sym;
x_sym = A1 * cos(2 * pi * f1 * t_sym) + A2 * cos(2 * pi * f2 * t_sym);
X_f_analytical = fourier(x_sym);

disp('Analytical Fourier Transform:');
disp(X_f_analytical);

% determine Nyquist Frequency and Sampling Constraints
f_max = max([f1, f2]);   % Highest frequency in the signal
fs_min = 2 * f_max;      % Nyquist Sampling Rate

disp(['Maximum Frequency in the Signal: ', num2str(f_max), ' Hz']);
disp(['Minimum Required Sampling Frequency (Nyquist): ', num2str(fs_min), ' Hz']);

% BONUS PART: inverse FFT
x_reconstructed = ifft(X_f, 'symmetric');

% plot reconstructed signal
figure;
plot(t, x_reconstructed);
title('Reconstructed Signal from Frequency Components');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

disp('Done.');
