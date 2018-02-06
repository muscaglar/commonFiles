function [ ChannelData, ORG] = PlotTraceByID( TraceID, FinalSampleRate, Channels, StartTime, EndTime, Prefix )
%PLOTTRACEBYID Plot 
%Also subsample the data so the trace isn't too big
if nargin < 2
    FinalSampleRate = 0;
end
if nargin < 3
    Channels = [3 4];
end
if nargin < 6
    Prefix = [];
end

[ ChannelData, FolderPath, TraceDate, TraceNo, TraceObj,ResultingSampleRate, NoFiles ] = LoadTraceByID( TraceID, FinalSampleRate, Channels );

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

hold off;
plot(ChannelData(:,1)',ChannelData(:,2)','-r');
hold on;

%PLot abs of frame data - to match the AC sweeps
plot(ChannelData(:,1)',(ChannelData(:,3))','-b');

title(['id:' num2str(TraceID) ' ' num2str(TraceDate) '_' num2str(TraceNo)]);

end


