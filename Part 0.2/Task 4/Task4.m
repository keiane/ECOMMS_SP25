% ECE 09433 - Lab 3
% Task 4: Multitone Signal to Simulink
% Group 3

fs = 100000;
t = 0:1/fs:0.05;
x = sin(2*pi*1000*t) + 0.5*sin(2*pi*2000*t) + 0.3*sin(2*pi*3000*t);