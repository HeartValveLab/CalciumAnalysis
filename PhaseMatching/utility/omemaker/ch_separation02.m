%% this script takes the .tif files from the spinning disk
clear
project_path='Y:\AnneLaure\velocity\144hpf\fish2\4-2\';
% number of channels
nC=2
% number of frames
Nt=1000
% number of z planes
nz=22

name='Separated'

folder_w=[project_path 'separated'];
mkdir (folder_w)

suffix='*tif';
direc = dir([project_path,filesep,suffix]); zname={};
[zname{1:length(direc),1}] = deal(direc.name);
zname = sort_nat(zname); %sort all image files

t1=1;
tend=length(zname)%+t1;

if nz==1
        for it=1:length(zname)
            [vol,nz,nt,dx,dy,dz,stackSizeX,stackSizeY] = inport_3Dheart((fullfile(project_path, zname{it})));
            im1(:,1:size(vol,2)/2)=vol(:,1:size(vol,2)/2);
            file_w_rz=[name  '_t'  padnumber(3,num2str(it)) '_z01_c01' '.tif'];
            bfsave(im1, [folder_w,filesep,file_w_rz]);
            im2(:,1:size(vol,2)/2)=vol(:,(size(vol,2)/2)+1:(size(vol,2)));
            file_w_rz=[name  '_t'  padnumber(3,num2str(it)) '_z01_c02' '.tif'];
            bfsave(im2, [folder_w,filesep,file_w_rz]);
        end
    
    % number of repeats (developmental time points)
    nr=1
    project_path=folder_w;
    file_w=folder_w;% output folder
    dz=1;
    order='tzc';
    voxelSizeY=1;
    tiffs2ome01(project_path,file_w,nC,nr,Nt,nz,voxelSizeY,dz,order)
else
    for iz=1:length(zname)
        [vol,nz,nt,dx,dy,dz,stackSizeX,stackSizeY] = inport_3Dheart((fullfile(project_path, zname{iz})));
        t=1:size(vol,4)/2;
        count=1;
        for ii=1:2:size(vol,4)
            im1=vol(:,:,1,ii);
            im2=vol(:,:,1,ii+1);
            file_w_rz=[name  '_t'  padnumber(3,num2str(t(count))) '_z' padnumber(3,num2str(iz)) '_ch01.tif']
            bfsave(im1, [folder_w,filesep,file_w_rz]);
            file_w_rz=[name  '_t'  padnumber(3,num2str(t(count))) '_z' padnumber(3,num2str(iz)) '_ch02.tif']
            bfsave(im2, [folder_w,filesep,file_w_rz]);
            count=count+1;
        end
    end
    
    %%
    % number of repeats (developmental time points)
    nr=1
    project_path=folder_w;
    file_w=folder_w;% output folder
    dz=1;
    order='tzc';
    voxelSizeY=1;
    tiffs2ome01(project_path,file_w,nC,nr,Nt,nz,voxelSizeY,dz,order)
end



