function save_all(tifInfo, N_pks, N_channels, cutLength, ImagesToSave, outputFileName, folder_w)
im=zeros(tifInfo(1).Height,tifInfo(1).Width, ...
    N_pks,N_channels,2*cutLength+1,'uint8'); %change to uint16 if using 16 bit images   
for k2 = 1:N_pks-1
    for k3 = 1:2*cutLength+1
        for ch = 1:N_channels
            im(:,:,k2,ch,k3) = ImagesToSave{ch,k2,k3};
        end
    end
end
ImageFile = [outputFileName '_singleFile.ome'];
bfsave(im, [folder_w, filesep, ImageFile])
end