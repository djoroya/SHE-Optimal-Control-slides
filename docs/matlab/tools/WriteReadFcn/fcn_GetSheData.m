function [value] = fcn_GetSheData(filename,datasearch)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @file name: fcn_GetSheData.m
% #version: 1.0
% #author: ASR / TFS
% #description: reads desired data from SHE .h file.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #INPUTS:
%   filename        Relative path of the file in which the function should search (example: "data/she/SHE_typ7.h")
%                     --> Variable type = string
%   datasearch      Name of the data to find in the file
%                     --> Variable type = string
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #OUTPUTS:
%  value            Value corresponding to "datasearch"
%                     --> Variable type = number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fileID = fopen(filename, 'r');   % Open source file.
tline = fgetl(fileID);

if(strfind(datasearch,'INDMOD')>0)
%     txt2scan = ['%s' '%s' '%s' '%c%f'];
%     pos_value = 5;
    txt2scan = ['%s' '%s' '%s' '%f'];
    pos_value = 4;
else
    txt2scan = ['%s' '%s' '%d'];
    pos_value = 3;
end

while ischar(tline)
    if (strfind(tline,datasearch)>0)   
        line_split = textscan(tline,txt2scan);
        value_aux = cell2mat(line_split(pos_value));
        value = double(value_aux(1));
        break;
    end
    tline = fgetl(fileID);
end
fclose(fileID);