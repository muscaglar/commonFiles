function [ Parameters, Y_Fit, XValues ] = ExponentialFit( X,Y, XValues )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    XValues = sort(unique(X));
end  

%calc the best fit
Params0 = [min(Y) (max(Y) - min(Y)) 3];
Parameters = fminsearch(@(Params0) ExponentialCost(X,Y,Params0), Params0);

%Now generate the data
Y_Fit = Exponential(XValues, Parameters);

end

