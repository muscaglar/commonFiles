function y=propnoise(x)
% Random noise whose amplitude is proportional to the amplitude of signal
% zwith white power spectrum with mean zero and unit standard deviation,
% equal in length to x.
% Tom O'Haver, 2012
z=x.*randn(size(x));
sz=std(z);
y=z./sz;