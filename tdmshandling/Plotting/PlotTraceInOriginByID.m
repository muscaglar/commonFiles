function [ ChannelData, ORG] = PlotTraceInOriginByID( TraceID, FinalSampleRate, Channels, StartTime, EndTime, Prefix )
%PLOTTRACEINORIGINBYID Plot into Origin
%Also subsample the data so the trace isn't too big

if nargin < 3 || isempty(Channels)
    Channels = [3 4];
end
if nargin < 6
    Prefix = [];
end

[ ChannelData, FolderPath, TraceDate, TraceNo, TraceObj,ResultingSampleRate, NoFiles ] = LoadTraceByID( TraceID, FinalSampleRate, Channels );
ORG = Matlab2OriginPlot;
n = size(Channels,2);
PlotName = [Prefix num2str(TraceID) 'Trace_' num2str(ResultingSampleRate) 'Hz'];

%
%     ORG.plotMultiY(ChannelData(:,1)',ChannelData(:,2:n+1)',0,PlotName);
%     ORG.HoldOn;

if nargin > 4
    %Use start and end to set the bits to look at
    Index = ChannelData(:,1) > StartTime & ChannelData(:,1) < EndTime;
    ChannelData = ChannelData(Index,:);
    
    %Zero the channel data
    ChannelData(:,1) = ChannelData(:,1) - ChannelData(1,1);
end


%PLot abs of frame data - to match the AC sweeps
ORG.PlotLine(ChannelData(:,1)',(ChannelData(:,3))',PlotName , 'blue' );
ORG.yComment(['Current' num2str(TraceID)]);
ORG.ylabel('Current','nA');
ORG.xlabel('Time','S');
ORG.HideActiveWkBk;

ORG.title(PlotName);
ORG.ExecuteLabTalk('layer.y.ticks  = 5;');
ORG.ExecuteLabTalk('layer.y2.ticks  = 0;');

ORG.HoldOn;
ORG.NewLayer(1,0);

ORG.PlotLine(ChannelData(:,1)',ChannelData(:,2)',PlotName, 'red' );
ORG.yComment(['Voltage' num2str(TraceID)]);
ORG.ylabel('Voltage','mV');
ORG.xlabel('Time','S');
ORG.HideActiveWkBk;

%Don't run this as need to change layer to execute this command
%ORG.ExecuteLabTalk('layer.y2.ticks  = 5;');
%ORG.ExecuteLabTalk('layer.y.ticks  = 0;');

end

