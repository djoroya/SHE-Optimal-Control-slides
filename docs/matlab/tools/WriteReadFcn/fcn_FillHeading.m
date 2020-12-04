function [] = fcn_FillHeading(SHE,file_h,NumAng)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @file name: fcn_FillHeading.m
% #version: 1.0
% #author: ASR 
% #description: fill the heading of a .h file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #INPUTS:
%   SHE     		SHE structure
%   NumAng          Number of angles of the first quadrant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #OUTPUTS:
%   .h file filling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ifdef = sprintf ('__MODUL_SHE%d_H', NumAng);
fprintf(file_h,'#ifndef %s\n',ifdef);
fprintf(file_h,'#define %s\n\n',ifdef);

fprintf(file_h,'#define __SHE%d_MAX_ANG__\t %du\n',SHE.params.NumAngs,SHE.params.NumAngs);
fprintf(file_h,'#define __SHE%d_DATA_NUM__\t %d\n',SHE.params.NumAngs,SHE.params.NumData);
fprintf(file_h,'#define __SHE%d_VECT_NUM__ \t (4*__SHE%d_MAX_ANG__ + 1)\n',SHE.params.NumAngs,SHE.params.NumAngs);
fprintf(file_h,'#define __SHE%d_INDMODMIN__\t (F_32)\t %1.8f //(%1.3f * 4.0/_PI * _r3d2)\n',NumAng,(SHE.params.maMin * 4/pi*sqrt(3)/2),SHE.params.maMin);
fprintf(file_h,'#define __SHE%d_INDMODMAX__\t (F_32)\t %1.8f //(%1.3f * 4.0/_PI * _r3d2)\n',NumAng,(SHE.params.maMax * 4/pi*sqrt(3)/2),SHE.params.maMax);
