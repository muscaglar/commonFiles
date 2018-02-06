function [ Y ] = Lorentzian( X, location, scale, area )
%UNTITLED18 Summary of this function goes here
%   Generate Lorentizians to plot fit.
%   Plot multiple , byt giving the sum if there are several parameters
%   ie location and scale can be vectors!
if nargin < 4
   area = 1; 
end
if nargin < 3
   scale = 1; 
end
if nargin < 2
   location = 0; 
end

%no of lorentizans
n = max(size(location));
l = max(size(X));
Y = zeros(l,1);
for i = 1:n
    Y = Y + ( (1./pi) .* area(i) .* ( ( scale(i) ) ./ ( (X - location(i)).^2 + scale(i).^2 ) ) );
end

end

