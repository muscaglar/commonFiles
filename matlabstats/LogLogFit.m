function [ Gradient, Intercept,StdErrors, Y_Fit, r2 ] = LogLogFit( X,Y,  X_fit )
%LOGLOGFIT 

if nargin < 3
    X_fit = X;
end

[ Parameters, StdErrors, Y_Fit, r2] = LineFit( log(X) , log(Y) );

Gradient = Parameters(1);
Intercept = Parameters(2);

end

