function [] = mySuperFFT(current, sFreq)

T = 1/sFreq;
L = length(current);

n = 2^nextpow2(L);
dim = 1;
y = fft(current,n,dim);
P2 = abs(y/n);
P1 = P2(1:(n/2)+1,:);
P1(2:end-1,:) = 2*P1(2:end-1,:);
loglog(0:(sFreq/n):(sFreq/2-sFreq/n),P1(1:n/2,1));

end