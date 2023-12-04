classdef input_data
    % INPUT_DATA helps to keep track of input file data and contains
    % methods to help keep track of metadata.
    properties
        folder_path     % path to folder containing dataset
        filename_1      % filename of channel 1
        filename_2      % filename of channel 2
        filename_3      % filename of channel 3
        main_ch         % index of main channel to be used for reference
        phase           % frame index to be used for reference
    end
    methods
        function nc = n_channels(obj)
            % Number of channels inputted
            nc = sum([ ...
                ~isempty(obj.filename_1), ...
                ~isempty(obj.filename_2), ...
                ~isempty(obj.filename_3) ...
                ]);
        end
        function fp = file_paths(obj)
            % Saves the active files paths to a cell
            switch obj.n_channels
                case 1
                    fp = {
                        strcat(obj.folder_path, obj.filename_1)
                        };
                case 2
                    fp = {
                        strcat(obj.folder_path, obj.filename_1), ...
                        strcat(obj.folder_path, obj.filename_2)
                        };
                case 3
                    fp = {
                        strcat(obj.folder_path, obj.filename_1), ...
                        strcat(obj.folder_path, obj.filename_2), ...
                        strcat(obj.folder_path, obj.filename_3)
                        };
            end
        end
        function mp = main_path(obj)
            % Determines main path
            fp = obj.file_paths;
            mp = fp{obj.main_ch};
        end
        function ti = tif_info(obj)
            % Determines tif_info
            ti = imfinfo(obj.main_path);
        end
        function ir = get_img(obj, varargin)
            % Returns the image of the input index, otherwise returns
            % default reference image
            if ~isempty(varargin)
                ir = imread(obj.main_path, varargin{1});
            else
                ir = imread(obj.main_path, obj.phase);
            end
        end
        function nf = n_frames(obj)
            % Returns the number of frames in the dataset
            nf = length(obj.tif_info);
        end
        function h = height(obj)
            % Returns the height of the dataset images
            ti = obj.tif_info;
            h = ti(1).Height;
        end
        function w = width(obj)
            % Returns the width of the dataset images
            ti = obj.tif_info;
            w = ti(1).Width;
        end
        function df = data_format(obj)
            ti = obj.tif_info;
            bits = ti(1).BitsPerSample;
            df = ['uint', num2str(bits)];
        end
    end
end