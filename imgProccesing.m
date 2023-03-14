%% Read images
img1 = imread("./imgs/StackNinja1.bmp");
img2 = imread("./imgs/StackNinja2.bmp");
img3 = imread("./imgs/StackNinja3.bmp");

%% ploting the original images 
figure();
subplot(5,3,1), imshow(img1), title('Figure 1: StackNinja1.bmp');

subplot(5,3,2), imshow(img2), title('Figure 2: StackNinja2.bmp');

subplot(5,3,3), imshow(img3), title('Figure 3: StackNinja3.bmp');

%% Colour space conversion
greyImg1 = img1 (:,:,2) * 2; 
greyImg2 = img2 (:,:,2) * 2; 
greyImg3 = img3 (:,:,2) * 2; 

subplot(5,3,4), imshow(greyImg1), title('Figure 1a: gray image Colour space conversion');
subplot(5,3,5), imshow(greyImg2), title('Figure 2a: gray image Colour space conversion');
subplot(5,3,6), imshow(greyImg3), title('Figure 1a: gray image Colour space conversion');

im1_hsv = rgb2hsv(img1);
im2_hsv = rgb2hsv(img2);
im3_hsv = rgb2hsv(img3);

% Extraction of Hue Channel
% Enhancing the white intensity of the image
hsvImage1 = im1_hsv(:, :, 1) .* 3;
hsvImage2 = im2_hsv(:, :, 1) .* 3;
hsvImage3 = im3_hsv(:, :, 1) .* 3;

%{

subplot(5,3,7), imshow(hsvImage1), title('Figure 1a: HSV Colour space conversion ');
subplot(5,3,8), imshow(hsvImage2), title('Figure 2a: HSV Colour space conversion');
subplot(5,3,9), imshow(hsvImage3), title('Figure 2a: HSV Colour space conversion');
%}

%% Noise Reduction 
medianFilter1 = medfilt2(hsvImage1);
medianFilter2 = medfilt2(hsvImage2);
medianFilter3 = medfilt2(hsvImage3);

subplot(5,3,7), imshow(medianFilter1), title('Figure1b: Noise removal with Median Filter');
subplot(5,3,8), imshow(medianFilter2), title('Figure2b: Noise removal with Median Filter');
subplot(5,3,9), imshow(medianFilter3), title('Figure3b: Noise removal with Median Filter');

%% Test: Gaussian filtering 

gauss1 = fspecial('gaussian',[3 3],0.5);
gauss2 = fspecial('gaussian',[5 5],1.0);
gauss3 = fspecial('gaussian',[7 7],1.5);
gauss4 = fspecial('gaussian',[12 12],3.0);

fixedGuassOne = imfilter(hsvImage1,gauss4);
fixedGuassTwo = imfilter(hsvImage2,gauss4);
fixedGuassThree = imfilter(hsvImage3,gauss4);
%{
subplot(5,3,10), imshow(fixedGuassOne), title('Noise removal with Gaussian Smoothing');
subplot(5,3,11), imshow(fixedGuassTwo), title('Noise removal with Gaussian Smoothing');
subplot(5,3,12), imshow(fixedGuassThree), title('Noise removal with Gaussian Smoothing');
%}

%% Thresholding 

% adapative thresholding 

otsuThreshOne = graythresh(medianFilter1);
otsuThreshTwo = graythresh(medianFilter2);
otsuThreshThree = graythresh(medianFilter3); 


otsuThreshOneLocal = adaptthresh(medianFilter1,0.1);
otsuThreshTwoLocal = adaptthresh(medianFilter2,0.1);
otsuThreshThreeLocal = adaptthresh(medianFilter3,0); 

%% Binary Image
% extracting binary image using adaptive thresholding 

%global thresholding
binaryOne = imbinarize(medianFilter1, otsuThreshOne); 
binaryTwo = imbinarize(medianFilter2, otsuThreshTwo); 
binaryThree = imbinarize(medianFilter3, otsuThreshThree);

%local thresholding
binaryOneLocal = imbinarize(medianFilter1, otsuThreshOneLocal); 
binaryTwoLocal = imbinarize(medianFilter2, otsuThreshTwoLocal); 
binaryThreeLocal = imbinarize(medianFilter3, otsuThreshThreeLocal);


subplot(5, 3, 10), imshow(binaryOne), title('Figure 1c: Gloabl Binary Image');

subplot(5, 3, 11), imshow(binaryTwo), title('Figure 2c: Global Binary Image');

subplot(5, 3, 12), imshow(binaryThree), title('Figure 3c: Gloabl Binary Image');

subplot(5, 3, 13), imshow(binaryOneLocal), title('Figure 1d: Local Binary Image');

subplot(5, 3, 14), imshow(binaryTwoLocal), title('Figure 2d: Local Binary Image');

subplot(5, 3, 15), imshow(binaryThreeLocal), title('Figure 3d: Local Binary Image');

