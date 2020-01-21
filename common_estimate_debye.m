function [ debye ] = common_estimate_debye(valencyCat,valencyAn,c_M)

PhysicalConsts
lb = 7E-10;
debye = (1E9)/sqrt((4*pi*lb*((N_A_Const*(c_M*1E3))*(valencyCat*(valencyAn^2)+valencyAn*(valencyCat^2)))));
%debye = sqrt( Kb_Const*epsilon_0_Const*T_Const / ((N_A_Const/(c_M*1E3)) *(valencyCat*valencyAn^2+valencyAn*valencyCat^2) ) );
end