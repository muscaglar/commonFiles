function [ mu, sigma, Assignment  ] = AssignFitNormals_MultiVariate( X, NoNormals )
% FITMULTIPLENORMAL Summary of this function goes here
%   Detailed explanation goes here
NoIterations = 1000;

[dim, L] = size(X);
%http://uk.mathworks.com/help/stats/multivariate-normal-distribution.html

for d = 1:dim
    %X_norm = X;
    X_norm(d,:) = (X(d,:) - min(X(d,:))) * 1/(max(X(d,:)) - min(X(d,:)) );
end

%mu = mean(X_norm,2);
sigma0 = std(X_norm,0,2);
C = cov(X_norm');
C = 2*diag(sigma0);
Assignment = ones(L,1);
PrevAssignment = zeros(L,1);
mu0 = zeros(dim,NoNormals);

% Create N normal distributions
for d = 1:dim
    X0 = SelectPercentile(X_norm(d,:),95);
    mu0(d,:) = linspace(min(X0), max(X0),NoNormals);
    %mu0(d,:) = min(X0) + rand(1,NoNormals) * (max(X0) -min(X0) );
end
mu = mu0;
for n = 1:NoNormals
    Dist(:,n) = mvnpdf(X_norm',mu0(:,n)',C);
    sigma{n} = C;
end

%size(Dist)
NoChange = 1;
NoNoChange = 5;
%for i=1:NoIterations
iterations = 0;
while (NoNoChange > 0 && iterations < NoIterations)
    % Assign each point to the heighest probablity at that point.
    for j = 1:L
        %Probaility assingmnet
        [a,  index] = max( Dist(j,:) );
        Assignment(j) = index;
        
        %Assignment Euclidean  % need to normalise data
        if NoNoChange == 20
        for n = 1:NoNormals
            V = X_norm(:,j) - mu(:,n);
            Euclid(n) = sqrt(V' * V);
        end
        [a,  index] = min( Euclid );
        Assignment(j) = index;
        end
    end
    % Then recalculate the normal
    for n = 1:NoNormals
        data = X_norm(:,Assignment == n);
        %Now fit normal to just selected X in data
        %[muhat,sigmahat] = normfit(data);
        if size(data,2) > 2
            muhat = mean(data,2);
            sigmahat = cov(data');
            for d = 1:dim
                if(sigmahat(d,d) == 0)
                    sigmahat(d,d) = 1*data(d,1);
                end
            end
        else
            muhat = mu(:,n) .* rand(dim,1);
            sigmahat = 10*sigma{n};
        end
        %Note need to calculate this pdf at all X for comparisons
        Dist(:,n) = mvnpdf(X_norm',muhat',sigmahat);
        mu(:,n) = muhat;
        sigma{n} = sigmahat;
        
        %Dist(:,n) = (Dist(:,n) - min(Dist(:,n))) * 0.5 /((max(Dist(:,n)) - min(Dist(:,n))));        
    end
    
    NoChange = L - sum(PrevAssignment == Assignment );
    if NoChange == 0
        NoNoChange = NoNoChange - 1;
    end
    PrevAssignment  = Assignment ;
    iterations = iterations + 1;
end
iterations

%Now calculate the final distribution and assigment from final values  -

for n = 1:NoNormals
        data = X(:,Assignment' == n);
        if size(data,2) > 2
            muhat = mean(data,2);
            sigmahat = cov(data');
            for d = 1:dim
                if(sigmahat(d,d) == 0)
                    sigmahat(d,d) = 1*data(d,1);
                end
            end
        else
            muhat = mu(:,n) .* rand(dim,1);
            sigmahat = 10*sigma{n};
        end
        mu(:,n) = muhat;
        sigma{n} = sigmahat;
end


end

