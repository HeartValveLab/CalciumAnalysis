function save_ROI(original_image,ROI_boundary,output_path)
% SAVE_ROI saves an image of the ROI drawn on the overlayed image
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-09-12
% ------INPUTS------
% original_image (arr): Overlayed image with both channels
% ROI_boundary (arr):   Logical array containing ROI drawn
% output_path (str):    Path to save image in
% -----OUTPUTS-----
    figure('visible','off');
    imshow(original_image);
    hold on;
    boundaries = bwboundaries(ROI_boundary);
    numberOfBoundaries = size(boundaries, 1);
    for k = 1 : numberOfBoundaries
        thisBoundary = boundaries{k};
        plot(thisBoundary(:,2), thisBoundary(:,1), 'y', 'LineWidth', 1);
    end
    hold off;
    imageName = fullfile(output_path, 'ROI');
    saveas(gcf, imageName, 'tiff');
end