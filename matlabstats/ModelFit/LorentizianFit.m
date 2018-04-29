function [ location, scale, area, FinalResids, Y_fit ] = LorentizianFit( X,Y, Params0, n )
%LorentizianFit Summary of this function goes here
%   Fit a lorentizin - or multiple Lorentizians?  - how to decide how many
%   - or just fit the required no?
% X and Y are the data, n is the number of Lorentizians, which Sum?
if nargin < 4
   n = 1; 
end
if nargin < 3
    Params0 = zeros(n,3);
    %Now need to set the intial Parameters
end

ParamFinal = fminsearch(@(Params0) LorentzianSqaureResids(X,Y,Params0), Params0);

location = ParamFinal(:,1);
scale = ParamFinal(:,2);
area = ParamFinal(:,3);

Y_fit = Lorentzian(X,location,scale, area);

<<<<<<< mine
hold on
plot(X,Y_fit,'b')
hold off
=======
 %hold on
 %plot(X,Lorentzian(X,location,scale, area),'b')
% hold off
>>>>>>> theirs

FinalResids = LorentzianSqaureResids(X,Y,ParamFinal);

%Deal with the case where both scale and area are negative - as this
%shouldn't happen/ has no relevance  - but need to check equivalence.
if sign(scale) < 0 && sign(area) < 0
    scale = abs(scale);
    area = abs(area);
end

end


