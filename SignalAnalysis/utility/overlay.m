function ImagesToSave = overlay(EndFrame, tifInfo, N_channels, StartFrame, pathnames, FolderPath)
    if EndFrame == 0
        EndFrame = length(tifInfo);
    end
    
    ImagesToSave = cell(1,N_channels);
    for ch = 1:N_channels
        ImagesToSave{ch} = zeros(tifInfo(1).Height, tifInfo(1).Width);
        for frame = StartFrame:EndFrame
            img = imread(pathnames{ch}, frame);
            ImagesToSave{ch} = ImagesToSave{ch} + double(img);
        end
        ImagesToSave{ch} = uint8(ImagesToSave{ch}/N);
        % Save Overlay
        ImageFile = ['Channel', num2str(ch), '_overlay.tif'];
        imwrite(ImagesToSave{ch}, [FolderPath,filesep,ImageFile], 'tif')
    end
end