function [ nernstV_mV ] = common_nernst(valency,c1,c2)

PhysicalConsts
v = 2.3026 * R_Const * (T_Const / (valency * F_Const)) .* log10((c1 ./ c2));
nernstV_mV = v * 1000;

end