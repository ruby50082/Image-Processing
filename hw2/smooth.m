function smooth_im = smooth(origin_image)

double_image = im2double(origin_image);
kernel = ones(3,3)/9;
final_image_1(:,:,1) = convolve(double_image(:,:,1),kernel);
final_image_1(:,:,2) = convolve(double_image(:,:,2),kernel);
final_image_1(:,:,3) = convolve(double_image(:,:,3),kernel);

kernel = [1 2 1; 2 4 2; 1 2 1]/16;
final_image_2(:,:,1) = convolve(double_image(:,:,1),kernel);
final_image_2(:,:,2) = convolve(double_image(:,:,2),kernel);
final_image_2(:,:,3) = convolve(double_image(:,:,3),kernel);

smooth_im = final_image_2;
%imwrite(smooth_im,'Prog1_images/5_AWB_log_avg.bmp');
end

function B = convolve(A, k);
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