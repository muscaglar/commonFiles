function [rX,rY] = mySuperFFT(current, T)

sFreq = 1/(T(2)-T(1));

%T = 1/sFreq;
L = length(current);

n = 2^nextpow2(L);
dim = 1;
y = fft(current,n,dim);
P2 = abs(y/n);
P1 = P2(1:(n/2)+1,:);
P1(2:end-1,:) = 2*P1(2:end-1,:);

rX = 0:(sFreq/n):(sFreq/2-sFreq/n);
rY = P1(1:n/2,1);
figure;
plot(rX,rY);

data = [rX',rY];

end


