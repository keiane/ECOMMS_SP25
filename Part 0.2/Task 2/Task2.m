% ECE 09433 - Lab 3
% Task 2: AM Modulation and Demodulation
% Group 3

clc; clear; close all;

% initialize parameters: sampling freq, time, carrier freq, message freq,
% modulation index
fs = 1e4;      
t = 0:1/fs:0.05; 
fc = 500;     
fm = 50;       
mod_index = 1; 

% generate the signals; baseband, carrier, AM modulated form
m_t = cos(2*pi*fm*t); 
carrier = cos(2*pi*fc*t); 
s_t = (1 + mod_index * m_t) .* carrier; 

% Demodulate the signal; use filter, then remove dc offset
demod_signal = abs(s_t); 
[b, a] = butter(5, fm/(fs/2)); 
m_rec = filtfilt(b, a, demod_signal) - mean(demod_signal); 

% frequency representations for all 4 forms, fourier transform the signals
N = length(t);
f = linspace(-fs/2, fs/2, N); 

M_f = abs(fftshift(fft(m_t, N))); % Baseband spectrum
C_f = abs(fftshift(fft(carrier, N))); % Carrier spectrum
S_f = abs(fftshift(fft(s_t, N))); % Modulated spectrum
M_rec_f = abs(fftshift(fft(m_rec, N))); % Demodulated spectrum

% show results

% time domain plots
figure;
subplot(4,1,1);
plot(t, m_t, 'b'); grid on;
title(sprintf('Baseband Signal (Time Domain) for Modulation Index = %.0f%%', mod_index * 100));
xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,2);
plot(t, carrier, 'k'); grid on;
title(sprintf('Carrier Signal (Time Domain) for Modulation Index = %.0f%%', mod_index * 100));
xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,3);
plot(t, s_t, 'r'); grid on;
title(sprintf('Modulated Signal (Time Domain) for Modulation Index = %.0f%%', mod_index * 100));
xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,4);
plot(t, m_rec, 'g'); grid on;
title(sprintf('Demodulated Signal (Time Domain) for Modulation Index = %.0f%%', mod_index * 100));
xlabel('Time (s)'); ylabel('Amplitude');

% frequency plots
figure;
subplot(4,1,1);
plot(f, M_f, 'b'); grid on;
title(sprintf('Baseband Signal (Frequency Domain) for Modulation Index = %.0f%%', mod_index * 100));
xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(4,1,2);
plot(f, C_f, 'k'); grid on;
title(sprintf('Carrier Signal (Frequency Domain) for Modulation Index = %.0f%%', mod_index * 100));
xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(4,1,3);
plot(f, S_f, 'r'); grid on;
title(sprintf('Modulated Signal (Frequency Domain) for Modulation Index = %.0f%%', mod_index * 100));
xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(4,1,4);
plot(f, M_rec_f, 'g'); grid on;
title(sprintf('Demodulated Signal (Frequency Domain) for Modulation Index = %.0f%%', mod_index * 100));
xlabel('Frequency (Hz)'); ylabel('Magnitude');

