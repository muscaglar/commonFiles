% ***********************************
% Matlab2OriginPlot
%   A librabry to plot from Matlab into Origin.
%   See OriginPlotExample.
%   (C) Michael Walker 2015 - All Rights Reserved
%   Vers: 0.0.2
%   This code is able to overwrite data in an Origin project and close an
%   open project without saving. Ensure you have saved all your work before
%   using this library. The author takes no responsibility for loss of work
%   due to using this library
%%***********************************
classdef Matlab2SVGPlot < Matlab2OriginPlotTest
    % Matlab2OriginPlot Code to plot in Origin from Matlab
    % This is the first line of the description of myClass.
    % Descriptions can include multiple lines of text.
    %
    %
    % Matlab2OriginPlot Methods:
    %    PlotLine - Plot XY Line
    %    PlotScatter - Plot XY Scatter
    %    title - Add a title to the plot
    %    xlabel - Set the X label and units
    %    ylabel - Set the Y lable and units
    %    xComment - Set the X comment
    %    yComment - Set the Y Comment  - used for series legend
    %    MatrixToOrigin  -  Transfer a Matrix into an Origin worksheet
    %
    % Colours from the labtalk list of colours: http://www.originlab.com/doc/LabTalk/ref/List-of-Colors
    properties
        ProjectName;
        originObj;
        ActiveWorksheetName;
        ActiveGraphName;
        Hold;
        CurrentLayer;
        NoLayers;
        CurrentPlotNo;
        NoPlots;
        %http://www.originlab.com/doc/LabTalk/ref/List-of-Colors
        colourWheel = {'Black', 'Red','Green','Blue','Cyan','Magenta','Yellow','Dark Yellow','Navy','Purple','Wine','Olive','Dark Cyan','Royal','Orange','Violet','Pink','White','LT Gray','Gray','LT Yellow','LT Cyan','LT Magenta','Dark Gray'}
        typeWheel = {'201','200','200'};
        GraphTemplate = 'KeyserLab';
    end
    
    methods
        function obj = Matlab2OriginPlot(Name)
            if nargin > 0
                obj.ProjectName = Name;
                Existing = 0;
            else
                %No Name supplied so can either use existing or offer an
                %option to load
                Existing = 1;
                %Option to load project.
                %[FileName, PathName] = uigetfile({'*.OPJ','All Origin Projects';},'Choose Origin Project');
                %obj.ProjectName = [PathName '\' FileName];
            end
        end
        function WksName = CreateWorkSheet(obj, Name)
            WksName = 'sheet';
        end
        function MatrixToOrigin(obj, mdata, WorksheetName)
        end
        function CopyGraph(obj)
            %& inovke(obj.originObj, 'CopyPage', 'Graph1');
        end
        function plotName = PlotScatter(obj,X,Y, plotName, colour)
            if nargin < 5
                colour = 'blue';
            end
            plotName = plotXY(obj,X,Y,0,'201',plotName, colour);
        end
        function plotName = PlotScatterError(obj,X,Y,E, plotName, colour)
            if nargin < 6
                colour = 'blue';
            end
            plotName = plotXY(obj,X,Y,E,'201',plotName, colour);
        end
        function plotName = PlotLine(obj,X,Y,plotName,colour)
            if nargin < 5
                colour = 'red';
            end
            plotName = plotXY(obj,X,Y,0,'200',plotName,colour);
        end
        function plotName = PlotBar(obj,X,Y,plotName,colour)
            if nargin < 5
                colour = 'red';
            end
            plotName = plotXY(obj,X,Y,0,'215',plotName,colour);
        end
        function plotName = PlotColumn(obj,X,Y,plotName,colour)
            if nargin < 5
                colour = 'red';
            end
            plotName = plotXY(obj,X,Y,0,'203',plotName,colour);
        end
        function xlabel(obj,Name,Units)
           xlabel([Name ' (' Units ')']);
            %& obj.ActivatePage(obj.ActiveWorksheetName);
            %& obj.ExecuteLabTalk(['wks.col1.lname$ = "' Name '";wks.col1.unit$ = "' Units '";'] );
            %& obj.ActivatePage( obj.ActiveGraphName );
            %& obj.ExecuteLabTalk('page.active = 1; layer - a;');
        end
        function ylabel(obj,Name,Units)
            ylabel([Name ' (' Units ')']);
            %& obj.ActivatePage(obj.ActiveWorksheetName );
            %& obj.ExecuteLabTalk(['wks.col2.lname$ = "' Name '";wks.col2.unit$ = "' Units '";'] );
            %& obj.ActivatePage(obj.ActiveGraphName)
            %& obj.ExecuteLabTalk('page.active = 1; layer - a;');
        end
        function title(obj, Name)
            title(Name);
            %& obj.ActivatePage(obj.ActiveGraphName );
            %& obj.ExecuteLabTalk(['page.longname$ = "' Name '"']);
        end
        function xComment(obj,Comment)
            %& obj.ActivatePage(obj.ActiveWorksheetName )
            %& obj.ExecuteLabTalk(['wks.col1.comment$ = "' Comment '";'] );
            %& obj.ActivatePage( obj.ActiveGraphName);
        end
        function yComment(obj,Comment)
            %& obj.ActivatePage(obj.ActiveWorksheetName )
            %& obj.ExecuteLabTalk(['wks.col2.comment$ = "' Comment '";'] );
            %& obj.ActivatePage( obj.ActiveGraphName);
        end
        function plotName = plotXY(obj,X,Y,E,type,plotName,colour)
            %http://www.originlab.com/doc/LabTalk/guide/Creating-Graphs#Plotting_X_Y_data
            % Type is plot Type ID as here: http://www.originlab.com/doc/LabTalk/ref/Plot-Type-IDs
            %Create Worksheet  - unless it already exists?
            NoCols = size(Y',2);  
            %Reshape and check sizes here.
            %[error, Xout, Yout, nRows, nX,NoCols] = CheckVectors(obj, Xin, Yin)
            Wks = CreateWorkSheet(obj,[plotName ' Data']);
            %Put Data into Worksheet
            if size(E) == size(Y)
               obj. MatrixToOrigin([X',Y',E']);
               e = 1;
            else
                obj.MatrixToOrigin( [X',Y']);
                e = 0;
            end
            %& obj.ExecuteLabTalk( 'wks.col1.type=4;' )
            for i = 1:NoCols
                %& obj.ExecuteLabTalk( ['wks.col' num2str(i+1) '.type=1;'] );
               if e == 1 
                 %& obj.ExecuteLabTalk([' wks.col3.type=' num2str(i+1+NoCols) ';'] );  
               end
            end
            %Create a Graph Page;
            if obj.Hold == 0
                %& obj.ActiveGraphName = %& inovke(obj.originObj, 'CreatePage', 3,plotName,obj.GraphTemplate);
                obj.NoPlots = 0;
                obj.CurrentPlotNo = 0;
                obj.CurrentLayer = 1;
                obj.NoLayers = 1;
            else
                %Adding to a plot so implement plot no  - if we were goign
                %Increasing the layer is done by a separat func
                %obj.CurrentPlotNo = obj.NoPlots + 1;
                %obj.NoPlots = obj.NoPlots + 1;
            end
            %PLot into existing graph layer 1  - or on to a new layer?
            for i = 1:NoCols
                if e == 0
                    %& obj.ExecuteLabTalk(['plotxy iy:=[' Wks ']Sheet1!(1,' num2str(1+i) ' ) plot:=' type ' ogl:=[' obj.ActiveGraphName ']' num2str(obj.CurrentLayer) '!;'] )
                    if(type == 200)
                        plot(X,Y,'o');
                    else
                        plot(X,Y,'-');
                    end
                else
                    %Add Error Bars
                %ErrorCol = NoCols + i+1;
                errorbar(X,Y,E);
                %& obj.ExecuteLabTalk(['plotxy iy:=[' Wks ']Sheet1!(1,' num2str(1+i) ',' num2str(ErrorCol) ') plot:=' type ' ogl:=[' obj.ActiveGraphName ']' num2str(obj.CurrentLayer) '!;'] )
                
                end
               
                
                %& obj.ActivatePage(obj.ActiveGraphName)
                %& obj.ExecuteLabTalk(['layer.plot = ' num2str(obj.CurrentPlotNo) ';']);
                %& obj.ExecuteLabTalk(['set %C -cl color(' colour ');']);
                %& obj.ExecuteLabTalk('set %C -w 1000;');
                %& obj.ExecuteLabTalk(['set %C -c color(' colour ');']);
                %& obj.ExecuteLabTalk(['set %C -cf color(' colour ');']);
            end
            
            %& obj.ExecuteLabTalk(['page.lname$= ' obj.ActiveGraphName ';'] )
            
            obj.Keyserify;
            plotName = obj.ActiveGraphName;
            %& obj.ActivatePage(obj.ActiveGraphName)
        end
        function ExecuteLabTalk(obj, script)
            %& inovke(obj.originObj, 'Execute', script);
        end
        function Keyserify(obj)
            
            %& obj.ExecuteLabTalk('layer.x.showAxes = 3;');
            %& obj.ExecuteLabTalk('layer.y.showAxes = 3;');
            
            %Line thickness
            %& obj.ExecuteLabTalk('layer.x.thickness = 2;');
            %& obj.ExecuteLabTalk('layer.y.thickness = 2;');
            
            %Major ticks, including force one at each edge  - with the first tick command
            %& obj.ExecuteLabTalk('layer.y.majorTicks = 6;');
            %& obj.ExecuteLabTalk('layer.x.majorTicks = 6;');
            
            %%& obj.ExecuteLabTalk('i = layer.y.from;');
            %%& obj.ExecuteLabTalk('layer.y.firstTick = i;');
            %%& obj.ExecuteLabTalk('i = layer.x.from;');
            %%& obj.ExecuteLabTalk('layer.x.firstTick = i;');
            
            
            %Major and Minor in (1+4)
            %& obj.ExecuteLabTalk('layer.x.ticks  = 5;');
            %& obj.ExecuteLabTalk('layer.y.ticks  = 5;');
            
            %Set formating of fonts
            %& obj.ExecuteLabTalk('layer.x.label.pt = 28;');
            %& obj.ExecuteLabTalk('layer.y.label.pt = 28;');
            
            %%& obj.ExecuteLabTalk('//layer.x.label.pt = 28;');
            
            %Need to run over all layers and set line thickness and symbol
            %size
            %%& obj.ExecuteLabTalk('//Set plot line width = 2');
            %%& obj.ExecuteLabTalk('set %C -w 1000');
        end
        function HoldOn(obj)
            obj.Hold = 1;
            hold on;
        end
        function HoldOff(obj)
            hold off
            obj.Hold = 0;
            %Not sure if I do want to reset all of these here?
            obj.NoPlots = 0;
            obj.CurrentPlotNo = 0;
            obj.CurrentLayer = 1;
            obj.NoLayers = 1;
        end
        function ActivatePage(obj, PageName)
            %& obj.ExecuteLabTalk(['win -a ' PageName ' ']);
        end
        function CopyPage(obj, GraphName)
            if nargin > 1
                 %& inovke(obj.originObj, 'CopyPage', GraphName);
            else
                %& inovke(obj.originObj, 'CopyPage', obj.ActiveGraphName);
            end
        end
        function AddText(obj,Text, XPos, YPos)
            if nargin < 3
                XPos = 500;
                YPos = 200;
            end
            %& obj.ActivatePage(obj.ActiveGraphName);
            %& obj.ExecuteLabTalk(['label -s -d ' num2str(XPos) ' ' num2str(YPos) ' ' Text ';']);
        end
        function plotName = plotHist(obj,Y,plotName,colour)
            %http://www.originlab.com/doc/LabTalk/guide/Creating-Graphs#Plotting_X_Y_data
            % Type is plot Type ID as here: http://www.originlab.com/doc/LabTalk/ref/Plot-Type-IDs
            %Create Worksheet  - unless it already exists?
            NoCols = size(Y',2);  
            %Reshape and check sizes here.
            
            Wks = CreateWorkSheet(obj,[plotName ' Data']);
            %Put Data into Worksheet
            obj.MatrixToOrigin( Y');
            %1 column set as Y Type
            %& obj.ExecuteLabTalk( 'wks.col1.type=1;' )
            
            %Create a Graph Page;
            if obj.Hold == 0
                %& obj.ActiveGraphName = %& inovke(obj.originObj, 'CreatePage', 3,plotName,obj.GraphTemplate);
                obj.NoPlots = 0;
                obj.CurrentPlotNo = 0;
                obj.CurrentLayer = 1;
                obj.NoLayers = 1;
            else
                %Adding to a plot so implement plot no  - if we were goign
                %Increasing the layer is done by a separat func
                %obj.CurrentPlotNo = obj.NoPlots + 1;
                %obj.NoPlots = obj.NoPlots + 1;
            end
            %PLot into existing graph layer 1  - or on to a new layer?
            for i = 1:NoCols
                %& obj.ExecuteLabTalk(['plotxy iy:=[' Wks ']Sheet1!(1) plot:=219 ogl:=[' obj.ActiveGraphName ']' num2str(obj.CurrentLayer) '!;'] )
                obj.CurrentPlotNo = obj.NoPlots + 1;
                obj.NoPlots = obj.NoPlots + 1;
                
                %& obj.ActivatePage(obj.ActiveGraphName)
                %& obj.ExecuteLabTalk(['layer.plot = ' num2str(obj.CurrentPlotNo) ';']);
                %& obj.ExecuteLabTalk(['set %C -cl color(' colour ');']);
                %& obj.ExecuteLabTalk('set %C -w 1000;');
                %& obj.ExecuteLabTalk(['set %C -c color(' colour ');']);
                %& obj.ExecuteLabTalk(['set %C -cf color(' colour ');']);
            end
            
            %& obj.ExecuteLabTalk(['page.lname$= ' obj.ActiveGraphName ';'] )
            
            obj.Keyserify;
            plotName = obj.ActiveGraphName;
            %& obj.ActivatePage(obj.ActiveGraphName)
        end
        function plotName = plotMultiY_inBuilt(obj,X,Y,E,plotName,colour)
            %Plot all Y columns against the same X  - if they are different
            %X's then use multiple plots creating a new layer for each - ie
            %set so that only X is linked.
            NoCols = size(Y',2);  
            %Reshape and check sizes here.
            
            Wks = CreateWorkSheet(obj,[plotName ' Data']);
            %Put Data into Worksheet
            if size(E) == size(Y)
               obj. MatrixToOrigin([X',Y',E']);
               e = 1;
            else
                obj.MatrixToOrigin( [X',Y']);
                e = 0;
            end
            %& obj.ExecuteLabTalk( 'wks.col1.type=4;' )
            for i = 1:NoCols
                %& obj.ExecuteLabTalk( ['wks.col' num2str(i+1) '.type=1;'] );
               if e == 1 
                 %& obj.ExecuteLabTalk([' wks.col3.type=' num2str(i+1+NoCols) ';'] );  
               end
            end
            %Create a Graph Page;
            if obj.Hold == 0
               %& obj.ActiveGraphName = %& inovke(obj.originObj, 'CreatePage', 3,plotName,obj.GraphTemplate);
                obj.NoPlots = 0;
                obj.CurrentPlotNo = 0;
                obj.CurrentLayer = 1;
                obj.NoLayers = 1;
            else
                %Adding to a plot so implement plot no  - if we were goign
                %Increasing the layer is done by a separat func
                %obj.CurrentPlotNo = obj.NoPlots + 1;
                %obj.NoPlots = obj.NoPlots + 1;
            end
            %plotmyaxes iy:=((3),(4),(5),(7)) plottype:=line axiscolor:=1;    
            str = ['plotmyaxes iy:=[' Wks ']Sheet1!('];
            for i = 1:NoCols       
                if e == 0
                    %str = strcat(str ,',(', num2str(i+1), ')');
                    str = strcat(str ,'(1,', num2str(i+1), ')');
                    if i< NoCols
                        str = strcat(str,',');
                    end
                else
                    %Add Error Bars
                    ErrorCol = NoCols + i+1; 
                end
            end
                str = strcat(str, ') plottype:=line:line axiscolor:=1;');
                %str = strcat(str,' ogl:=[', obj.ActiveGraphName, ']', num2str(obj.CurrentLayer), '!;');
                %& obj.ActivatePage(Wks);
                %& obj.ExecuteLabTalk(str);
                obj.CurrentPlotNo = obj.NoPlots + 1;
                obj.NoPlots = obj.NoPlots + 1;
                %Now need to loop over layers to set colours
                %& obj.ActivatePage(obj.ActiveGraphName)
                %& obj.ExecuteLabTalk(['layer.plot = ' num2str(obj.CurrentPlotNo) ';']);
                %& obj.ExecuteLabTalk(['set %C -cl color(' colour ');']);
                %& obj.ExecuteLabTalk('set %C -w 1000;');
                %& obj.ExecuteLabTalk(['set %C -c color(' colour ');']);
                %& obj.ExecuteLabTalk(['set %C -cf color(' colour ');']);
            
            
            %& obj.ExecuteLabTalk(['page.lname$= ' obj.ActiveGraphName ';'] )
            
            obj.Keyserify;
            plotName = obj.ActiveGraphName;
            %& obj.ActivatePage(obj.ActiveGraphName);
        end
        function plotName = plotMultiY2(obj,X,Y,E,plotName,colour)
            for i = 1:size(Y,1)
                plotName = plotXY(obj,X,Y(i,:),E,201,plotName,colour);
                obj.HoldOn;
                if i < size(Y,2)
                    obj.NewLayer(1,0); %Create a new layer whcih links on X only
                end
            end
        end
        function plotName = plotMultiY3(obj,X,Y,E,plotName,colours, types)
             %http://www.originlab.com/doc/LabTalk/guide/Creating-Graphs#Plotting_X_Y_data
            % Type is plot Type ID as here: http://www.originlab.com/doc/LabTalk/ref/Plot-Type-IDs
            %Create Worksheet  - unless it already exists?
            NoCols = size(Y',2);  
            %Reshape and check sizes here.
            
            Wks = CreateWorkSheet(obj,[plotName ' Data']);
            %Put Data into Worksheet
            if size(E) == size(Y)
               obj. MatrixToOrigin([X',Y',E']);
               e = 1;
            else
                obj.MatrixToOrigin( [X',Y']);
                e = 0;
            end
            %& obj.ExecuteLabTalk( 'wks.col1.type=4;' )
            for i = 1:NoCols
                %& obj.ExecuteLabTalk( ['wks.col' num2str(i+1) '.type=1;'] );
               if e == 1 
                 %& obj.ExecuteLabTalk([' wks.col3.type=' num2str(i+1+NoCols) ';'] );  
               end
            end
            %Create a Graph Page;
            if obj.Hold == 0
               %&  obj.ActiveGraphName = %& inovke(obj.originObj, 'CreatePage', 3,plotName,obj.GraphTemplate);
                obj.NoPlots = 0;
                obj.CurrentPlotNo = 0;
                obj.CurrentLayer = 1;
                obj.NoLayers = 1;
            else
                %Adding to a plot so implement plot no  - if we were goign
                %Increasing the layer is done by a separat func
                %obj.CurrentPlotNo = obj.NoPlots + 1;
                %obj.NoPlots = obj.NoPlots + 1;
            end
            %PLot into existing graph layer 1  - or on to a new layer?
            for i = 1:NoCols
                if e == 0
                    %& obj.ExecuteLabTalk(['plotxy iy:=[' Wks ']Sheet1!(1,' num2str(1+i) ' ) plot:=' types{1} ' ogl:=[' obj.ActiveGraphName ']' num2str(obj.CurrentLayer) '!;'] )
                else
                    %Add Error Bars
                ErrorCol = NoCols + i+1;
                %& obj.ExecuteLabTalk(['plotxy iy:=[' Wks ']Sheet1!(1,' num2str(1+i) ',' num2str(ErrorCol) ') plot:=' type ' ogl:=[' obj.ActiveGraphName ']' num2str(obj.CurrentLayer) '!;'] )
                
                end
                obj.CurrentPlotNo = obj.NoPlots + 1;
                obj.NoPlots = obj.NoPlots + 1;
                
                %& obj.ActivatePage(obj.ActiveGraphName)
                %& obj.ExecuteLabTalk(['layer.plot = ' num2str(obj.CurrentPlotNo) ';']);
                %& obj.ExecuteLabTalk(['set %C -cl color(' colours{i} ');']);
                %& obj.ExecuteLabTalk('set %C -w 1000;');
                %& obj.ExecuteLabTalk(['set %C -c color(' colours{i} ');']);
                %& obj.ExecuteLabTalk(['set %C -cf color(' colours{i} ');']);
                if i<NoCols
                    obj.NewLayer(1,0);
                end
            end
            
            %& obj.ExecuteLabTalk(['page.lname$= ' obj.ActiveGraphName ';'] )
            
            obj.Keyserify;
            plotName = obj.ActiveGraphName;
            %& obj.ActivatePage(obj.ActiveGraphName)
         end
        function NewLayer(obj, Xlink,Ylink)
            %Xlink = 0 for no link 1 for bottom.
            %Ylink = 0 for no link, 1 for left and 2 for right.
            %& obj.ActivatePage(obj.ActiveGraphName);
            if Xlink == 0 && Ylink == 0
                %& obj.ExecuteLabTalk('layer -n Y;');
            else
                %& obj.ExecuteLabTalk('layer -n Y;');
                if Ylink > 0
                    %& obj.ExecuteLabTalk('layer.link = 1;');
                    %& obj.ExecuteLabTalk('layer.y.link = 1;');
                end
                if Xlink > 0
                    %http://www.originlab.com/doc/LabTalk/ref/Layer-Axis-obj
                    %%& obj.ExecuteLabTalk('laylink igl:=1 destlayers:=2:0 XAxis:=1;');
                    %& obj.ExecuteLabTalk('layer.link = 1;');
                    %& obj.ExecuteLabTalk('layer.x.link = 1;');
                    %%& obj.ExecuteLabTalk('layer.x.showAxes = 0;');
                    %%& obj.ExecuteLabTalk('layer.x.showLabels = 0;');
                end
            end
            obj.CurrentLayer = obj.NoLayers + 1;
            obj.NoLayers = obj.CurrentLayer;
        end
        function plotName = plotMultiY(obj,X,Y,E,plotName,types, colours)
            %Select the most developed method of multi Y  plotting - they
            %all have the same effect.
            %Ensures a consistent interface to them
            
            %Need to deal with type and colour being only one or being as
            %many as no Columns
            
            %need to check sizing of X and Y
            if nargin < 7
                colours = obj.colourWheel;
            end
            if nargin < 6
                types = obj.typeWheel;
            end
             plotName = plotMultiY3(obj,X,Y,E,plotName,colours, types);
        end
        function RescaleToShowAll(obj)
            %& obj.ExecuteLabTalk('layer -a;');
        end
        function logYScale(obj)
            %& obj.ExecuteLabTalk('layer.y.type = 2');
            %& obj.ExecuteLabTalk('layer.y.inc = 1');
            obj.RescaleToShowAll;
        end
        function logXScale(obj)
            %& obj.ExecuteLabTalk('layer.x.type = 2');
            %& obj.ExecuteLabTalk('layer.x.inc = 1');
            obj.RescaleToShowAll;
        end
        function Save(obj, Name)
            %http://www.originlab.com/doc/LabTalk/ref/Save-cmd
            if nargin < 2
            %& obj.ExecuteLabTalk('save');
            else
                %& obj.ExecuteLabTalk(['save ' Name]);
            end
        end
        function CloseOrigin(obj)
            %& inovke(obj.originObj, 'Exit');
            obj.Disconnect;
        end
        function Disconnect(obj)
            delete(obj.originObj);
        end
        function [error, Xout, Yout, nRows, nX,nY] = CheckVectors(obj, Xin, Yin)
            Xout = Xin;
            Yout = Yin;
            error = 0;
            nRows = max(size(y));
            nX = min(size(X));
            nY = min(size(Y));
            
            %Need to work out the sizes of the data set and ensure the X
            %and Y have the same number of rows
            %Need X to be either 1, or equal to the no of Y cols
            %Need to output the data in the correct format
            
        end
    end
    
end

