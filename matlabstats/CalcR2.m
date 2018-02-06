function [ r2, SStot, SSres , u ] = CalcR2( Data, Model )
%CALCR2 Summary of this function goes here
%   Detailed explanation goes here

%https://en.wikipedia.org/wiki/Coefficient_of_determination

u = mean(Data);

SStot = sum((Data - u).^2);
SSres = sum( (Data - Model).^2);
r2 = 1 - ( SSres / SStot ) ;

end

