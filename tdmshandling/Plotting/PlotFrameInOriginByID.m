function [ ChannelData, ORG] = PlotFrameInOriginByID( TraceID , Prefix)
%PLOTTRACEINORIGINBYID Plot into Origin
%Also subsample the data so the trace isn't too big

if nargin < 2
    Prefix = [];
end

[  ChannelData, FolderPath, TraceDate, TraceNo, TraceObj, NoFiles ] = LoadFrameDataByID( TraceID );
ORG = Matlab2OriginPlot;
n = size(ChannelData,2);
PlotName = [Prefix num2str(TraceID) 'Trace_2Hz'];

% Can now do plotting either manually or using multiplot  - note need to
% pass in type
PlotChannels = [6 9]; % [2 3 4 5 6 9]; 
%ORG.plotMultiY(ChannelData(:,1)',ChannelData(:,PlotChannels)',0,PlotName,200);
 
ORG.PlotLine(ChannelData(:,1)',ChannelData(:,9)',PlotName, 'black' );
ORG.yComment('Height');
ORG.ylabel('Height','um');
ORG.xlabel('Time','S');
ORG.HideActiveWkBk;

ORG.HoldOn;
ORG.NewLayer(1,0);

%PLot abs of frame data - to match the AC sweeps
ORG.PlotLine(ChannelData(:,1)',(-1*(ChannelData(:,6)))',PlotName , 'blue' );
ORG.yComment('Phase');
ORG.ylabel('Phase','degrees');
ORG.xlabel('Time','S');
ORG.HideActiveWkBk;

end

