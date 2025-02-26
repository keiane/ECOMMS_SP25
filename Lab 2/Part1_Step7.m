% ECE 09433 - Lab 2 - Section 0.2
% Fourier Transform Analysis
% Group 3

% this script generates the two waveforms described in the lab instructions and applies different SNR levels to them.

% sampling parameters
fs = 8000; % Sampling frequency (Hz)
t = 0:1/fs:1-1/fs; % Time vector (1 second duration)

% define signal parameters
Ac = 0.5;   % carrier amplitude
fm = 100;    % modulation frequency (Hz)
fc = 1000;   % carrier frequency (Hz)
beta = 2;    % modulation index for FM

% define SNR values to test
snr_values = [30, 20, 10, 5]; % Various SNR levels

%loop through each SNR for AM Waveform (a)
for i = 1:length(snr_values)
    snr = snr_values(i); % select SNR value

    % generate AM signal (Waveform a)
    s_AM = Ac * (1 + cos(2 * pi * fm * t)) .* cos(2 * pi * fc * t);

    % extract one cycle based on carrier frequency
    T_cycle_AM = 1 / fc; % period of one cycle
    num_samples_AM = round(T_cycle_AM * fs); % # of samples in one cycle
    t_cycle_AM = t(1:num_samples_AM); % extract corresponding time values
    s_AM_cycle = s_AM(1:num_samples_AM); % extract one cycle of the AM signal

    % compute noise variance
    var_s_AM = var(s_AM_cycle);
    var_noise_AM = var_s_AM / (10^(snr/10));
    n_AM = sqrt(var_noise_AM) * randn(size(s_AM_cycle)); % generate noise

    % create noisy AM signal for one cycle
    m_AM_cycle = s_AM_cycle + n_AM;

    % plot noisy AM waveform for this SNR
    figure;
    plot(t_cycle_AM, m_AM_cycle, '-o');
    title(['One Cycle of Noisy AM (SNR = ' num2str(snr) ' dB)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
end

% loop through each SNR for FM Waveform (b)
for i = 1:length(snr_values)
    snr = snr_values(i); % Select SNR value

    % generate FM signal (Waveform b)
    s_FM = Ac * cos(2 * pi * fc * t + beta * sin(2 * pi * fm * t));

    % extract one cycle based on carrier frequency
    T_cycle_FM = 1 / fc; % period of one cycle
    num_samples_FM = round(T_cycle_FM * fs); % # of samples in one cycle
    t_cycle_FM = t(1:num_samples_FM); % extract corresponding time values
    s_FM_cycle = s_FM(1:num_samples_FM); % extract one cycle of the FM signal

    % compute noise variance
    var_s_FM = var(s_FM_cycle);
    var_noise_FM = var_s_FM / (10^(snr/10));
    n_FM = sqrt(var_noise_FM) * randn(size(s_FM_cycle)); % generate noise

    % create the noisy FM signal for one cycle
    m_FM_cycle = s_FM_cycle + n_FM;

    % plot the noisy FM waveform for this SNR
    figure;
    plot(t_cycle_FM, m_FM_cycle, '-o');
    title(['One Cycle of Noisy FM (SNR = ' num2str(snr) ' dB)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
end
