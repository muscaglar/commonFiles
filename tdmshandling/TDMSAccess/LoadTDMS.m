function [ finalOutput,metaStruct, FileName, PathName] = LoadTDMS( FileName, PathName )
%LoadTDMS Load a TDMS file
%   Load a TDMS from a file name or if no name is given display a file
%   dialog
FileRoots;
if nargin < 2
    if exist('D:\PhDData1\Data','dir')
        [FileName, PathName] = uigetfile({'*.tdms','All TDMS Files';},'Choose TDMS Data', DataRootHDD);
    else
        [FileName, PathName] = uigetfile({'*.tdms','All TDMS Files';},'Choose TDMS Data', DataRoot);
    end
end
[finalOutput,metaStruct] = TDMS_readTDMSFile([PathName FileName]);

end

