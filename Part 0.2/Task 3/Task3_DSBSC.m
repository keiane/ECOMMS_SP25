% ECE 09433 - Lab 3
% Task 3: DSB-SC and AM Modulation and Demodulation with Simulink
% Group 3


% This code is for the DSBSC msg Simulink block
Fs = 100000;                  % 100 kHz sampling frequency
t = 0:1/Fs:0.05;              % 50 ms duration
msg = sin(2*pi*1000*t);       % 1 kHz sine wave