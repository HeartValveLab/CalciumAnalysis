
project_path='C:\Users\lampertp\Desktop\renee\ReneeTest\real3\omeFiles\';

folder_w=[project_path 'tiff'];
mkdir (folder_w)

suffix='*_ch1.ome';
direc = dir([project_path,filesep,suffix]); zname={};
[zname{1:length(direc),1}] = deal(direc.name);
zname = sort_nat(zname); %sort all image files

for iz=1:length(zname)
    [vol,nz,nt,dx,dy,dz,stackSizeX,stackSizeY] = inport_3Dheart((fullfile(project_path, zname{iz})));
    for it=1:size(vol,4)
        vol2=vol(:,:,:,it);
        %     vol2=zeros(size(vol,1),size(vol,2),2,size(vol,4)/2);
        %     vol2(:,:,1,:)=vol(:,:,:,1:2:size(vol,4));
        %     vol2(:,:,2,:)=vol(:,:,:,2:2:size(vol,4));
        % % % % h=figure(1)
        % % % % hold off
        % % % % hfig=imshow(I,[])
        file_w_rz=['file' '_r0'  '_t' padnumber(3,num2str(it))  '_z' padnumber(3,num2str(iz))  '_ch01.tif'];
        bfsave(vol2, [folder_w,filesep,file_w_rz]);
    end
end

suffix='*_ch2.ome';
direc = dir([project_path,filesep,suffix]); zname={};
[zname{1:length(direc),1}] = deal(direc.name);
zname = sort_nat(zname); %sort all image files

for iz=1:length(zname)
    [vol,nz,nt,dx,dy,dz,stackSizeX,stackSizeY] = inport_3Dheart((fullfile(project_path, zname{iz})));
    for it=1:size(vol,4)
        vol2=vol(:,:,:,it);
        %     vol2=zeros(size(vol,1),size(vol,2),2,size(vol,4)/2);
        %     vol2(:,:,1,:)=vol(:,:,:,1:2:size(vol,4));
        %     vol2(:,:,2,:)=vol(:,:,:,2:2:size(vol,4));
        % % % % h=figure(1)
        % % % % hold off
        % % % % hfig=imshow(I,[])
        file_w_rz=['file' '_r0'  '_t' padnumber(3,num2str(it))  '_z' padnumber(3,num2str(iz))  '_ch02.tif'];
        bfsave(vol2, [folder_w,filesep,file_w_rz]);
    end
end