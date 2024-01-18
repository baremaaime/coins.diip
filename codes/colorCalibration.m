function colorEnhancedImage = colorCalibration(rawImage)
    % Decorrelate the color channels of the raw image
    decorrelatedImage = decorrstretch(rawImage);

    % Adjust the intensity values of the decorrelated image for enhanced color
    colorEnhancedImage = imadjust(decorrelatedImage, [0.2 0.8], [], 1.5);
end
