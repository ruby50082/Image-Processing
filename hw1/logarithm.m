function log_im = logarithm(origin_image)

double_image = im2double(origin_image);
c = 1.8;
log_im = c*log(1+double_image);
%imwrite(log_im,'Prog1_images/5_log.bmp');
end