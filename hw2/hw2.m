clc;
clear;
origin_image = imread("Prog2_images/p2im1.bmp");
double_image = im2double(origin_image);
lab_image = rgb2lab(origin_image);
lab_image = im2double(lab_image);
gray_image = rgb2gray(origin_image);
gray_image = im2double(gray_image);

[h,w] = size(origin_image(:,:,1));
subplot(1,2,1);
imshow(origin_image);


final_im = LoG(origin_image);
final_im = Sobel(origin_image);
final_im = Robert(origin_image);

final_im = Canny(origin_image);

subplot(1,2,2);
imshow(final_im);




