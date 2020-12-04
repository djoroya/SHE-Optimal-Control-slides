function [] = fcn_FillIncludes(syst_st,SHE)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @file name: fcn_FillIncludes.m
% #version: 1.0
% #author: ASR 
% #description: fill and create the .h file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #INPUTS:
%   syst_st			Structure with system information
%	SHE     		SHE structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #OUTPUTS:
%   .h file filling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syst_st.out.SolPos
cd(syst_st.config.dir.outputs);

for pos_NumAng=1:11
    if (syst_st.out.SolPos(pos_NumAng) > 0)
        fname = sprintf('modul_she%d.h',pos_NumAng);       
        file_h = fopen(fname,'w');
        
        fcn_FillHeading(SHE(syst_st.out.SolPos(pos_NumAng)),file_h,pos_NumAng)
        fcn_FillContent(SHE(syst_st.out.SolPos(pos_NumAng)),file_h,pos_NumAng)
        
        fclose(file_h);
    end    
end