function [ Results, NoFiles, metaStruct, PathName, FileNames ] = RunFnOverEveryFile( AnalysisFunction, Channels, Path )
%RUNANALYSISOVERDATASET Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    Channels = [3 4];
end

FileRoots;
if nargin < 3
    if exist('D:\PhDData1\Data','dir')
        [Path] = uigetdir(DataRootHDD,'Select Dir to Analyse tdms Files');
    else
        [Path] = uigetdir(DataRoot,'Select Dir to Analyse tdms Files');
    end
    FolderPath = [Path '/'];
else
    %FolderPath is provided as an input argument  - but need to ensure its
    %in the correct format.
    FolderPath = [Path '/'];
end

%NB need to add support for subfodler searching also at some point  - but
%not important as subfolders include frame data
Results = [];
FileNames = [];
FolderPath;
files = dir(FolderPath);
i = 0;
if (length(files) > 2)
    for file = files'
        %Need to check if file is tdms!  - but not the tdms index file  - don't
        %want to use that!
        if not(isempty(strfind(file.name, '.tdms'))) && (isempty(strfind(file.name, '.tdms_index'))) && (isempty(strfind(file.name, '.log')))
            i = i+1;
            file.name;
                
            %%%%%%%%%%%%% Added this to only look at files adhearing to
            %%%%%%%%%%%%% XXXX1_XXXXXX. Change tihs to concat more files
            %%%%%%%%%%%%% etc. Run the function like: [ ChannelData,
            %%%%%%%%%%%%% metaStruct, PathName, FileName, NoFiles ] =
            %%%%%%%%%%%%% ConcatentateRawData   and browse for the correct
            %%%%%%%%%%%%% data folder directory.
            
            [ChannelData, metaStruct, FileName, PathName ] = LoadTDMSData(Channels, file.name, FolderPath);
            Results = [Results ; AnalysisFunction(ChannelData, FileName, FolderPath)] ;
            FileNames = {FileNames; FileName};
            
%             if(file.name(5) == '1')
%                     if(file.name(6) == '_')
%             %Process File
%             [ ChannelData, metaStruct, FileName, PathName ] = LoadTDMSData(Channels, file.name, FolderPath);
%             
%             %Now run the Analysis on this data file and put the return into a
%             %new row in Results
%             Results = [Results ; AnalysisFunction(ChannelData, FileName, FolderPath)] ;
%             FileNames = {FileNames; FileName};
%                     else
%                     end
%                 else
%             end
                
            
        end
    end
else
    disp('No Files in Folder');
    ChannelData = [];
    metaStruct = [];
    FileNames = [];
    PathName = FolderPath;
end
NoFiles = i;

end
