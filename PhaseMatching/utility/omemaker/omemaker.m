function[]=omemaker(project_path,nx)

name='omeFiles'
folder_w=[project_path 'omeFiles'];
mkdir (folder_w)

suffix='*tif';
direc = dir([project_path,filesep,suffix]); zname={};
[zname{1:length(direc),1}] = deal(direc.name);
zname = sort_nat(zname); %sort all image files

indz=1;
for iz=1:2:length(zname)
    [vol_ch1,~,~,~,~,~,~,~] = inport_3Dheart((fullfile(project_path, zname{iz}))); %green ch
    [vol_ch2,~,~,~,~,~,~,~] = inport_3Dheart((fullfile(project_path, zname{iz+1}))); %red ch
    nx2=size(vol_ch2,2);
    t=1:size(vol_ch1,4)/2;
    count=1;  
    if nx2==floor(nx/2)
        im=zeros(size(vol_ch1,1),nx2*2,1,2,length(t),'uint16');
        for ii=1:2:size(vol_ch1,4)
            im(:,1:size(vol_ch1,2),1,1,count)=vol_ch1(:,:,1,ii);
            im(:,size(vol_ch1,2)+1:size(vol_ch1,2)*2,1,1,count)=vol_ch1(:,:,1,ii+1);
            im(:,1:size(vol_ch1,2),1,2,count)=vol_ch2(:,:,1,ii);
            im(:,size(vol_ch1,2)+1:size(vol_ch1,2)*2,1,2,count)=vol_ch2(:,:,1,ii+1);
            count=count+1;
        end
    else
        im=zeros(size(vol_ch1,1),size(vol_ch1,2)*2,1,2,length(t),'uint16');
        for ii=1:2:size(vol_ch1,4)
            im(:,1:size(vol_ch1,2),1,1,count)=vol_ch1(:,:,1,ii);
            im(:,size(vol_ch1,2)+1:size(vol_ch1,2)*2,1,1,count)=vol_ch1(:,:,1,ii+1);
            im(:,1:size(vol_ch1,2),1,2,count)=vol_ch2(:,:,1,ii);
            im(:,size(vol_ch1,2)+1:size(vol_ch1,2)*2,1,2,count)=vol_ch2(:,:,1,ii+1);
            count=count+1;
        end
    end
    file_w_rz=[name '_r0'  '_z' padnumber(3,num2str(indz)) '.ome'];
    bfsave(im, [folder_w,filesep,file_w_rz]);
    indz=indz+1;   
end

