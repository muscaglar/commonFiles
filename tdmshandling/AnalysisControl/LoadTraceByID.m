function [ ChannelData, FolderPath, TraceDate, TraceNo, TraceObj,ResultingSampleRate, NoFiles ] = LoadTraceByID( TraceID, FinalSampleRate, Channels )
%notes adds times  - can do this as it knows the sample rate

if nargin < 3
     Channels = [3 4];
end

[ FolderPath, TraceDate, TraceNo, TraceObj ] = GetTracePathByID( TraceID );

if nargin > 1
if FinalSampleRate > 0
    SubSampleNvalue = round(TraceObj.getSampleFreq / FinalSampleRate);
else
    SubSampleNvalue = 1;
end
else
    SubSampleNvalue = 1;
end

ResultingSampleRate = TraceObj.getSampleFreq/SubSampleNvalue;
TimePeriod = 1 / ResultingSampleRate;

%Now load the subsampled data - cut out the bit required
[ ChannelData, metaStruct, PathName, FileName, NoFiles ] = ConcatentateRawDataSubSampled(FolderPath, Channels, SubSampleNvalue );

length = size(ChannelData,1);
TimePeriod = 1e-4;
Times = 0:TimePeriod:(length-1)*TimePeriod;

ChannelData = [Times' ChannelData];

end

