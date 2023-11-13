classdef input_params
    % INPUT_PARAMS helps to keep track of the input variables and contains
    % methods to help keep track of metadata
    properties
        n_scales                % NumScales to be used in multissim
        min_peak_height         % MinPeakHeight to be used in findpeaks
        min_peak_prominence     % MinPeakProminence to be used in findpeaks
        ROI                     % Region of interest to hone in on
        padding                 % Additional frames to pad to the cycles
        n_neighbours            % Number of neighbouring frames to use
    end

    methods
        function cl = cut_length(obj, mean_dist)
            % Number of frames to use in a cycle
            cl = round(mean_dist/2 + obj.padding);
        end
        function xb = x_bounds(obj)
            % X boundaries of ROI
            xb = ceil(obj.ROI(1)) : floor(obj.ROI(1)+obj.ROI(3));
        end
        function yb = y_bounds(obj)
            % Y boundaries of ROI
            yb = ceil(obj.ROI(2)) : floor(obj.ROI(2)+obj.ROI(4));
        end
    end
end