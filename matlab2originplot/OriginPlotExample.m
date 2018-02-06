%Example Script
clear ORG;
%Launch the Origin Connection as
% 1)>>ORG = Matlab2OriginPlot('C:\<DIR>\YOUR_PROJECT.OPJ')
% Or
% 2)>> ORG = Matlab2OriginPlot();
% In Case (1) the origin project given by the address is opened, and Origin
% will be started if it is not alread. In case (2) Matlab will connect to
% an already running instance of Origin and will direct graphs and
% worksheets to the currently opened folder within Origin. If Origin isn't
% running it will start a new project.
ORG = Matlab2OriginPlot();

%Create some Data
x = 1:10;
y = 2*x;
Y = [2*y; 3*y];   %Can plot more than one data set against X.

%Note graph names need to be shorter than x digits or they will not be seen
%as unique - comments (and titles) for legends can be longer

%Plot a Line
ORG.PlotLine(x,y,'IVData1');
ORG.xlabel('Voltage','mV');
ORG.ylabel('Current','nA');
ORG.title('New graph Title');
ORG.yComment('Line Data');
ORG.HideActiveWkBk();

%Hold On and Hold Off work similarly to as for Matlab
ORG.HoldOn;
PlotName = ORG.Figure('GraphName');
%Plot 2 scatter graphs as Y is composed of 2 Columns on to the same graph
%as the line above.
ORG.PlotScatter(x,Y,'IVData2','green');
ORG.yComment('Scatter Data');
ORG.AddText('Created using MikesOriginPlot library');

%Copy the Graph to the clip board - try pasting it somewhere
ORG.CopyPage;

ORG.HoldOff;
%This will only work on Origin 8.5.1 and above
ORG.PlotScatterError(x,2*y,0.1*y, 'ErrorExample');

%To Adjust Axis
ORG.xaxis( from , to );
ORG.yaxis( from , to );
ORG.yrescale();
ORG.xrescale();
ORG.rescale();
ORG.xfirsttick(1300);
ORG.xlabelincrement(400);
ORG.yfirsttick(1300);
ORG.ylabelincrement(400);
%Also rescale mode option

%Historgram Example
H = [1 1 3 4 5 5 5 5 6 6 7 7 7 8 8  1 3 4];
ORG.plotHist(H,'Histogram','red');
%Bar Chart Example
ORG.PlotBar(x,y,'Bar Example','Pink');
%Column Chart Example
ORG.PlotColumn(x,y,'Column Example','cyan');

%MultiYPlot - ie the same X axis but multiple Y Axis:
ORG.plotMultiY(x,Y,0,'MultiY');

%To put data directly into an Origin Worksheet  - could then update an
%existing graph.
%ORG.MatrixToOrigin([x' y'], 'WKS_Name');

%To save changes to the current project
ORG.Save;

%To close Origin and disconnect  - note does NOT save any changes
%ORG.CloseOrigin;

ORG.mkdir('name')
ORG.cd('name');
ORG.mkdir_cd('name');
ORG.cd_TopLevel();
ORG.cd_up()l

ORG.HideActiveWin();

%To disconnect from Origin without closing the project. This will allow you
%to close origin manually without closing Matlab.
ORG.Disconnect;


%add 
Axis postype
Axis position
Column error
Axis at 0

%add some tick commands and demo
ORG.ExecuteLabTalk('layer.y2.ticks  = 5;');
ORG.ExecuteLabTalk('layer.y.ticks  = 0;');
%e set left and right, top and bottom ticks

