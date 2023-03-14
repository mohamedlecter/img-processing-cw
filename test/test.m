% Read the input RGB image
rgbImage = imread('./imgs/StackNinja3.bmp');

% Extract the green channel
greenChannel = rgbImage(:, :, 2);

% Apply median filtering to remove noise
filteredGreen = medfilt2(greenChannel, [3 3]);

% Enhance contrast using gamma correction
gamma_value = 0.7;
enhancedGreen = imadjust(filteredGreen, [], [], gamma_value);

% Convert the enhanced green image to binary using adaptive thresholding
binaryImage = imbinarize(enhancedGreen, 'adaptive', 'Sensitivity', 0.5);

% Fill in any holes in the binary image
filledImage = imfill(binaryImage, 'holes');

% Remove small objects using morphological opening
se = strel('disk', 5);
openedImage = imopen(filledImage, se);

% Identify and label the nuclei using connected component analysis
[labelImage, numNuclei] = bwlabel(openedImage);

% Display the results
figure;
subplot(2, 2, 1), imshow(rgbImage), title('Original Image');
subplot(2, 2, 2), imshow(greenChannel), title('Green Channel');
subplot(2, 2, 3), imshow(enhancedGreen), title(['Enhanced Green (gamma=', num2str(gamma_value), ')']);
subplot(2, 2, 4), imshow(label2rgb(labelImage)), title(['Detected Nuclei (', num2str(numNuclei), ')']);