function [SHEparams] = fcn_ReadTrunkSHE(SHEModName,folderSHE_Files)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @file name: fcn_GetSheData.m
% #version: 1.0
% #author: ASR / TFS
% #description: extract from a .h file all the data of the SHE modulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #INPUTS:
%   SHEModName      Name of the SHE modulation (see file "fcn_EnumTypeSHE.m")
%                     --> Variable type = string
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #OUTPUTS:
%   SHEparams       Parameters extracted of the SHE modulation
%                     --> Variable type = structure array
%                      |-> SHEparams.NumData : number of angle sets between min and max modulation index
%                      |-> SHEparams.NumAngs : number of angles
%                      |-> SHEparams.maMin : minimum modulation index
%                      |-> SHEparams.maMax : maximum modulation index
%                      |-> SHEparams.table : all the angles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Check number of inputs
if nargin==1
    % Path of the folder with the SHE .h files
    if ~isdeployed
        folderSHE_Files = '../IJA/trunkSHE';
    else
        folderSHE_Files = '';
    end  
end



% Check if folder exists
if ~isdeployed
    if(exist(folderSHE_Files, 'dir') ~= 7)
        error('Folder with SHE files not found. Program stopped. Please enter the correct path of the folder with the SHE files in the file "fcn_ReadTrunkSHE.m"');
    end
end

EnumSHE = fcn_EnumTypeSHE();
filename = EnumSHE.(SHEModName).FileName;

filenamepath = sprintf('%s/%s',folderSHE_Files,filename);

% Check if the file exists
if ~isdeployed
    if(exist( filenamepath, 'file') ~= 2)
        error('File with SHE data not found. Program stopped. See function "fcn_ReadTrunkSHE.m"');
    end
end

SHEparams = struct();
SHEparams.NumData = fcn_GetSheData(filenamepath,'DATA_NUM');
SHEparams.NumAngs = fcn_GetSheData(filenamepath,'MAX_ANG');
% SHEparams.maMin = fcn_GetSheData(filenamepath,'INDMODMIN') * pi/4*2/sqrt(3);
% SHEparams.maMax = fcn_GetSheData(filenamepath,'INDMODMAX') * pi/4*2/sqrt(3);
SHEparams.maMin = fcn_GetSheData(filenamepath,'INDMODMIN');
SHEparams.maMax = fcn_GetSheData(filenamepath,'INDMODMAX');


num_line = 0;
fileID = fopen(filenamepath, 'r') ;              % Open source file.
tline = fgetl(fileID);
while ischar(tline)
    num_line = num_line + 1;
    if (strfind(tline,'{0')>0)
        ini_col = strfind(tline,'{0');
        ini_lin = num_line;
        break;
    elseif (strfind(tline,'{1')>0)  
        ini_col = strfind(tline,'{1');
        ini_lin = num_line;
        break;
    end
    tline = fgetl(fileID);
end
fclose(fileID);

fileID = fopen(filenamepath, 'r');
for num_line=1:(ini_lin-1)
   fgetl(fileID);     
end 

for num_liner=1:SHEparams.NumData
   tline = fgetl(fileID);
   tline(strfind(tline, '{')) = [];
   tline(strfind(tline, ',')) = [];
   [data,count] = sscanf(tline,'%f');        
   SHEparams.table(num_liner,:) = data;
end
fclose(fileID);