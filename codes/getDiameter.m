function [centroids, allDiameters] = getDiameter(filledBinaryImage, colorEnhancedImage)
    % Convert the filled binary image to a logical labeled image
    labeledImage = logical(filledBinaryImage);

    % Convert the color-enhanced image to HSV color space
    hsvImage = rgb2hsv(colorEnhancedImage);

    % Extract region properties (centroids and equivalent diameters) from labeled image
    stats = regionprops(labeledImage, hsvImage(:, :, 1), 'EquivDiameter', 'Centroid');
    
    % Extract centroid coordinates from the region properties
    cc = [stats.Centroid];
    centroids = [cc(1:2:end)', cc(2:2:end)'];

    % Extract equivalent diameters from the region properties
    allDiameters = [stats.EquivDiameter];

    % Threshold for selecting objects based on diameter
    threshold = 0.59;
    
    % Select objects with diameters greater than a certain percentage of the maximum diameter
    selectedObjects = find(allDiameters > threshold * max(allDiameters));

    % Update the output with selected centroids and diameters
    allDiameters = allDiameters(selectedObjects);
    centroids = centroids(selectedObjects, :);
end
