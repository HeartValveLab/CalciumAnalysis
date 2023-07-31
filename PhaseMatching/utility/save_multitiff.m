function save_multitiff(N_pks, N_channels, cutLength, ImagesToSave, outputFileName, folder_w)
for k3 = 1:2*cutLength+1
    for k2 = 1:N_pks-1
        for ch = 1:N_channels
            ImageFile=[outputFileName '_t' padnumber(3,num2str(k2)) '_z' padnumber(3,num2str(k3)) '_c00' num2str(ch) '.tif'];
            imwrite(ImagesToSave{ch,k2,k3}, [folder_w,filesep,ImageFile],'tif')
        end
    end
end
end