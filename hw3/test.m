clc;
clear;

im=imread('./img/transform/dct/lena_dct_klargest_16x16_36.png');
im2=imcrop(im,[300 300 30 30]);
imshow(im2);
imwrite(im2,'./img/transform/compare/lena_dct_klargest_16x16_36_300_300_30_30.jpg');