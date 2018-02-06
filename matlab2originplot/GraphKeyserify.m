function [  ] = GraphKeyserify( h )
%Convert the plot passed into it to Keyser style
% Derived from Karolis' Code FigureBSS but without the file saving

    % use default size - calibrated to look alike to origin
    sizeX = 12;
    sizeY = (sizeX*10/14);


if (nargin < 1)
    fig = gcf;
end

set(fig, 'PaperPositionMode', 'manual');
set(fig, 'PaperUnits', 'centimeters');
set(fig, 'PaperPosition', [0 0 sizeX sizeY]);
set(fig, 'PaperSize', [sizeX sizeY]);

% set text size:
textobj = findobj('type', 'text');
set(textobj, 'FontUnits', 'points');
set(textobj, 'FontSize', 12); % unknown if works?
set(textobj,'FontName', 'Arial')
set(textobj, 'FontWeight', 'light');

% set line width in plot
lineobj = findobj('type', 'line');
set(lineobj, 'linewidth', 1);

% set axes line width and number size
set(gca,'FontSize',12,'FontWeight','light','linewidth',1);

set(gca,'XMinorTick','off');
set(gca,'YMinorTick','off');

% get axes pointer
axes = get(gcf, 'CurrentAxes');
%myLegend =  legend(axis) % moves legend for some reason

% hide box of legend
legend boxoff;

% set number of major ticks
tmpNumTicks = 6;
tmpL = get(gca,'YLim');
%set(gca,'YTick',linspace(tmpL(1),tmpL(2),tmpNumTicks));
tmpNumTicks = 6;
tmpL = get(gca,'XLim');
%set(gca,'XTick',linspace(tmpL(1),tmpL(2),tmpNumTicks));


% set axes text size
xlhand = get(gca,'xlabel');
set(xlhand ,'FontSize',12, 'FontWeight', 'light');
ylhand = get(gca,'ylabel');
set(ylhand ,'FontSize',12, 'FontWeight', 'light');


%Set Font 
%gcf is the current figure

end

