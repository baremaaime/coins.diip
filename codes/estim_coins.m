function [coins] = estim_coins(measurement, bias, dark, flat)
    % Perform image processing steps
    calibratedImage = illumination(measurement, bias, dark, flat);
    CBRemovedImage = CheckerBoardRemoval(calibratedImage);
    filledBinaryImage = geometryCalibration(CBRemovedImage);
    colorEnhancedImage = colorCalibration(measurement);

    % Extract coin properties
    [centroids, allDiameters] = getDiameter(filledBinaryImage, colorEnhancedImage);
    %[allHue, allSatDiff] = getHueSaturation(colorEnhancedImage, centroids, allDiameters);
    allDiameters = 25.75 * allDiameters / 526;
    
    % Classify coins based on their properties
    labels = classifyCoins(allDiameters); %, allHue, allSatDiff);

    % Initialize an array to store the count of each coin type
    coins = zeros(1, 6);
    
    % Loop through each labeled coin and count them
    for i = 1:numel(labels)
        currentLabel = labels{i};  % Extract the current label
        
        % Check the coin type and increment the corresponding count
        if strcmp(currentLabel, '2e')
            coins(1) = coins(1) + 1;
        elseif strcmp(currentLabel, '1e')
            coins(2) = coins(2) + 1;
        elseif strcmp(currentLabel, '50c')
            coins(3) = coins(3) + 1;
        elseif strcmp(currentLabel, '20c')
            coins(4) = coins(4) + 1;
        elseif strcmp(currentLabel, '10c')
            coins(5) = coins(5) + 1;
        else
            coins(6) = coins(6) + 1;
        end
    end
end
