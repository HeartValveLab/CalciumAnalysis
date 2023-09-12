function save_single_phase(tif_info, n_pks, n_channels, cut_length, images_to_save, output_path, phase)
% SAVE_SINGLE_PHASE saves a tif containing phase matched frames for target
% phase
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
    im = zeros(tif_info(1).Height,tif_info(1).Width, n_pks-1,n_channels,1,'uint8'); %change to uint16 if using 16 bit images
    centre = cut_length + 1; 
    for channel = 1:n_channels
        for matched_phase = 1:n_pks-1
            im(:,:,matched_phase,channel,1) = images_to_save{channel,matched_phase,centre};
        end
    end
    ImageFile=['SinglePhase_z' padnumber(3,num2str(phase)) '.ome'];
    bfsave(im, [output_path,filesep,ImageFile])
end