function [ ChannelData ] = SelectColumn(TDMSoutput, channel)
%SelectColumn Select Data Columns from the TDMS File
%   Select columns from the TDMS file output  - note could even wrap the
%   whole thing so you pass in the file name and get the columns out
%       column can be a row vector and will select all pertaining columns

%NB cannot just pass the row vector in as the index  - it doens't work
n = 1;
for i = channel
    %TDMSoutput.data
    if(size(TDMSoutput.data,2) >= i)
        %size(TDMSoutput.data)
        ChannelData(:,n) = TDMSoutput.data{i}';
    else
        ChannelData = [];
    end
    n = n + 1;
end

end
