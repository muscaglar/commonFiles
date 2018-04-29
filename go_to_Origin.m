function [] = go_to_Origin(input,name)
%XYZ = catpad(2,data,data2,final_X,final_Y,Vx,Vy,'padval',0);
    ORG = Matlab2OriginPlot();
    ORG.MatrixToOrigin(input, name);
    ORG.Disconnect;
end