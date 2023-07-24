function[error]=omemaker_importcorrect_timelapse(project_path,nx,ny,nt,nr)

name='omeFiles'
folder_w=[project_path 'omeFiles'];
mkdir (folder_w)

suffix='*tif';
direc = dir([project_path,filesep,suffix]); zname={};
[zname{1:length(direc),1}] = deal(direc.name);
zname = sort_nat(zname); %sort all image files

for iz=1:2:length(zname)
    error=0;
    [vol_ch1,~,~,~,~,~,~,~] = inport_3Dheart((fullfile(project_path, zname{(iz)}))); %green ch
    [vol_ch2,~,~,~,~,~,~,~] = inport_3Dheart((fullfile(project_path, zname{iz+1}))); %red ch
    indz=floor(iz/(nr*2))+1;
    countr=floor((iz-((nr*2)*(floor(iz/(nr*2)))))/2)+1;
    nnx=ny;
    ny=nx;
    nx=nnx;
    nx2=size(vol_ch2,1);
    nx1=size(vol_ch1,1);
    ny2=size(vol_ch2,2);
    ny1=size(vol_ch1,2);
    nt2=size(vol_ch2,4);
    nt1=size(vol_ch1,4);
    if (nt2==nt*2 && ny2==ny/2)
        t=size(vol_ch1,4)/2;
        count=1;
        im=zeros(size(vol_ch1,1),size(vol_ch1,2)*2,1,2,t,'uint16');
        for ii=1:2:size(vol_ch1,4)
            im(:,1:size(vol_ch1,2),1,1,count)=vol_ch1(:,:,1,ii);
            im(:,size(vol_ch1,2)+1:size(vol_ch1,2)*2,1,1,count)=vol_ch1(:,:,1,ii+1);
            im(:,1:size(vol_ch1,2),1,2,count)=vol_ch2(:,:,1,ii);
            im(:,size(vol_ch1,2)+1:size(vol_ch1,2)*2,1,2,count)=vol_ch2(:,:,1,ii+1);
            count=count+1;
        end
        file_w_rz=[name '_r' padnumber(3,num2str(countr)) '_z' padnumber(3,num2str(indz)) '.ome'];
        bfsave(im, [folder_w,filesep,file_w_rz]);
        error=2
    else
        error=0
        if nx2~=nx
            display('Properties of imported image not matching properties original file!')
            error=1
        end
        if nx1~=nx
            display('Properties of imported image not matching properties original file!')
            error=1
        end
        if ny2~=ny
            display('Properties of imported image not matching properties original file!')
            error=1
        end
        if ny1~=ny
            display('Properties of imported image not matching properties original file!')
            error=1
        end
        if nt2~=nt
            display('Properties of imported image not matching properties original file!')
            error=1
        end
        if nt1~=nt
            display('Properties of imported image not matching properties original file!')
            error=1
        end
        t=size(vol_ch1,4);
        count=1;
        im=zeros(size(vol_ch1,1),size(vol_ch1,2),1,2,t,'uint16');
        for ii=1:t
            im(:,:,1,1,count)=vol_ch1(:,:,1,ii);
            im(:,:,1,2,count)=vol_ch2(:,:,1,ii);
            count=count+1;
        end
        file_w_rz=[name '_r' padnumber(3,num2str(countr)) '_z' padnumber(3,num2str(indz)) '.ome'];
        bfsave(im, [folder_w,filesep,file_w_rz]);
        if error==1
            break
        end
    end
end

