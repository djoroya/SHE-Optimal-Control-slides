function [Enum] = fcn_EnumTypeSHE(lvl)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @file name: fcn_EnumTypeSHE.m
% #version: 1.02
% #author: ASR / TFS / HFR / STE
% #description:     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #INPUTS:          lvl - String: number of levels of the SHE modulation (lvl=3, lvl=5, lvl=7,...)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% #OUTPUTS:         Structure with all the SHE modulations available%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin==0
	lvl = 3;
end

Enum_TypeSHE = struct();
%% Enum TypeSHE

Enum.TYPE_SHE5A.ID = 1;
Enum.TYPE_SHE5B.ID = 2;


Enum.TYPE_SHE5A.FileName = 'modul_she5A.h';
Enum.TYPE_SHE5B.FileName = 'modul_she5B.h';
%%

Enum.TWOLVL.ID = 3;
Enum.TWOLVL.FileName = '2lshe5A_1_Format2L.h';

