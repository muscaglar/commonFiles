function [ Result ] = ConcatAnalysisFunction( Data,~,~ )
%ANANALYSISFUNCTION An Example of the standard format of Analysis functions

Result = Data;

global SubSampleN;
if not(isempty(SubSampleN))
   Result = downsample(Result,SubSampleN) ;
end

end

