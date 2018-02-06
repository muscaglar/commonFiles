function Y = Exponential(X, Param)

Y = Param(1) + Param(2) .* exp( -1 .* X ./ Param(3));

end