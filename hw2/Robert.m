function robert_im = Robert(origin_image)

[h,w] = size(origin_image(:,:,1));

Gx = [0, -1; 1, 0];
Gy = [-1, 0; 0, 1];

%{
lab_image = rgb2lab(origin_image);
lab_image = im2double(lab_image);
gray_image = rgb2gray(origin_image);
gray_image = im2double(gray_image);


temp_x = convolve(gray_image(:,:,1), Gx);
temp_y = convolve(gray_image(:,:,1), Gy);

tmp = sqrt(temp_x.^2 + temp_y.^2);

threshold = 0.05;
for i = 1:h
    for j = 1:w
        if tmp(i,j) < threshold
            robert_im(i,j) = 0;
        else
            robert_im(i,j) = 1;
        end
    end
end

%}
temp_x(:,:,1) = convolve(origin_image(:,:,1), Gx);
temp_y(:,:,1) = convolve(origin_image(:,:,1), Gy);
temp_x(:,:,2) = convolve(origin_image(:,:,2), Gx);
temp_y(:,:,2) = convolve(origin_image(:,:,2), Gy);
temp_x(:,:,3) = convolve(origin_image(:,:,3), Gx);
temp_y(:,:,3) = convolve(origin_image(:,:,3), Gy);

tmp = sqrt(temp_x.^2 + temp_y.^2);

threshold = 12;
for i = 1:h
    for j = 1:w
        if tmp(i,j,1) > threshold || tmp(i,j,2) > threshold || tmp(i,j,3) > threshold
            robert_im(i,j) = 1;
        else
            robert_im(i,j) = 0;
        end
    end
end



%imwrite(robert_im,'Prog2_images/4_bilateral_robert_rgb_12.bmp');

end

function B = convolve(A, k)
[r c] = size(A);
[m n] = size(k);
h = rot90(k, 2);
center = floor((size(h)+1)/2);
left = center(2) - 1;
right = n - center(2);
top = center(1) - 1;
bottom = m - center(1);
Rep = zeros(r + top + bottom, c + left + right);
for x = 1 + top : r + top
    for y = 1 + left : c + left
        Rep(x,y) = A(x - top, y - left);
    end
end
B = zeros(r , c);
for x = 1 : r
    for y = 1 : c
        for i = 1 : m
            for j = 1 : n
                q = x - 1;
                w = y -1;
                B(x, y) = B(x, y) + (Rep(i + q, j + w) * h(i, j));
            end
        end
    end
end
end