function create_graph_movie(visibility,normalised_signal,n_frames,mean_dist,exposure_time,output_path)
    graph_movie_path = [output_path,'\GraphMovie'];
    mkdir(graph_movie_path);
    for i = 1:n_frames
        figure('Visible',visibility)
        time_scale = mean_dist*exposure_time/1000; % plot according to real time
        plot(0:time_scale:(i-1)*time_scale, normalised_signal(1:i), 'k');
        title('Normalised Calcium Signal')
        xlabel('Time [s]');
        ylabel('Signal Intensity');
        axis([0,n_frames*time_scale,0,max(normalised_signal)]);
        iName = string(i);
        imageName = fullfile(graph_movie_path,iName);
        saveas(gcf,imageName,'tiff');
    end
end