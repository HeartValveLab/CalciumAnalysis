%% Description:
% This script takes .tif files from the spinning disk 
% and splits into two .tif files - red and green channels - by dividing the
% frame into 2

%%
clear
project_path='\\space2.igbmc.u-strasbg.fr\vermot\Hajime\test_divide\';
name='Separated_test_divide';


folder_w=[project_path 'separated'];
mkdir (folder_w)

%%
suffix='*tif';
direc = dir([project_path,filesep,suffix]); zname={};
[zname{1:length(direc),1}] = deal(direc.name);
zname = sort_nat(zname); %sort all image files


%%

znameIm = cell(length(zname), 5)

for iz=1:length(zname)
    [vol,nz,nt,dx,dy,dz,stackSizeX,stackSizeY] = inport_3Dheart((fullfile(project_path, zname{iz})));

    znameIm{iz,1} = zname(iz);
        im1 = vol(:,1:size(vol,2)/2,1,:);
        im2 = vol(:,(size(vol,2)/2)+1:(size(vol,2)),1,:);
    znameIm{iz,2} = im1;
    znameIm{iz,3} = im2;   
    
end

%%

finalNames = cell(length(zname),2);

for i = 1:length(zname)
    
    file_w_rz_1 = [name  '_c01.tif']
    bfsave(znameIm{i,2}, [folder_w,filesep,file_w_rz_1],'XYZ');
    file_w_rz_2 = [name  '_c02.tif']
    bfsave(znameIm{i,3}, [folder_w,filesep,file_w_rz_2, 'XYZ']);
    
    finalNames{i,1} = file_w_rz_1;
    finalNames{i,2} = file_w_rz_2;
    
end


