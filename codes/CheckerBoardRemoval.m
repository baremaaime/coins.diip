function CBRemovedImage = CheckerBoardRemoval(calibratedImage)
    % Convert the calibrated image to double for numerical operations
    inputImage = double(calibratedImage);

    % Define a binary mask for white squares in the image
    whiteMask = inputImage(:,:,1) == 255 & inputImage(:,:,2) == 255 & inputImage(:,:,3) == 255;

    % Calculate the average value of the non-white pixels in the image
    fillinValue = median(inputImage(~whiteMask));

    % Replace white squares with the calculated average value
    inputImage(repmat(whiteMask, [1, 1, 3])) = fillinValue;

    % Convert the result back to uint8 for display
    img = uint8(inputImage);
    img = im2double(img);

    % Convert the image to grayscale
    grayImg = rgb2gray(img);

    % Threshold the image to segment the checkerboard
    binaryMask = grayImg < graythresh(grayImg);

    % Use morphological operations to clean up the binary mask
    se = strel('disk', 1); % Adjust the disk size as needed
    binaryMask = imclose(binaryMask, se);

    % Use the inverse of the binary mask as the foreground mask
    foregroundMask = binaryMask;

    % Extract the foreground (non-checkerboard regions)
    foreground = bsxfun(@times, img, foregroundMask);

    % Apply 3D median filtering to further refine the foreground extraction
    for k = 1:3
        foreground = medfilt3(foreground);
    end

    % Output the image with the checkerboard removed
    CBRemovedImage = foreground;
end
