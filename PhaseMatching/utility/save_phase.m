function save_phase(tifInfo, N_pks, N_channels, cutLength, ImagesToSave, outputFileName, folder_w, phase)
    im=zeros(tifInfo(1).Height,tifInfo(1).Width, ...
        N_pks,N_channels,1,'uint8'); %change to uint16 if using 16 bit images
    for k2 = 1:N_pks-1
        k3 = cutLength+1;
        for ch = 1:N_channels
            im(:,:,k2,ch,1) = ImagesToSave{ch,k2,k3};
        end
    end
ImageFile=[outputFileName '_z' padnumber(3,num2str(phase)) '.ome'];
bfsave(im, [folder_w,filesep,ImageFile])
end