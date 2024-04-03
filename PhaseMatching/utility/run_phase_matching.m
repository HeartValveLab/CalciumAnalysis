function run_phase_matching(input_data, input_params, visibility, output_folder, output_type, matching_mode);
% RUN_PHASE_MATCHING is a header function to run all phase matching code
% cleanly
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-12-20
% ------INPUTS------
% input_data (class):       Class structure containing input dataset
% input_params (class):     Class structure containing input variables
% visibility (str):         Display figures or not
% output_folder (str):      Output folder name
% output_type (str):        Type of output to save
% matching_mode (str):      Type of ssim to calculate
% -----OUTPUTS-----
    %% Initiation
    disp('Processing user inputs');
    ImgRef = input_data.get_img;
    f1 = figure(1);
    f1.Visible = visibility;
    imshow(ImgRef);
    title('This is our reference image for phase matching')
    disp('User inputs processed')
    
    
    %% Calculate similarity scores
    disp('Determining similarity scores.');
    
    switch matching_mode
        case 'spatial'
            SsimScores = spatial_phase_matching(input_data, input_params);
        case 'temporal'
            SsimScores = temporal_phase_matching(input_data, input_params);
    end
    
    f2 = figure(2);
    f2.Visible = visibility;
    plot(SsimScores);
    title('Similarity scores for each frame')
    
    disp('Similarity scores calculated. Determine peak locations.')
    
    
    %% Finding peaks
    disp('Determining location of peaks.');
    [Pks, PkLocs, N_pks, MeanDist] = find_peaks(SsimScores, input_params.min_peak_height, input_params.min_peak_prominence, 0, input_data.phase);
    f2 = figure(2);
    f2.Visible = visibility;
    plot(SsimScores); hold on;
    plot(PkLocs, Pks, "*");
    legend('Similarity scores','Peaks');
    xlabel('Frame');
    ylabel('Similarity score');
    title('Similarity scores for each frame')
    disp('Peaks located.');
    
    
    %% Update peaks
    try
        cursor_info = evalin('base', 'cursor_info');
        [Pks, PkLocs, N_pks, MeanDist] = update_peaks(cursor_info, Pks, PkLocs);
    catch
        
    end
    f2 = figure(2);
    f2.Visible = visibility;
    plot(SsimScores); hold on;
    plot(PkLocs, Pks, "*");
    title('Similarity scores for each frame')
    
    
    %% Create movie
    CutLength = input_params.cut_length(MeanDist);
    ImagesToSave = cell(input_data.n_channels, N_pks, 2*CutLength+1);
    ImagesToSave = construct_movie(input_data.file_paths, ImagesToSave, PkLocs, CutLength);
    
    
    %% Output
    disp('Saving files');
    OutputPath = [input_data.folder_path, output_folder];
    mkdir(OutputPath);
    javaaddpath('loci_tools.jar')
    
    if output_type(1) == '1'
        save_multitiff(input_data, CutLength, ImagesToSave, N_pks, OutputPath);
    end
    if output_type(2) == '1'
        ImageFile=['SinglePhase_z' padnumber(3,num2str(input_data.phase)) '.ome'];
        if isfile([OutputPath,filesep,ImageFile])
            disp('File already exists. Overwrite prevented. Consider renaming original file.')
        else
            save_single_phase(input_data, CutLength, ImagesToSave, N_pks, OutputPath);
        end
    end
    if output_type(3) == '1'
        ImageFile = ['AllPhase.ome'];
        if isfile([OutputPath,filesep,ImageFile])
            disp('File already exists. Overwrite prevented. Consider renaming original file')
        else
            save_all_phase(input_data, CutLength, ImagesToSave, N_pks, OutputPath);
        end
    end
    disp('Files saved');
end