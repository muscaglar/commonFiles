function [ ChannelData, metaStruct, PathName, FileName, NoFiles ] = ConcatentateRawDataSubSampled(Path, Channels, SubSampleNvalue )
% Concantentate all the TDMS files in a folder into a single variable
% Uses the RunAnalysisOverData set but returns the Data as the result
% - uses the ConcatAnalysisFunction
global SubSampleN;
if(SubSampleNvalue > 1)
    SubSampleN = SubSampleNvalue;
else
    SubSampleN = [];
end

[ ChannelData, metaStruct, PathName, FileName, NoFiles ] = ConcatentateRawData(Path, Channels );

%Set to empty so cannot mess up subsequent plots  - or delete
SubSampleN = [];

end


