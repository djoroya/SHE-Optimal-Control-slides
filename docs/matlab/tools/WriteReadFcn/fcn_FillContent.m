function [] = fcn_FillContent(SHE,file_h,NumAng)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @file name: fcn_FillContent.m
% #version: 1.0
% #author: ASR 
% #description: fill the content (table) of a .h file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #INPUTS:
%   SHE     		SHE structure
%   NumAng          Number of angles of the first quadrant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #OUTPUTS:
%   .h file filling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[num_lin,num_col] = size(SHE.tbl);

fprintf(file_h,'#define __SHE%d_TABLE__\t { \\\n',NumAng);

for pos_lin=1:num_lin
    fprintf(file_h,'\t\t {');
    for pos_ang=1:num_col        
        if (pos_ang == num_col)
            if (pos_lin == num_lin)
                fprintf(file_h,'%1.8f}  ',SHE.tbl(pos_lin,pos_ang));
            else
                fprintf(file_h,'%1.8f}, ',SHE.tbl(pos_lin,pos_ang));
            end
        else
            fprintf(file_h,'%1.8f,\t',SHE.tbl(pos_lin,pos_ang));
        end
    end
    fprintf(file_h,'\\ \n');
end
fprintf(file_h,'\t\t }\n');
fprintf(file_h,'#define __SHE%d_SIGN__\t {\\\n',NumAng);

[transitions] = fcn_GenerateSheTableTransitions(NumAng);

fprintf(file_h,'\t\t {');
for pos_trans=1:length(transitions)
    if (pos_trans == length(transitions))
        fprintf(file_h,'%d} \\\n',transitions(pos_trans));
    else
        fprintf(file_h,'%d, ',transitions(pos_trans));
    end
end
fprintf(file_h,'\t\t }\n');
fprintf(file_h,'#endif //__MODUL_SHE%d_H',NumAng);