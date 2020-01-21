function [total,expTypes,capTypes] = common_getCapbySalt(salt)

DB = DBConnection;
DB2 = DBConnection;
E = Experiments(DB);
CapDB = Capillaries(DB2);

c_ids = [];
Es = [];
Cs = [];

str = ['CapillarySln LIKE ''' salt ''' ORDER BY Capillary ASC'];
E.SELECT(str);

previousID = 0;
cont = 1;

while cont
    if (E.getid() ~= previousID)
        Es = [Es,  E.getCapillary()];
        Cs = [Cs, E.getCapillaryConc()];
        previousID = E.getid;
        E.NextResult();
    else
        cont = 0;
    end
end

[C,IA,IC] = unique(Es);
Es = Es(IA);
Cs = Cs(IA);

total(:,1) = Es';
total(:,2) = Cs';

total = sortrows(total,1);

for i = 1:length(total)
    CapDB.SELECT(total(i,1));
    expType = CapDB.getExptType();
    capType = CapDB.getType();
    expTypes(i) = string(expType);
    capTypes(i) = string(capType);
end

expTypes = expTypes';
capTypes = capTypes';
end