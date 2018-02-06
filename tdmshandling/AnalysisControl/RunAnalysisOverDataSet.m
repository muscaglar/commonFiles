function [ Results, NoFiles, metaStruct, PathName, FileNames ] = RunAnalysisOverDataSet( TraceID, AnalysisFunction, Channels, ResultsHandlingFunction )
%RUNANALYSISOVERDATASET use Trace ID to find the correct Date, No and Path
%Then run the given analysis function over them
% Note that only the results for the final Analysis are returned - instead
% you should pass in a Results Handling function which can take the results
% retuned from runnign over all the files for a single trace and the do
% something with those results.
% This Results handing function will essentially be paired with the
% Analysis Function

% This function requires the experiment look up librabry to be installed
% and working

if nargin < 3
    Channels = [3 4];
end

for t_id = TraceID'
    %Use TraceID to find the folder path
    [ Path, ~,~ ] = GetTracePathByID( t_id );
    if exist(Path,'dir') ~= 0
        [ Results, NoFiles, metaStruct, PathName, FileNames ] = RunFnOverEveryFile( AnalysisFunction, Channels, Path );
    else
        Results = [];
        NoFiles = 0;
        metaStruct  = []; PathName = []; FileNames = [];
    end
    if nargin > 3
       ResultsHandlingFunction(Results); 
    end
end

end
