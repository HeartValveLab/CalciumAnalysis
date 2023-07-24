%% Description:
% This script takes .tif files from the spinning disk 
% and splits into two channels - red and green channels - by dividing the
% frame into 2
% Then writes the ome files

%%
clear
project_path='\\space2.igbmc.u-strasbg.fr\vermot\chowr\ImagingExpts\SpinningDisk\SD85_timelapse\';
% number of channels
nC=2
% number of frames
Nt=80
% number of z planes
nz=19
% number of repeats (developmental time points)
nr = 17;

name='SD85'



folder_w=[project_path 'separated'];
mkdir (folder_w)

%%
suffix='*tif';
direc = dir([project_path,filesep,suffix]); zname={};
[zname{1:length(direc),1}] = deal(direc.name);
zname = sort_nat(zname); %sort all image files


%%

znameIm = cell(length(zname), 6)

for iz=1:length(zname)
    [vol,nz,nt,dx,dy,dz,stackSizeX,stackSizeY] = inport_3Dheart((fullfile(project_path, zname{iz})));
     
    znameIm{iz,1} = zname(iz);
        im1 = vol(:,1:size(vol,2)/2,1,:);
        im2 = vol(:,(size(vol,2)/2)+1:(size(vol,2)),1,:);   
        im=zeros(size(im1,1),size(im2,2),1,2,nt,'uint16');
        im(:,:,1,1,:)=im1;
        im(:,:,1,2,:)=im2;  
        
    znameIm{iz,2} = im1;
    znameIm{iz,3} = im2;   
    znameIm{iz,6} = im;

    zplane      =   padnumber(3,str2num(char(extractBefore(extractAfter(zname{iz},'_z_'),'_t'))));
    rTimepoint	=	padnumber(3,str2num(char(extractBefore(extractAfter(zname{iz},'_t_'),'.tif'))));
   
    znameIm{iz,4} = zplane;
    znameIm{iz,5} = rTimepoint;
    
end

%%

finalNames = cell(length(zname),2);

for i = 1:length(zname)
    
    file_w_rz_1 = [name  '_r' znameIm{i,5} '_z'  znameIm{i,4} '.ome']
    bfsave(znameIm{i,6}, [folder_w,filesep,file_w_rz_1]);
    
    finalNames{i,1} = file_w_rz_1;

    
end


