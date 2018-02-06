function [ mu, sigma, Assignment  ] = AssignFitNormals( X, NoNormals )
% FITMULTIPLENORMAL Summary of this function goes here
%   Detailed explanation goes here

mu = mean(X);
sigma = std(X);

l = length(X);
Assignment = zeros(l,1);

% Create N normal distributions
X0 = SelectPercentile(X,95);
mu0 = linspace(min(X0), max(X0),NoNormals);
for n = 1:NoNormals
    
%     if mod(n,2) == 0
%         mu0 = mu + (NoNormals/3 * n/2) * sigma
%     else
%         mu0 = mu - (NoNormals/3 * n/2 +0.5) * sigma
%     end
    Dist(:,n) = normpdf(X,mu0(n),sigma / NoNormals);
end
for i=1:100
    % Assign each point to the heighest probablity at that point.
    for j = 1:l
        [a,  index] = max( Dist(j,:) );
        Assignment(j) = index;
    end
    
    % Then recalculate the normal
    for n = 1:NoNormals
        data = X(Assignment == n);
        %Now fit normal to just selected X in data
        [muhat,sigmahat] = normfit(data);
        %Note need to calculate this pdf at all X for comparisons
        Dist(:,n) = normpdf(X,muhat,sigmahat);
        mu(n) = muhat;
        sigma(n) = sigmahat;
    end
end


end

