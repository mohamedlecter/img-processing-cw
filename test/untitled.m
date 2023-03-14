
%config;

%for imageIndex = 1:size(PictureName,2)
%filePath = sprintf("%s%s",baseFilePath,PictureName(imageIndex));
%sourceImage = imread(filePath);
    
%B = sourceImage(:,:,3);

sourceImage = imread('./imgs/StackNinja1.bmp');
%% Extract the green channel
greenChannel = sourceImage(:,:,2);


%% Convert the RGB image to the HSV color space
hsvImage = rgb2hsv(sourceImage);

%% Extract the hue channel
hueChannel = hsvImage(:, :, 1).* 3;

%% Applying Median Filter for Noise Reduction
im_median = medfilt2(im_h, [4 4]);

%% Processing of im_median
    % Remove pixels that may be of red pixels
    % As red pixels tend to be very small within the scale from 0 to 1 in
    % the Hue Channel of Matlab representation
    [w h] = size(im_median);
    for i = 1 : w
        for j = 1 : h
            if(im_median(i, j) < 0.1)
                im_median(i, j) = 0;
            end
        end
    end

    %% Converting im_median into black and white
    % adaptthresh is a local adaptive thresholding that computes the
    % threshold based on the local mean intensity of the neighborhood of
    % each pixels
    adapt_thresh = adaptthresh(im_median, 0.4, "ForegroundPolarity", "bright");
    im_bw = imbinarize(im_median, adapt_thresh);
    figure('Name', 'Display of Binarized Image with Adaptive Threshold'),
    imshow(im_bw);
    title("Image after Applying Imbinarize with Threshold from Adaptthresh");

%% Applying Gaussian filter for Noise Reduction

%# Create the gaussian filter with hsize = [5 5] and sigma = 2
G = fspecial('gaussian',[5 5],2);
%# Filter it
Ig = imfilter(sourceImage,G,'same');


%%  Applying Average Filtering for Noise Reduction

% Define the filter size
filterSize = [4 4];

% Create the averaging filter
filterKernel = ones(filterSize) / prod(filterSize);

% Apply the averaging filter to the hue channel
filteredHueChannel = imfilter(hueChannel, filterKernel);

% Replace the original hue channel with the filtered hue channel
hsvImage(:, :, 1) = filteredHueChannel;

% Convert the image back to the RGB color space
avgFiltering = hsv2rgb(hsvImage);


%% this promptes all the images, both the orignal image and the modified image
    
    figure('Name', 'Colour Space Conversion comparisons'),

    subplot(2,2,1);
    imshow(greenChannel);
    title("Extraction of Green Channel");

    subplot(2,2,2);
    imshow(hueChannel);
    title("Extraction of Hue channel from HSV Colour space");


    figure('Name', 'Filtering comparisons');
    subplot(2,2,1);
    imshow(im_median);
    title("Median Filtering");
    
    subplot(2,2,2);
    imshow(Ig);
    title("Gaussian filter");
    
     subplot(2,2,3);
    imshow(filteredHueChannel);
    title("Avg filter");

%end