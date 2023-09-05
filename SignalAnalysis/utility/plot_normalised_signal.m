function plot_normalised_signal(visibility,normalised_signal,n_frames,mean_dist,exposure_time,output_path)
    figure('Visible',visibility);
    hold on
    plot(0:1:(n_frames-1)*1, normalised_signal, 'k');
    title('Normalised calcium signal - cycles')
    xlabel('Time [cycles]');
    ylabel('Signal Intensity');
    image_name = fullfile(output_path,'Normalised Calcium Signal - cycles');
    saveas(gcf,image_name,'tiff');
    
    figure('Visible',visibility);
    hold on
    frame_scale = mean_dist; % plot according to number of actual frames
    plot(0:frame_scale:(n_frames-1)*frame_scale, normalised_signal, 'k');
    title('Normalised calcium signal - frames')
    xlabel('Time [frames]');
    ylabel('Signal Intensity');
    image_name = fullfile(output_path,'Normalised Calcium Signal - frames');
    saveas(gcf,image_name,'tiff');
    
    figure('Visible',visibility);
    hold on
    time_scale = mean_dist*exposure_time/1000; % plot according to real time
    plot(0:time_scale:(n_frames-1)*time_scale, normalised_signal, 'k');
    title('Normalised calcium signal - time')
    xlabel('Time [s]');
    ylabel('Signal Intensity');
    image_name = fullfile(output_path,'Normalised Calcium Signal - seconds');
    saveas(gcf,image_name,'tiff');
end