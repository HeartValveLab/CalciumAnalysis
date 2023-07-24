%% the project is in
function tiffs2ome01(project_path,file_w,nC,nr,nt,nz,voxelSizeY,dz,order)
%% project_path : path to folder with tiff files
%% file_w : name of output files

%project_path='Z:\Emily\SP8_livedatamode\150327_72hpf_speed tests\150327_512by180_70fps_tif';
% save with file name suffix file_w
% file_w  = '150327_512by200_66fps_heart1';
% save stacks in
mkdir (file_w)
folder_w=[file_w '/omeFiles'];
mkdir (folder_w)
% %pixel size
% voxelSizeY=0.4;
% dz=3;

% % number of colors
% nC=2
% % number of repeats (developmental time points)
% nr=1
% % number of frames
% nt= 40
%% find nz  (namber of zplane (jobs))
% if nr==1
suffix='*tif';
direc = dir([project_path,filesep,suffix]); zname={};
[zname{1:length(direc),1}] = deal(direc.name);
zname = sort_nat(zname); %sort all image files
%nz= length(zname)/nC/nt/nr;
if (nz*nC*nt*nr)~=length(zname)
    error('bad values for nz,nt,nr,nC')
end
% else
%     error
% end

imdim=size(imread([project_path,filesep,zname{1}]));

%% find nt (namber of ts)






%%
if 1%FromLightSheet==1
    vol=zeros(imdim(1),imdim(2),1,nC,nt,'uint16');
else
  vol=zeros(imdim(1),imdim(2),1,nC,nt,'uint8');
end

switch order
    
    case 'zrct'
        tic
        for iz= 1:nz %loop on z positions
            indxz=((iz-1)*(nt*nC*nr)  + 1) : (iz*(nt*nC*nr));
            for ir=1:nr
                indxzr=indxz((ir-1)*(nt*nC) + 1 : ir*(nt*nC));
                for ic=1:nC
                    indxzrc=indxzr( ic : nC : nt*nC +ic-nC);
                    tname=zname(indxzrc);
                    for it=1:nt
                        tnamer=tname(it);
                        vol(:,:,1,ic,it)=imread([project_path,filesep,tnamer{:}]);
                        %                 imshow(vol(:,:,1,ic,it),[])
                        display(tnamer)
                        %                 drawnow
                        %                      pause(0.1)
                    end
                end
                %     pause
                %% save z_r_stack
                %         metadata = createMinimalOMEXMLMetadata(vol);
                %         pixelSize = ome.xml.model.primitives.PositiveFloat(java.lang.Double(voxelSizeY));
                %         metadata.setPixelsPhysicalSizeX(pixelSize, 0);
                %         metadata.setPixelsPhysicalSizeY(pixelSize, 0);
                %         pixelSizeZ = ome.xml.model.primitives.PositiveFloat(java.lang.Double(dz));
                %         metadata.setPixelsPhysicalSizeZ(pixelSizeZ, 0);
                file_w_rz=['Omefile' '_r'  padnumber(3,num2str(ir)) '_z' padnumber(3,num2str(iz)) '.ome'];
                bfsave(vol, [folder_w,filesep,file_w_rz]);
                
            end
        end
        toc
        
    case 'tzc'
        tic
        
        
        %             for ir=1:nr
        %                 indxzr=indxz((ir-1)*(nt*nC) + 1 : ir*(nt*nC));
        for iz=1:nz
            for ic= 1:nC %loop on z positions
                indxc=((ic-1)+1):nC:(nt*nC*nz+(ic-2));
                %                 cnames=zname(indxc);
                
                indxcz=indxc( iz : nz : nt*nz+iz-nz);
                tname=zname(indxcz);
                
                for it=1:nt
                    tnamer=tname(it);
                    vol(:,:,1,ic,it)=imread([project_path,filesep,tnamer{:}]);
                    %                 imshow(vol(:,:,1,ic,it),[])
                    display(tnamer)
                    %                 drawnow
                    %                      pause(0.1)
                end
            end
            %     pause
            %% save z_r_stack
            %         metadata = createMinimalOMEXMLMetadata(vol);
            %         pixelSize = ome.xml.model.primitives.PositiveFloat(java.lang.Double(voxelSizeY));
            %         metadata.setPixelsPhysicalSizeX(pixelSize, 0);
            %         metadata.setPixelsPhysicalSizeY(pixelSize, 0);
            %         pixelSizeZ = ome.xml.model.primitives.PositiveFloat(java.lang.Double(dz));
            %         metadata.setPixelsPhysicalSizeZ(pixelSizeZ, 0);
            %                 file_w_rz=[file_w '_r'  padnumber(3,num2str(ir)) '_z' padnumber(3,num2str(iz)) '.ome'];
            file_w_rz=['Omefile' '_r0'  '_z' padnumber(3,num2str(iz)) '.ome'];
            bfsave(vol, [folder_w,filesep,file_w_rz]);
            
            %             end
        end
        toc
        
    case 'rzt'
        vol=zeros(imdim(1),imdim(2),1,nC,nt,'uint16');        
        tic
        for ir=1:nr
            indxr=(ir-1)*(nt*nC*nz) + 1 : ir*(nt*nC*nz);
            for iz= 1:nz %loop on z positions
                indxrz=indxr(((iz-1)*(nt*nC)  + 1) : (iz*(nt*nC)));
                
                for ic=1:nC
                    indxrzc=indxrz( ic : nC : nt*nC +ic-nC);
                    tname=zname(indxrzc);
                    for it=1:nt
                        tnamer=tname(it);
                        img16=imread([project_path,filesep,tnamer{:}]);
%                          I8 =uint8(double(img16)/(2^16-1)*255);
%                         img8 = uint8( (double(img16) - double(min(img16(:))))/(double(max(img16(:))) - double(min(img16(:)))) * 255 ); 
                        vol(:,:,1,ic,it)=img16;
%                         Two options (assuming 16 bit unsigned)
% 
%                       1. Use the the whole 16 bit range
% 
%                       img8 = uint8(double(img16)/(2^16-1))*255;
% 
%                       2. Using the [min max] range in the 16 bit array
% 
%                           img8 = uint8( (double(img16) - double(min(img16(:)))) /
%                        (double(max(img16(:))) - double(min(img16(:)))) * 255 ); 
                        %                 imshow(vol(:,:,1,ic,it),[])
                        display(tnamer)
                        %                 drawnow
                        %                      pause(0.1)
                    end
                end
                %     pause
                %% save z_r_stack
                %         metadata = createMinimalOMEXMLMetadata(vol);
                %         pixelSize = ome.xml.model.primitives.PositiveFloat(java.lang.Double(voxelSizeY));
                %         metadata.setPixelsPhysicalSizeX(pixelSize, 0);
                %         metadata.setPixelsPhysicalSizeY(pixelSize, 0);
                %         pixelSizeZ = ome.xml.model.primitives.PositiveFloat(java.lang.Double(dz));
                %         metadata.setPixelsPhysicalSizeZ(pixelSizeZ, 0);
                file_w_rz=['Omefile' '_r'  padnumber(3,num2str(ir)) '_z' padnumber(3,num2str(iz)) '.ome'];
                bfsave(vol, [folder_w,filesep,file_w_rz]);
                
            end
        end
        toc
        
        
        
end
