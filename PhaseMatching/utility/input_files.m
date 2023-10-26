classdef input_files
    properties
        filepath_1
        filepath_2
        filepath_3
        main_ch
        
    end
    methods
        function n_channels = get_channels(obj)
            % Determines number of channels inputted
            n_channels = sum([ ...
                ~isempty(obj.filepath_1), ...
                ~isempty(obj.filepath_2), ...
                ~isempty(obj.filepath_3) ...
                ]);
        end
        function main_path = get_main_path(obj)
            % Determines main path
            main_path = obj.filepath_;
        end
        function tif_info = get_tif_info(obj)
            % Determines tif_info
            tif_info = imfinfo(obj.main_ch);
        end
    end
end