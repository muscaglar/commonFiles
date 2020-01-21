function [output] = common_batch_TDMS(sample_freq)

fileroot = uigetdir;
files = dir(fullfile(fileroot,'*.tdms'));
voltage = [];
current = [];

for i = 1:numel(files)
    if(ispc)
        filepath = char(strcat(fileroot,'\',files(i).name));
    else
        filepath = char(strcat(fileroot,'/',files(i).name));
    end
    result = convertTDMS(0,filepath);
    voltage = [voltage, result.Data.MeasuredData(3).Data'];
    current = [current, result.Data.MeasuredData(4).Data'];
end

time = 0:1/sample_freq:(length(current)-1)/sample_freq;

save(fullfile(fileroot,'IV.mat'),'voltage','current','time');

end