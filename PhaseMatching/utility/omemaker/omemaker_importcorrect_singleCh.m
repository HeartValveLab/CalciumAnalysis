%% this script takes the .tif files from the spinning disk
clear
project_path='\\space.igbmc.u-strasbg.fr\igbmc\vermot\chowr\ImagingExpts\SpinningDisk\SD43_2018_10_27_photoconverted\E21_cellInside\';

nx=1024
ny=512
nt=60
nr=44

name='omeFiles'
folder_w=[project_path 'omeFiles'];
mkdir (folder_w)

suffix='*tif';
direc = dir([project_path,filesep,suffix]); zname={};
[zname{1:length(direc),1}] = deal(direc.name);
zname = sort_nat(zname); %sort all image files

indz=1;
if nr>1
    error=omemaker_importcorrect_timelapse_singleCh(project_path,nx,ny,nt,nr)
else 
    for iz=1:length(zname)
        error=0;
        [vol_ch1,~,~,~,~,~,~,~] = inport_3Dheart((fullfile(project_path, zname{iz}))); %green ch
        %[vol_ch2,~,~,~,~,~,~,~] = inport_3Dheart((fullfile(project_path, zname{iz+1}))); %red ch    
        %nx2=size(vol_ch2,2);
        nx1=size(vol_ch1,2);
        %ny2=size(vol_ch2,1);
        ny1=size(vol_ch1,1);
        %nt2=size(vol_ch2,4);
        nt1=size(vol_ch1,4);
        if (nt1==nt*2 && nx1==nx/2) || (nt1==nt*2 && nx1==ceil(nx/2)) || (nt1==nt*2 && nx1==floor(nx/2))
            omemaker(project_path,nx);
            error=2;
        else
            %if nx2~=nx
            %    display('Properties of imported image not matching properties original file!')
            %    error=1;
            %end
            if nx1~=nx
                display('Properties of imported image not matching properties original file!')
                error=1;
            end
            %if ny2~=ny
            %    display('Properties of imported image not matching properties original file!')
            %    error=1;
            %end
            if ny1~=ny
                display('Properties of imported image not matching properties original file!')
                error=1;
            end
            %if nt2~=nt
            %    display('Properties of imported image not matching properties original file!')
            %    error=1;
            %end
            if nt1~=nt
                display('Properties of imported image not matching properties original file!')
                error=1;
            end           
            t=size(vol_ch1,4);
            count=1;
            im=zeros(size(vol_ch1,1),size(vol_ch1,2),1,1,t,'uint16');
            for ii=1:t
                im(:,:,1,1,count)=vol_ch1(:,:,1,ii);
                %im(:,:,1,2,count)=vol_ch2(:,:,1,ii);
                count=count+1;
            end
            file_w_rz=[name '_r0'  '_z' padnumber(3,num2str(indz)) '.ome'];
            bfsave(im, [folder_w,filesep,file_w_rz]);
            indz=indz+1;
        end
        if error==1
            break
        end
        if error==2
            break
        end
    end
end
