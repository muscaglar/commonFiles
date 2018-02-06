function [ d ] = LorentzianSqaureResids( X,Y, Params )
%UNTITLED19 Summary of this function goes here
%   Return the sum of square residuals for this fit

%the first column of params in the locations, the 2nd column vector is the
%scale values

d = sum( ( Y - Lorentzian(X, Params(:,1), Params(:,2), Params(:,3)) ) .^2 );

end

