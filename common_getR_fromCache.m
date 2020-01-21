function [result] = common_getR_fromCache()

fileroot = dir('C:\Users\mc934\Dropbox (Team Caglar)\PhD\MATLAB\cache\data');
amp = 'Axopatch';
result = [];
for x = 1:size(fileroot,1)
    
    if(fileroot(x).isdir)
    else
        filename = strcat(fileroot(x).folder,'\',fileroot(x).name);
        output = strsplit(fileroot(x).name,'_');
        output = strsplit(output{2},'.txt');
        
        [resistance, ~] = amoureux_get_R_IV(filename,amp);
        result = [result; str2double(output{1}),resistance];
        delete(filename);
    end
end
end