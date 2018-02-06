function [ output_args ] = PlotMultiVariateNormal(X, mu, Sigma )
%PLOTMULTIVARIATENORMAL Summary of this function goes here
%   Detailed explanation goes here

x1 = linspace(X(1),X(2),100);
x2 = linspace(X(3),X(4),100);
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,Sigma);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
%axis([-3 3 -3 3 0 .4])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');


end

