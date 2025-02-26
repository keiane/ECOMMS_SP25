% ECE 09433 - Lab 2 - Section 0.3
% Spectral Analysis of AM Signals
% Group 3

% Case 1: 
clc; clear; close all;

% initialize parameters for carrier amplitude, message modulation, modulation
% + carrier frequency, sampling frequency, duration, time vector
Ac = 1.2;        
Am = 0.5;    
fm = 1.25e3;      
fc = 6.25e3;     
fs = 200e3; % sample at 200 kHz
T = 1e-3;     
t = 0:1/fs:T;  

% generate signal s(t)
s_t = Ac *(1+Am*cos(2*pi*fm*t)).*cos(2*pi*fc*t);

% add noise to signal according to the snr given
SNR_dB = 0;                            
signal_power = mean(s_t.^2);             
noise_power = signal_power / (10^(SNR_dB/10)); 
noise = sqrt(noise_power) * randn(size(s_t)); 
s_t_noisy = s_t + noise;                 

% plot results (time domain plot for 1ms)
% Noisy time domain of problem 3.3 - 1ms duration
plot(t*1e3, s_t_noisy);
xlabel('Time (ms)');
ylabel('Amplitude');
title(['Noisy Bandpass AM Signal Problem 3.3(SNR = ' num2str(SNR_dB) ' dB)']);
grid on;
xlim([0 1]); 

% fourier transform the AM signal
N = length(s_t);
S_f_clean = abs(fftshift(fft(s_t, N))) / N;  
S_f_noisy = abs(fftshift(fft(s_t_noisy, N))) / N; 
f = linspace(-fs/2, fs/2, N);        

%plot freq spectrum (problem 3.1) 
figure;
plot(f/1e3, S_f_clean);
xlabel('Frequency (kHz)');
ylabel('Magnitude');
title('Frequency Spectrum of AM Signal (Problem 3.1)');
grid on;
lim([-50 50]); 

% plot freq for 3.3
figure;
plot(f/1e3, S_f_noisy);
xlabel('Frequency (kHz)');
ylabel('Magnitude');
title(['Frequency Spectrum of Noisy AM Signal for Problem 3.3 (SNR = ' num2str(SNR_dB) ' dB)']);
grid on;
xlim([-50 50]); 
