%How to use the Code to run over a folder of TDMS files withot loading each
%one

%First you need to set up your analysis function with the following
%protype  - see AnAnalysisFunction.m for detials
%
%    function [ Result ] = AnAnalysisFunction( Data, FileName )
%
%Now pass this into the function fun over Data set - optionally with the
%path to analyse over
%The Results from your function are stacked into the results Matrix
[ Results, NoFiles ] = RunFnOverEveryFile(@AnAnalysisFunction);

%Once the code has run over all your data files the Results Matrxi will
%contain anything you have passed out - though you could also consider
%saving from within your analysis function
noPoints = sum(Results);

disp(['There are ' num2str(noPoints) ' data points in ' num2str(NoFiles) ' files.']);