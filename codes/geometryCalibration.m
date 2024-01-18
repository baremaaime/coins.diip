function filledBinaryImage = geometryCalibration(CBRemovedImage)
    % Rescale the input RGB image to grayscale in the range [0, 1]
    rescaledGrayImage = rescale(double(rgb2gray(CBRemovedImage)), 0, 1);

    % Initialize an empty matrix for the blurred image
    blurredImage = zeros(size(rescaledGrayImage));

    % Apply median filtering with varying window sizes to the rescaled grayscale image
    for m = 1:2:21
        blurImage = medfilt2(rescaledGrayImage, [m m]);
        blurredImage = blurredImage + blurImage;
    end

    % Rescale the blurred image back to the range [0, 255]
    re_rescaledImage = rescale(blurredImage, 0, 255);

    % Fill holes in the rescaled and blurred image to obtain the final result
    filledBinaryImage = imfill(re_rescaledImage, 'holes');
end
