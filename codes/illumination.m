function calibratedImage = illumination(rawImage, biasImages, darkImages, flatFieldImages)
    % Extract individual bias images
    bias1 = biasImages(:,:,:,1);
    bias2 = biasImages(:,:,:,2);
    bias3 = biasImages(:,:,:,3);
    bias4 = biasImages(:,:,:,4);
    bias5 = biasImages(:,:,:,5);
    
    % Calculate the mean bias image
    mean_B = (bias1 + bias2 + bias3 + bias4 + bias5) ./ 5;

    % Extract individual dark images
    dark1 = darkImages(:,:,:,1);
    dark2 = darkImages(:,:,:,2);
    dark3 = darkImages(:,:,:,3);
    dark4 = darkImages(:,:,:,4);
    dark5 = darkImages(:,:,:,5);
    
    % Calculate the mean dark image, subtracting the mean bias
    mean_D = ((dark1 - mean_B) + (dark2 - mean_B) + (dark3 - mean_B) + (dark4 - mean_B) + (dark5 - mean_B)) ./ 5;

    % Extract individual flat field images
    flatfield1 = flatFieldImages(:,:,:,1);
    flatfield2 = flatFieldImages(:,:,:,2);
    flatfield3 = flatFieldImages(:,:,:,3);
    flatfield4 = flatFieldImages(:,:,:,4);
    flatfield5 = flatFieldImages(:,:,:,5);
    
    % Calculate the normalized flat field correction
    norm_F = ((flatfield1 - mean_B - mean_D) + (flatfield2 - mean_B - mean_D) + ...
              (flatfield3 - mean_B - mean_D) + (flatfield4 - mean_B - mean_D) + (flatfield5 - mean_B - mean_D));
    norm_F = uint8(double(norm_F) ./ double(max(norm_F(:))));

    % Perform image calibration using bias, dark, and flat field corrections
    calibratedImage = (rawImage - uint8(mean_B) - uint8(mean_D)) ./ norm_F;
end
