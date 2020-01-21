function [summary] = common_getCapbySaltMembrane(membrane,salt)

[output_ids] = common_getMembraneIDS(membrane);
[total,~,~] = common_getCapbySalt(salt);

capIDs = total(:,1);
membIDs = output_ids;

[relevantCaps] = common_filterCapbyMembrane(capIDs,membIDs);

if(size(relevantCaps,2) == 1)
    relevantCaps = reshape(relevantCaps,1,size(relevantCaps,1));
end

summary = [];

for relevantCap = relevantCaps
    [bare_conc,sealed_conc,bare_resistance,sealed_resistance] = getMembraneRes(relevantCap);
    if(isempty(bare_conc))
        bare_conc = 0;
    end
    bare_conc = ones(size(sealed_conc)).*bare_conc;
    bare_resistance = ones(size(sealed_conc)).*bare_resistance;
    relevantCap = ones(size(sealed_conc)).*relevantCap;
    summary = [summary; relevantCap', bare_conc',sealed_conc',bare_resistance',sealed_resistance'];    
end

end