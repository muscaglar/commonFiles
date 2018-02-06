function [ binCentres, counts, MinRange, MaxRange, PlotData ] = SmartHistogramPlot( Data,BinSize, Percentile, FigNo, SubPlotRows,SubPlotCols, SubPlotIndex, HoldOn  )
%SMARTHISTOGRAMPLOT Summary of this function goes here
%   Detailed explanation goes here

if nargin < 8
    HoldOn = 0;
end
if nargin < 7
    SubPlotIndex = 1;
end
if nargin < 6
    SubPlotCols = 1;
end
if nargin < 5
    SubPlotRows = 1;
end
if nargin < 4
    FigNo = 1;
end
if nargin < 3
    Percentile = 100;
end
if nargin < 2
    BinSize = 0.1;
end

%Calculate and exclude the percentiles
n = max(size(Data));
if n > 4
    MinRange = min(Data);
    MaxRange = max(Data);
    
    if Percentile < 100
        
        [ PlotData, SortedData  ] = SelectPercentile(Data, Percentile );
        
        if(BinSize > abs(MaxRange - MinRange))
            BinSize = abs(MaxRange - MinRange)/(2*n);
        end
        
        bins = PlotData(1 ):BinSize:PlotData(end);
        
    else
        PlotData = Data;
        bins = MinRange:BinSize:MaxRange;
    end
    if(length(PlotData) > 1)
        %****************************  Do the plot  *******************************
        if(FigNo > 0)
            figure(FigNo);
        end
        subplot(SubPlotRows,SubPlotCols, SubPlotIndex);
        if HoldOn == 1
            hold on;
        else
            hold off;
        end
        
        h = histogram(PlotData,bins);
        
        counts = h.Values;
        binCentres = h.BinEdges(2:end) - h.BinWidth;
    else
        %No data supplied - after removing percentiles
        binCentres=0;
        counts=0;
        MinRange=0;
        MaxRange=0;
        PlotData=0;
    end
else
    %No data supplied
    binCentres=0;
    counts=0;
    MinRange=0;
    MaxRange=0;
    PlotData=0;
end

end

