function median_rgb_im = median_rgb(origin_image)

double_image = im2double(origin_image);
final_image(:,:,1) = median(double_image(:,:,1));
final_image(:,:,2) = median(double_image(:,:,2));
final_image(:,:,3) = median(double_image (:,:,3));

median_rgb_im = final_image;

%imwrite(median_rgb_im,'Prog1_images/3_log_median_hsv.bmp');
end

function med_im = median(origin_image)

[h,w] = size(origin_image(:,:,1));
x = 2;
filter_size = 2*x+1;
padding_image = zeros(size(origin_image)+2*x);
median_image = zeros(size(origin_image));

for i = 1:h
    for j = 1:w
        padding_image(i+x,j+x) = origin_image(i,j);
    end
end

for i = 1:h
    for j = 1:w
        tmp = zeros(9,1);
        idx=1;
        for p = 1:filter_size
            for q = 1:filter_size
                tmp(idx) = padding_image(i+p-1, j+q-1);
                idx = idx + 1;
            end
        end
        med = sort(tmp);
        median_image(i,j) = med(floor(filter_size*filter_size/2)+1);
    end
end

med_im = median_image;

end