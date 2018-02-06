function [ cost ] = ExponentialCost( X,Y, Param )
%EXPONENTIALCOST Summary of this function goes here
%   Detailed explanation goes here

Y_model = Exponential(X, Param);

cost =  sqrt(sum((Y - Y_model).^2));

end

