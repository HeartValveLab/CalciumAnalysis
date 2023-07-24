function [vol,nz,nt,voxelSizeX,voxelSizeY,voxelSizeZ,stackSizeX,stackSizeY]=inport_3Dheart(ID)
%% import data using bfopen and related comands
%% input variables
%ID: string; path of the file to load
%nz=number of z points (number of planes) or Stuckes
%nt=number of time steps (number of frames)
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
voxelSizeX = 0.2162389;  %omeMeta.getPixelsPhysicalSizeX(0).getValue(); % in ?m
voxelSizeY = 0.2162389;  %omeMeta.getPixelsPhysicalSizeY(0).getValue(); % in ?m
voxelSizeZ = 0.8512000; %omeMeta.getPixelsPhysicalSizeZ(0).getValue(); % in ?m
% voxelSizeZ =58;
nz=stackSizeZ; % 
nt=size(vol,3)/nz;

vol= reshape(vol,size(vol,1),size(vol,2),nz,nt);
