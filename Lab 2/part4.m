% ECE 09433 - Lab 2 - Section 0.4
% Spectral Analysis of a Music Signal
% Group 3

clc; clear; close all;

% load an audio file using uigetfile
[file, path] = uigetfile({'*.wav'}, 'Select an Audio File'); % User selects a WAV file
if isequal(file, 0)
    disp('No file selected. Exiting...');
    return;
end

[audio, fs] = audioread(fullfile(path, file)); % Read audio file
audio = mean(audio, 2); % Convert to mono if stereo

% play original audio
disp('Playing original music...');
sound(audio, fs);
pause(length(audio) / fs + 1);

% plot the time-domain waveform
T = length(audio) / fs; % Duration
t = linspace(0, T, length(audio)); % Time vector

figure;
plot(t, audio);
title('Music Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% compute and plot the frequency spectrum
N = length(audio);
f = fs * (-N/2:N/2-1) / N; % Frequency vector

X_f = fft(audio); % Compute FFT
X_magnitude = abs(fftshift(X_f)) / max(abs(X_f)); % Normalize for better visualization

figure;
plot(f, X_magnitude);
title('Magnitude Spectrum of Music Signal');
xlabel('Frequency (Hz)');
ylabel('Normalized Amplitude');
grid on;
xlim([0, fs/2]); % Focus on positive frequencies

% show frequency components
disp('The spectrum shows the dominant frequency components in the music.');

% filter a specific frequency range (e.g., remove frequencies above 5 kHz)
cutoff_freq = 5000; % 5 kHz low-pass filter
[b, a] = butter(6, cutoff_freq / (fs/2), 'low'); % 6th-order Butterworth low-pass filter
filtered_audio = filtfilt(b, a, audio);

% play and plot the filtered signal
disp('Playing filtered music (frequencies above 5 kHz removed)...');
sound(filtered_audio, fs);
pause(length(filtered_audio) / fs + 1);

figure;
plot(t, filtered_audio);
title('Filtered Music Signal (Low-Pass, 5 kHz Cutoff)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% spectrum of the filtered signal
X_f_filtered = fft(filtered_audio);
X_magnitude_filtered = abs(fftshift(X_f_filtered)) / max(abs(X_f_filtered));

figure;
plot(f, X_magnitude_filtered);
title('Magnitude Spectrum of Filtered Music Signal');
xlabel('Frequency (Hz)');
ylabel('Normalized Amplitude');
grid on;
xlim([0, fs/2]);

disp('Done.');
