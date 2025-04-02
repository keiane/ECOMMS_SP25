% ECE 09433 - Lab 3
% Task 1: DSB-SC Modulation and Demodulation
% Group 3

% define parameters
fs = 10000; % Sampling frequency
t = 0:1/fs:0.1; % Time vector
fm = 50; % Message signal frequency
fc = 500; % Carrier frequency
Am = 1; % Amplitude of message signal
Ac = 1; % Amplitude of carrier signal

% generate baseband message signal and carrier signal
message = Am * cos(2 * pi * fm * t);
carrier = Ac * cos(2 * pi * fc * t);

% DSB-SC modulation
modulated_signal = message .* carrier;

% coherent demodulation
demodulated_signal = modulated_signal .* (2 * carrier); % Multiply by carrier
window_size = 50; % Adjust for better smoothing
demodulated_signal = movmean(demodulated_signal, window_size);

demodulated_signal = demodulated_signal / max(abs(demodulated_signal)); % Normalize output

% frequency domain analysis
N = length(t);
frequencies = (-N/2:N/2-1)*(fs/N);
message_fft = fftshift(abs(fft(message, N)));
carrier_fft = fftshift(abs(fft(carrier, N)));
modulated_fft = fftshift(abs(fft(modulated_signal, N)));
demodulated_fft = fftshift(abs(fft(demodulated_signal, N)));

% plot time-domain signals
figure;
subplot(2,1,1);
plot(t, message); title('Baseband Message Signal'); xlabel('Time (s)'); ylabel('Amplitude');
subplot(2,1,2);
plot(t, carrier); title('Carrier Signal'); xlabel('Time (s)'); ylabel('Amplitude');

figure;
subplot(2,1,1);
plot(t, modulated_signal); title('DSB-SC Modulated Signal'); xlabel('Time (s)'); ylabel('Amplitude');
subplot(2,1,2);
plot(t, demodulated_signal); title('Demodulated Signal'); xlabel('Time (s)'); ylabel('Amplitude');

% plot frequency-domain signals
figure;
subplot(2,1,1);
plot(frequencies, message_fft); title('Baseband Message Signal Spectrum'); xlabel('Frequency (Hz)'); ylabel('Magnitude');
subplot(2,1,2);
plot(frequencies, carrier_fft); title('Carrier Signal Spectrum'); xlabel('Frequency (Hz)'); ylabel('Magnitude');

figure;
subplot(2,1,1);
plot(frequencies, modulated_fft); title('DSB-SC Modulated Signal Spectrum'); xlabel('Frequency (Hz)'); ylabel('Magnitude');
subplot(2,1,2);
plot(frequencies, demodulated_fft); title('Demodulated Signal Spectrum'); xlabel('Frequency (Hz)'); ylabel('Magnitude');
