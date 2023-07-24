function ssim_vals = auto_correct(pathname, xbounds, ybounds, ref_idx, sug_idx, n_neighbours)
% AUTO_CORRECT determines offset required for phase matching
%   By considering neighbouring candidates of a potential phase match, we
%   calculate the ssim of each and pick the highest returned value.

% INPUTS:
%   pathname    :   full path to tiff file used for comparison
%   ref_idx     :   index of reference image
%   sug_idx     :   index of centre of potential candidates (i.e. next peak)
%   n_neighbours:   number of neighbours to check

% OUTPUTS:
%   ssim_vals   :   list of similarity indexes for neighbours

%% Initialisation steps
img_ref = imread(pathname, ref_idx);
ssim_vals = zeros(1,2*n_neighbours+1);
%% Compare neighbours
for t = -n_neighbours:n_neighbours
    img_sug= imread(pathname, sug_idx+t);
    imshow(img_ref(ybounds,xbounds)) %diagnostics
    ssim_sug = multissim3(img_sug(ybounds,xbounds), img_ref(ybounds,xbounds));
    ssim_vals(t+n_neighbours+1) = ssim_sug;
end