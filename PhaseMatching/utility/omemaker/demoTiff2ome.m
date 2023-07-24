project_path='C:\Users\rzha0171\Documents\UROP\Tif-0-499\ImageSequence\';

file_w='C:\Users\rzha0171\Documents\UROP\Tif-0-499\demoTiff2ome_out\';% output folder
                                           
% number of channels
nC=2
% number of repeats (developmental time points)
nr=1
% number of frames
nt=21
% number of z planes
nz=37
dz=1
%% define order of the files depending on how they were exported
% order as exported from sp8 'zrct'
% order='zrct';
% FromLightSheet=1;% set to 1 for 16 bit images

%% file exported from fiji (single developmental point) exported from sp8 'zrct'
%  order='tzc';

%% file exported from lightSheet microscope (single developmental point) exported from sp8 'zrct'
order='tzc'; % only single channel tested so far
%%
voxelSizeY=1;

tiffs2ome01(project_path,file_w,nC,nr,nt,nz,voxelSizeY,dz,order)

%% commands to copy things to the cluster
%  rsync -avz  \\serv-v-ima-1\Vermot\Marina\EpiGFP_55hpf\omeFiles  boselli@surf:/data7/boselli/beatsync2_0/data/ 
