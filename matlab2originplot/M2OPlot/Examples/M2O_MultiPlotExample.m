M2O = M2OPlot_YOURFORMAT();

x = 1:0.1:2*pi;
Y = [2*sin(x); 3*cos(x)];

M2O.plotMultiY(x,Y,0,'MultiY');

M2O.Disconnect;