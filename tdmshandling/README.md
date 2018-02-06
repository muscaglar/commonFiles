# README #

This repository contains code to make it easier to work with TDMS data in Matlab. Its mostly based on the code [here](http://uk.mathworks.com/matlabcentral/fileexchange/30023-tdms-reader) but it adds features to streamline readind data and running analysis across large data sets in a memory efficient way by not loading thew whole trace.

### What is this repository for? ###

* Reading TDMS files
* Running analysis over many files in an efficient way

### How do I get set up? ###

* Download this repo and place on your matlab path
* You must also download and place on your matlab path this code: http://uk.mathworks.com/matlabcentral/fileexchange/30023-tdms-reader

### How to use ###

There are 3 ways to use

* To read the data from a TDMS file

```
#!matlab

[ Data ] = LoadTDMSData(Channels, FileName, PathName)
```

* To concatentate all the separate data files into one

```
#!matlab
Path = 'C:/Data/Folder';    % This argument is optional if not present will give a dialog
Channels  = [3 4];
Data = ConcatentateRawData(Channels, Path);

```

* To run an analysis over a series of data files without loading them all.
    
```
#!matlab
%See ExampleDataAnalysis.m
%You need to define a function with this form that will carry out your analysis on the Data and return the Result
%Note that the data is already loaded, the filename is just for details
[ Result ] = MyAnalysisFunction( Data, FileName )

%Then run this
%Note that Channels and Path are optional
[ Results, NoFiles ] = RunFnOverEveryFile(@MyAnalysisFunction, Channels, Path);
%This will run the MyAnalysisFunction on every file passing the data from that file into it as data
%Results is then a matrix which is the output (Result) from every file stacked
%So you need to flattern it as appropriate
```



### Contribution guidelines ###
*

### Who do I talk to? ###

* Talk to Michael