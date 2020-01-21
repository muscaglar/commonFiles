function [] = go_to_Origin(input,name)

    ORG = Matlab2OriginPlot();
    ORG.MatrixToOrigin(input, name);
    ORG.Disconnect;
end