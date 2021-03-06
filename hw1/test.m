%% Initialize
clear all;
close all;
clc; clf;
step = 0;
%% Constants
% Gaussian Filter
FILTER_SIZE = 5;
SIGMA = 14;
% Hysteresis
LOW_THRESHOLD_FACTOR = 0.1;
HIGH_THRESHOLD_FACTOR = 0.3;
%% Read Input Image
% Step 1
% im = imread('Lena.jpg');
im = imread("Prog1_images/p1im6.bmp");
im = im2double(im);
step = step + 1;
figure(step);
imshow(im, []);
title('Input Image');
%% Part (a)
% Convolve a given image with a Gaussian of scale 'sigma'
% Step 2
% Gaussian Filter with standard deviation SIGMA (1.4)
gaussian_filter = fspecial('gaussian', FILTER_SIZE, SIGMA);
% gaussian_filter = [2 4 5 4 2; 4 9 12 9 4; 5 12 15 12 5; 4 9 12 9 4; 2 4 5 4 2]/159;
% Convoluting image with chosen filter
conv_im = conv2(im(:,:,2), gaussian_filter, 'same');
step = step + 1;
figure (step);
imshow(conv_im, []);
title(['Gaussian Filter with \sigma = ', num2str(SIGMA)]);
%% Part (b)
% Estimate local edge normal directions n using the equation (5.58)
% in the textbook for each pixel in the image
% Step 3 to 5
[gaussian_filter_x gaussian_filter_y] = gradient(gaussian_filter);
im_gradient_x = conv2(conv_im, gaussian_filter_x, 'same');
im_gradient_y = conv2(conv_im, gaussian_filter_y, 'same');
n_direction = atan2(im_gradient_y, im_gradient_x);
n_direction = n_direction*180/pi;
% Discretization of directions
n_direction_dis = zeros(512, 512);
for i = 1  : 240
    for j = 1 : 320
        if ((n_direction(i, j) > 0 ) && (n_direction(i, j) < 22.5) || (n_direction(i, j) > 157.5) && (n_direction(i, j) < -157.5))
            n_direction_dis(i, j) = 0;
        end
        
        if ((n_direction(i, j) > 22.5) && (n_direction(i, j) < 67.5) || (n_direction(i, j) < -112.5) && (n_direction(i, j) > -157.5))
            n_direction_dis(i, j) = 45;
        end
        
        if ((n_direction(i, j) > 67.5 && n_direction(i, j) < 112.5) || (n_direction(i, j) < -67.5 && n_direction(i, j) > 112.5))
            n_direction_dis(i, j) = 90;
        end
        
        if ((n_direction(i, j) > 112.5 && n_direction(i, j) <= 157.5) || (n_direction(i, j) < -22.5 && n_direction(i, j) > -67.5))
            n_direction_dis(i, j) = 135;
        end
    end
end
step = step + 1;
figure(step);
imshow(im_gradient_x);
title('X Gradient');
step = step + 1;
figure(step);
imshow(im_gradient_y);
title('Y Gradient');
step = step + 1;
figure(step);
imagesc(n_direction_dis); colorbar;
title('Normal Directions');
%% Part (d)
% Compute the magnitude of the edge using equation (5.61)
% Step 6
im_gradient_mag = sqrt(im_gradient_x.^2 + im_gradient_y.^2);
step = step + 1;
figure(step);
imshow(im_gradient_mag, []);
title('Gradient Magnitude');
%% Part (c)
% Location of the edges using equation (5.60) with non-maximal suppression
% Step 7
supressed_im = zeros(512, 512);
for i = 2  : 479
    for j = 2 : 479
        
        if (n_direction_dis(i, j) == 0)
        	if (im_gradient_mag(i, j) > im_gradient_mag(i, j - 1) && im_gradient_mag(i, j) > im_gradient_mag(i, j + 1))
                supressed_im(i, j) = im_gradient_mag(i, j);
            else
                supressed_im(i, j) = 0;
            end
        end
        if (n_direction_dis(i, j) == 45)
            if (im_gradient_mag(i, j) > im_gradient_mag(i + 1, j - 1) && im_gradient_mag(i, j) > im_gradient_mag(i - 1, j + 1))
                supressed_im(i, j) = im_gradient_mag(i, j);
            else
                supressed_im(i, j) = 0;
            end
        end
        if (n_direction_dis(i, j) == 90)
            if (im_gradient_mag(i, j) > im_gradient_mag(i - 1, j) && im_gradient_mag(i, j) > im_gradient_mag(i + 1, j))
                supressed_im(i, j) = im_gradient_mag(i, j);
            else
                supressed_im(i, j) = 0;
            end
        end
        if (n_direction_dis(i, j) == 135)
            if (im_gradient_mag(i, j) > im_gradient_mag(i - 1, j - 1) && im_gradient_mag(i, j) > im_gradient_mag(i + 1, j + 1))
                supressed_im(i, j) = im_gradient_mag(i, j);
            else
                supressed_im(i, j) = 0;
            end
        end
    end
end
step = step + 1;
figure(step);
imshow(supressed_im);
title('Supressed Image');
%% Part (e)
% Design the thresholding for edges with the hysteresis (Algorithm 6.5) to 
% eliminate spurious responses
% High and Low Thresholds defined above for Hysteresis
% 4- connectivity used
% Step 8
ThreshL = LOW_THRESHOLD_FACTOR * max(max(supressed_im));
ThreshH = HIGH_THRESHOLD_FACTOR * max(max(supressed_im));
thresh_im = zeros(512, 512);
for i = 1  : 512
    for j = 1 : 512
        if (supressed_im(i, j) < ThreshL)
            thresh_im(i, j) = 0;
        elseif (supressed_im(i, j) > ThreshH)
            thresh_im(i, j) = 1;
        else
            if (                                       ...
                 (supressed_im(i + 1, j) > ThreshH) || ...
                 (supressed_im(i - 1, j) > ThreshH) || ...
                 (supressed_im(i, j + 1) > ThreshH) || ...
                 (supressed_im(i, j - 1) > ThreshH)    ...
               )
                thresh_im(i, j) = 1;
            end
        end
    end
end
step = step + 1;
figure(step);
imshow(thresh_im);
title('Hysteresis Thresholding');