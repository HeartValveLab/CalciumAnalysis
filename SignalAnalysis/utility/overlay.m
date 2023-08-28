function OverlayedImage = overlay(FilePath, TifInfo, StartFrame, EndFrame, N_frames)    
    OverlayedImage = zeros(TifInfo(1).Height, TifInfo(1).Width);
    for frame = StartFrame:EndFrame
        img = imread(FilePath, frame);
        OverlayedImage = OverlayedImage + double(img);
    end
    OverlayedImage = uint8(OverlayedImage/(N_frames));
end