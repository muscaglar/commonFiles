function [ PlotData, SortedData  ] = SelectPercentile(Data, Percentile )
%SELECTPERCENTILE Returns the middle percetile of data points  - not a
%distrbution basis.


        n = max(size(Data));

        SortedData = sort(Data);
        percentileRemove = (100 - Percentile) / 2;
        startIndex = floor(n*percentileRemove/100);
        endIndex =  ceil(n - n*percentileRemove/100);
        if startIndex < 1
            startIndex = 1;
        end
        PlotData = SortedData(startIndex:endIndex);


end

