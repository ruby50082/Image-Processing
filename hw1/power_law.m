function power_im = power_law(origin_image)

double_image = im2double(origin_image);
c = 1;
gamma = 3;
power_im = c*(double_image).^gamma;
%imwrite(power_im,'Prog1_images/2_power.bmp');
end