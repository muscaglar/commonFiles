function [ ChannelData, metaStruct, FileName, PathName ] = LoadTDMSData(channels, FileName, PathName)
%LoadTDMSData Open File and Select relevant data
%   A function to load a TDMS file and select the required Data
%   Note it might be valuable to then delete the rest of the data
%   Can load a single file or just pass in a path - will then ask for
%   filename
%   If no path is provided then will show a UI to select.

if nargin < 2
    [ finalOutput,metaStruct, FileName, PathName] = LoadTDMS();
elseif nargin < 3
    [ finalOutput,metaStruct, FileName, PathName] = LoadTDMS( FileName, ' ' );
else
    [finalOutput,metaStruct, FileName, PathName] = LoadTDMS( FileName, PathName );
end

[ ChannelData ] = SelectColumn(finalOutput, channels);

%Could now delete finalOutput (which also holds unused data and is not
%exposed to the rest of the code) from taking up too much memory
%ColumnData holds only the data required

end

