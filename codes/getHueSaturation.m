function [allHue, allSatDiff] = getHueSaturation(colorEnhancedImage, centroids, allDiameters)
    % Convert the color-enhanced image to the HSV color space
    I_hsv = rgb2hsv(colorEnhancedImage);
    
    % Get the height and width of the image
    h = size(I_hsv, 1);
    w = size(I_hsv, 2);

    % Initialize arrays to store hue and saturation values
    hues = zeros(0, 1);
    sats = zeros(0, 1);
    sats_inner = zeros(0, 1);
    sats_outer = zeros(0, 1);
    
    % Initialize arrays to store calculated hue and saturation difference for each region
    hue = zeros(1, numel(allDiameters));
    sat_diff = zeros(1, numel(allDiameters));
    
    % Loop over each specified region (object)
    for k = 1:numel(allDiameters)
        for y = 1:h
            for x = 1:w
                % Get centroid and radius of the region
                c = centroids(k, :);
                r = allDiameters(k)/2;
                
                % Calculate squared distance from the current pixel to the centroid
                d2 = (x - c(1))^2 + (y - c(2))^2;
                
                % Check if the pixel is within the region
                if d2 <= r^2
                    % Store hue and saturation values
                    hues(end+1) = I_hsv(y, x, 1);
                    sats(end+1) = I_hsv(y, x, 2);
                    
                    % Classify pixels into inner and outer regions based on distance
                    if d2 <= (0.70*r)^2
                        sats_inner(end+1) = I_hsv(y, x, 2);
                    elseif d2 <= (0.90*r)^2
                        sats_outer(end+1) = I_hsv(y, x, 2);
                    end
                end
            end
        end

        % Calculate weighted average hue and saturation difference for each region
        hue(k) = sum((hues .* sats)) / sum(sats); % hue weighted by saturation
        sat_diff(k) = mean(sats_inner) - mean(sats_outer);
    end
    
    % Output the calculated hue and saturation difference for all regions
    allHue = hue;
    allSatDiff = sat_diff;
end