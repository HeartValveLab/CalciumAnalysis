function [ssim_score_lst, N] = pre_phase_matching(tifInfo, pathnameChMain, img_ref, NumScales)
    N = length(tifInfo);
    ssim_score_lst = zeros(N,1);
    
    for i_Frame = 1:N
        img_sug = imread(pathnameChMain, i_Frame);
        ssim_score = multissim3(img_sug, img_ref, NumScales = NumScales);
        ssim_score_lst(i_Frame) = ssim_score;
    end
end