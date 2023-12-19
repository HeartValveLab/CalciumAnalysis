function save_multitiff(input_data, cut_length, images_to_save, n_pks, output_path)
% SAVE_SINGLE_PHASE saves a tif containing phase matched frames for target
% phase
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-09-12
% ------INPUTS------
% n_pks (double):       Number of peaks found
% n_channels (double):  Number of input channels used
% cut_length (double):  Number of frames to keep on either side of peak
% images_to_save (cell):Data object to save phase matched images
% output_path (str):    Full path to output folder
% -----OUTPUTS-----
    for matched_phase = 1:2*cut_length+1
        for cycle = 1:n_pks
            for channel = 1:input_data.n_channels
                ImageFile=['MultiTiff_t' padnumber(3,num2str(cycle)) '_z' padnumber(3,num2str(matched_phase)) '_c00' num2str(channel) '.tif'];
                imwrite(images_to_save{channel,cycle,matched_phase}, [output_path,filesep,ImageFile],'tif')
            end
        end
    end
end