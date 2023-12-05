function save_all_phase(input_data, cut_length, images_to_save, n_pks, output_path)
% SAVE_ALL_PHASE saves a tif containing phase matched frames for target
% phase and neighbouring
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-09-12
% ------INPUTS------
% tif_info (struct):    Metadata pertaining to input dataset
% n_pks (double):       Number of peaks found
% n_channels (double):  Number of input channels used
% cut_length (double):  Number of frames to keep on either side of peak
% images_to_save (cell):Data object to save phase matched images
% output_path (str):    Full path to output folder
% phase (double):       Frame to use as reference
% -----OUTPUTS-----
    cycle_length = 2*cut_length+1;
    im = zeros(input_data.height,input_data.width, n_pks, input_data.n_channels,cycle_length,input_data.data_format); %change to uint16 if using 16 bit images   
    for ch = 1:input_data.n_channels
        for cycle = 1:n_pks-1
            for matched_phase = 1:cycle_length
                im(:,:,cycle,ch,matched_phase) = images_to_save{ch,cycle,matched_phase};
            end
        end
    end
    ImageFile = ['AllPhase.ome'];
    bfsave(im, [output_path,filesep,ImageFile])
end