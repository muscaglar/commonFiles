function [keep_Caps] = common_filterCapbyMembrane(cIDs, mIDs)

keep_Caps = [];

SealedSuppression = [0 20];
DB = DBConnection;
E = Experiments(DB);

if(size(cIDs,2) == 1)
    cIDs = reshape(cIDs,1,size(cIDs,1));
end

for cID = cIDs
    str = ['Capillary = ''' num2str(cID) ''' AND ' ConcatVectorToSQL( SealedSuppression, 'Suppressed') ' AND Sealed > 0 ORDER BY No ASC'];
    E.SELECT(str);
    sealed_mem = E.getSealed();
    if(ismember(sealed_mem,mIDs))
        keep_Caps = [keep_Caps, cID];
    end
end

E.CloseConnection;

end