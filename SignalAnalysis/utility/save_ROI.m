function save_ROI(original_image,ROI_boundary,output_path)
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