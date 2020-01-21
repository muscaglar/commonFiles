classdef Matlab2OriginPlot < M2OPlot
    % Matlab2OriginPlot Code to plot in Origin from Matlab
    %
    %
    % Matlab2OriginPlot Methods:
    %
    % Colours from the labtalk list of colours: http://www.originlab.com/doc/LabTalk/ref/List-of-Colors
    properties
        
    end
    
    methods

        function obj = Matlab2OriginPlot(Name)
            if nargin < 1
                Name = [];
            end
            obj@M2OPlot(Name);
            obj.GraphTemplate = 'KeyserLab';
        end
        function FormatGraph(obj)
            %See http://www.originlab.com/doc/LabTalk/ref/Layer-Axis-obj
            obj.ExecuteLabTalk('layer.x.showAxes = 3;');
            obj.ExecuteLabTalk('layer.y.showAxes = 3;');
            
            %Line thickness
            obj.ExecuteLabTalk('layer.x.thickness = 2;');
            obj.ExecuteLabTalk('layer.y.thickness = 2;');
            obj.ExecuteLabTalk('layer.x2.thickness = 2;');
            obj.ExecuteLabTalk('layer.y2.thickness = 2;');
            
            %Major ticks, including force one at each edge  - with the first tick command
            obj.ExecuteLabTalk('layer.y.majorTicks = 6;');
            obj.ExecuteLabTalk('layer.x.majorTicks = 6;');
            
            %obj.ExecuteLabTalk('i = layer.y.from;');
            %obj.ExecuteLabTalk('layer.y.firstTick = i;');
            %obj.ExecuteLabTalk('i = layer.x.from;');
            %obj.ExecuteLabTalk('layer.x.firstTick = i;');
            
            %Major and Minor in (1+4)
            obj.ExecuteLabTalk('layer.x.ticks  = 5;');
            obj.ExecuteLabTalk('layer.y.ticks  = 5;');
            
            %Set formating of fonts
            %http://www.originlab.com/doc/LabTalk/ref/Layer-Axis-Label-obj
            obj.ExecuteLabTalk('layer.x.label.pt = 28;');
            obj.ExecuteLabTalk('layer.y.label.pt = 28;');
            
            
            % http://www.originlab.com/doc/LabTalk/ref/Label-cmd
            %obj.ExecuteLabTalk('label -p200 -xb;');
            
            %Need to run over all layers and set line thickness and symbol
            %size
            %obj.ExecuteLabTalk('//Set plot line width = 2');
            %obj.ExecuteLabTalk('set %C -w 1000');
        end
    end
    
end

