function [output_ids] = common_getMembraneIDS(membrane)
numMem = 88;
DB = DBConnection;
memSelection = Membranes(DB);
memIDs = 1:1:numMem;
memName = [];
for memID = memIDs
    memSelection.setid(0);
    str = ['id'];
    str2 = num2str(memID);
    memSelection.SELECT(str,str2);
    memName = [memName,string(memSelection.getMaterial())];
end
memSelection.CloseConnection;
memName = memName';
output_ids = memIDs(memName == membrane)';
end