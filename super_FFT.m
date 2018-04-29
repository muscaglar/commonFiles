% 
% low = 1076;
% high = 1196;

% t = run22_pl(low:high,1);                                        % Convert To ‘seconds’ From ‘milliseconds’
% v = run22_pl(low:high,2);                                             % Voltage (?)
t = t;
v = x;

L = length(t);
Ts = mean(diff(t));                                     % Sampling Interval (sec)
Fs = 1/Ts;                                              % Sampling Frequency
Fn = Fs/2;                                              % Nyquist Frequency

vc = v - mean(v);                                       % Subtract Mean (‘0 Hz’) Component

FTv = fft(vc)/L;                                        % Fourier Transform
Fv = linspace(0, 1, fix(L/2)+1)*Fn;                     % Frequency Vector (Hz)
Iv = 1:length(Fv);                                      % Index Vector
figure(1)
%plot(Fv, abs(FTv(Iv))*2)
loglog(Fv, abs(FTv(Iv))*2);

grid
xlabel('Frequency (Hz)')
ylabel('Amplitude (V?)')



