function signal = calculate_signal(start_frame,end_frame,file_path,ROI_boundary)
    signal_tmp = [];
    for frame = start_frame:end_frame
        img = imread(file_path, frame);
        ROI_mean_intensity = regionprops(ROI_boundary, img, 'MeanIntensity');  
        signal_tmp = [signal_tmp, ROI_mean_intensity];
    end
    signal = [signal_tmp.MeanIntensity]';
end