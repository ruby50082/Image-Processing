function hist_im = histogram(origin_image)

subplot(1,2,1);
imshow(origin_image);
%[count, grayLevels] = imhist(grayImage(:,:,1));

[h,w] = size(origin_image(:,:,1));
count_r=zeros(1,256);
count_g=zeros(1,256);
count_b=zeros(1,256);
for i = 1:h
    for j = 1:w
        count_r(origin_image(i,j,1)+1) = count_r(origin_image(i,j,1)+1) + 1; % count為每一級灰度像素個數
        count_g(origin_image(i,j,2)+1) = count_g(origin_image(i,j,2)+1) + 1;
        count_b(origin_image(i,j,3)+1) = count_b(origin_image(i,j,3)+1) + 1;
    end
end
for i = 0:255
    grayLevels(i+1)=i;
end

%stem(grayLevels,count_r);

cdf_r = cumsum(count_r); %陣列累加值
cdf_r = cdf_r / numel(origin_image(:,:,1));
cdf_g = cumsum(count_g); %陣列累加值
cdf_g = cdf_g / numel(origin_image(:,:,1));
cdf_b = cumsum(count_b); %陣列累加值
cdf_b = cdf_b / numel(origin_image(:,:,1));

%stem(grayLevels,cdf_b);

final_image_r=zeros([h,w,1]);

for i = 1:h
    for j = 1:w
        final_image_r(i,j,1) = cdf_r(origin_image(i,j,1)+1);
        final_image_g(i,j,1) = cdf_g(origin_image(i,j,2)+1);
        final_image_b(i,j,1) = cdf_b(origin_image(i,j,3)+1);
    end
end

subplot(1,2,2);
imshow(cat(3,final_image_r,final_image_g,final_image_b));
hist_im = cat(3,final_image_r,final_image_g,final_image_b);
%imwrite(hist_im,'Prog1_images/1_hist.bmp');

end
