clc;
clear;
origin_image = imread("Prog1_images/p1im1.bmp");
double_image = im2double(origin_image);

[h,w] = size(origin_image(:,:,1));
subplot(1,2,1);
imshow(origin_image);

%intensity
final_im = histogram(origin_image);
final_im = histogram_intensity(origin_image);
final_im = logarithm(origin_image);
final_im = power_law(origin_image);

%color
final = ccm(origin_image);
final_im = AWB(origin_image, 90);

%noise
final_im = sharpen(origin_image);
final_im = smooth(origin_image);
final_im = bilateral(origin_image,5,[3 0.1]);
final_im = median_rgb(origin_image);

subplot(1,2,2);
imshow(final_im);


