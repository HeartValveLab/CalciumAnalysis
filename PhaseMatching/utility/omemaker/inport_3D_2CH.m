function [vol_ch1,vol_ch2,nz,nc,voxelSizeX,voxelSizeY,voxelSizeZ,stackSizeX,stackSizeY]=inport_3D_2CH(ID)
%% import data using bfopen and related comands
%% input variables
%ID: string; path of the file to load
%nz=number of z points (number of planes) or Stuckes
%nc=number of colors
%%output variables
% Vol(npixx,npixy,nz,nt); where npixx and npixy is the number of pixels along x and y


%% load data; 
volume = bfOpen3DVolume(ID);% volume(:,:,nz*nt)
vol=volume{1}(1);
vol=vol{1};

% get metadata
omeMeta = volume{1, 4};
stackSizeX = omeMeta.getPixelsSizeX(0).getValue(); % image width, pixels
stackSizeY = omeMeta.getPixelsSizeY(0).getValue(); % image height, pixels
stackSizeZ = omeMeta.getPixelsSizeZ(0).getValue(); % number of Z slices
voxelSizeX = omeMeta.getPixelsPhysicalSizeX(0).getValue(); % in ?m
voxelSizeY = omeMeta.getPixelsPhysicalSizeY(0).getValue(); % in ?m
voxelSizeZ = omeMeta.getPixelsPhysicalSizeZ(0).getValue(); % in ?m
% voxelSizeZ =58;
nz=stackSizeZ; % 
nc=size(vol,3)/nz; % number of ch

vol_ch1=vol(:,:,1:2:end-1);
vol_ch2=vol(:,:,2:2:end);
