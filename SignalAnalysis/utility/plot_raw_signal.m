function plot_raw_signal(visibility,ca_signal,ref_signal,n_frames,mean_dist,exposure_time,output_path)
% PLOT_RAW_SIGNAL plots the raw reference and calcium signals with varying
% x-axis and saves them
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2024-01-23
% ------INPUTS------
% visibility (str):         Indicates whether figures should be displayed
% ca_signal (arr):          Calcium signal
% ref_signal (str):         Reference signal
% n_frames (double):        Number of frames to be used for analysis
% mean_dist (double):       Average number of frames between cycles
% exposure_time (double):   Duration in ms that a frame is exposed for
% output_path (str):        Folder to save images in
% -----OUTPUTS-----
figure('Visible',visibility);
    hold on
    plot(0:1:(n_frames-1)*1, ca_signal, 'g');
    plot(0:1:(n_frames-1)*1, ref_signal, 'm');
    title('Raw signal - cycles')
    xlabel('Time [cycles]');
    ylabel('Signal Intensity');
    legend('CaSignal','RefSignal')
    image_name = fullfile(output_path,'Raw Calcium and Reference Signal - cycles');
    saveas(gcf,image_name,'tiff');
    
    figure('Visible',visibility);
    hold on
    frame_scale = mean_dist; % plot according to number of actual frames
    plot(0:frame_scale:(n_frames-1)*frame_scale, ca_signal, 'g');
    plot(0:frame_scale:(n_frames-1)*frame_scale, ref_signal, 'm');
    title('Raw signal - frames')
    xlabel('Time [frames]');
    ylabel('Signal Intensity');
    legend('CaSignal','RefSignal')
    image_name = fullfile(output_path,'Raw Calcium and Reference Signal - frames');
    saveas(gcf,image_name,'tiff');
    
    figure('Visible',visibility);
    hold on
    time_scale = mean_dist*exposure_time/1000; % plot according to real time
    plot(0:time_scale:(n_frames-1)*time_scale, ca_signal, 'g');
    plot(0:time_scale:(n_frames-1)*time_scale, ref_signal, 'm');
    title('Raw signal - time')
    xlabel('Time [s]');
    ylabel('Signal Intensity');
    legend('CaSignal','RefSignal')
    image_name = fullfile(output_path,'Raw Calcium and Reference Signal - seconds');
    saveas(gcf,image_name,'tiff');
end