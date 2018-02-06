function [ colour ] = ColourWheel(No)
%COLOURWHEEL Summary of this function goes here
%   Detailed explanation goes here

C = {'b','r','g','y','k',[.5 .6 .7],[.8 .2 .6]};

if No > length(C)
    No = 1;
end
if No < 1
    No = 1;
end
colour = C{No};

end

