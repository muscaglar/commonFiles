function  [fy,f]=FFT_functions(y,Fs)

if nargin<2
    error(' Sampling frequency is required to sompute (PSD,F(y)) ! ');
end

% In case that the input vector is matrix :  Maping with vect{} .
y=y(:).';
L=length(y);

%  (2^N) :Number of points for computing the FFT 
N=ceil(log2(length(y)));

% FFT 
fy=fft(y,2^N)/(L/2);
%------------------------------------------------
% for length<1000 one can replace fft with function :
% fy=Fast_Fourier_Transform(y,2^N)/(L/2); (line 84)
%------------------------------------------------

% Amplitude adjustment by checking for complex input y 
if isreal(y)==0
    fy=fy/2;
end

% PSD
Power=fy.*conj(fy);
%Phase Angle
phy=angle(fy);

%  Frequency axis
f=(Fs/2^N)*(0:2^(N-1)-1);

%if nargin==4
    
% Figures------------------------------------------------------------------
ff1=figure;
plot(f,Power(1:2^(N-1)),'r'),  xlabel('  Frequency (Hz)'), ylabel(' Magnitude (w)'),
title('  Power Spectral Density'), grid on;
set(ff1,'Name','PSD');

ff2=figure;
plot(f,10*log10(Power(1:2^(N-1))),'r'),  xlabel('  Frequency (Hz)'), ylabel(' Magnitude  (dB)'),
title('  Power Spectral Density, logarithmic scale '), grid on;
set(ff2,'Name','10*log10(PSD)');

ff3=figure;
plot(f,sqrt(Power(1:2^(N-1))),'r'),  xlabel('  Frequency (Hz)'), ylabel('|F(Y)|'),
title('  Amplitude Spectrum'), grid on;
set(ff3,'Name','|F(y)|');


ff4=figure;
plot(f,phy(1:2^(N-1)),'b'), xlabel(' Frequency (Hz)'), ylabel(' arg(F(Y))'),
title(' Phase spectrum'), grid on;
set(ff4,'Name','arg(F(Y))');