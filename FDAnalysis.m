clc,clear,close all;


% Message signal parameters
Am = 2; % First Amplitude
fm1 = 5; % First Frequeny
fm2 = 10; % Second Frequency (Hz)
fs = 200; % Sampling Frequency (Hz)
fc = 40; % Carrier Frequency (Hz)
T = 50; % Total Time (s)
t = 0:0.01:50; % time vector


m = Am*sin(2*pi*fm1*t) + Am*sin(2*pi*fm2*t); % We Generated Message Signal (m(t))
s = amDSBSC(m,fc,fs); % We modulated Message signal Using DSB-SC


scope1 = dsp.SpectrumAnalyzer('SampleRate',fs,SpectrumUnits="dBW");
m = m';
scope1(m);

scope2 = dsp.SpectrumAnalyzer('SampleRate',fs,SpectrumUnits="dBW");
scope2(s);

z = amCoDet(s,fc,fs);

scope3 = dsp.SpectrumAnalyzer('SampleRate',fs,SpectrumUnits="dBW");
scope3(z);

PowerofNoise = -3; % Power of noise signal

n = awgn(zeros(size(s)), PowerofNoise, 'measured'); % AWGN signal

% y(t) = s(t) + n(t)
y = s + n; % noise modulated signal

scope4 = dsp.SpectrumAnalyzer('SampleRate',fs,SpectrumUnits="dBW");

scope4(y);

zy = amCoDet(y,fc,fs);

scope5 = dsp.SpectrumAnalyzer('SampleRate',fs,SpectrumUnits="dBW");

scope5(zy);

