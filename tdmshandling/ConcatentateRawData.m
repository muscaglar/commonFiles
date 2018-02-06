function [ ChannelData, metaStruct, PathName, FileName, NoFiles ] = ConcatentateRawData(Path, Channels )
% Concantentate all the TDMS files in a folder into a single variable
% Uses the RunAnalysisOverData set but returns the Data as the result
% - uses the ConcatAnalysisFunction
% - Note if you wish to sub sample set the global variable SubSampleN
FileRoots;

if nargin < 2
Channels = [3 4];
end

if nargin < 1
    [ ChannelData, NoFiles, metaStruct, PathName, FileName ] = RunFnOverEveryFile(@ConcatAnalysisFunction, Channels);
else
    [ ChannelData, NoFiles, metaStruct, PathName, FileName ] = RunFnOverEveryFile(@ConcatAnalysisFunction, Channels, Path);
end


end


