function PlotManyMultiVariateNormals(X, mu, Sigma )
figure(11);
hold off;
for n = 1:length(Sigma)
    PlotMultiVariateNormal(X, mu(:,n)', Sigma{n} )
    hold all
end
end