function [ ChannelData, FolderPath, TraceDate, TraceNo, TraceObj, NoFiles ] = LoadFrameDataByID( TraceID, Channels )
%notes adds times  - can do this as it knows the sample rate

if nargin < 2
    Channels = [3 4 5 6 7 8 9];
end

[ FolderPath, TraceDate, TraceNo, TraceObj ] = GetTracePathByID( TraceID );

TimePeriod = 0.5;

FolderPath = [FolderPath '/Frame_' num2str(TraceNo) ];

if(exist(FolderPath,'dir') == 7)
    %Now load the subsampled data - cut out the bit required
    [ ChannelData, metaStruct, PathName, FileName, NoFiles ] = ConcatentateRawData(FolderPath, Channels );
    
    if(not(isempty(ChannelData)))
        length = size(ChannelData,1);

        Times = 0:TimePeriod:(length-1)*TimePeriod;

        Heights = ( ChannelData(:,7) - ChannelData(1,7) ) * 0.020;

        ChannelData = [Times' ChannelData Heights];
    end
else
    disp(['Cannot find folder for frame for Tid = ' num2str(TraceID) ' - ' FolderPath ]);
    ChannelData = [];
    metaStruct = [];
    NoFiles = 0;
    PathName = FolderPath;
    FileName = [];
end

end

