function hist_im_I = histogram_intensity(origin_image)

[h,w] = size(origin_image(:,:,1));
lab_im = rgb2lab(origin_image);
count=zeros(1,101);

for i = 1:h
    for j = 1:w
        count(round(lab_im(i,j,1))+1) = count(round(lab_im(i,j,1))+1) + 1; % count為每一級灰度像素個數
    end
end

cdf = cumsum(count); %陣列累加值
cdf = cdf / numel(lab_im(:,:,1));

for i = 1:h
    for j = 1:w
        lab_im(i,j,1) = cdf(round(lab_im(i,j,1))+1)*100;
    end
end

hist_im_I= lab2rgb(lab_im);

end