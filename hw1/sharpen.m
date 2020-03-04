function sharpen_im = sharpen(origin_image)

lab_im = rgb2lab(origin_image);
kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];
lab_im(:,:,1) = lab_im(:,:,1) + convolve(double(lab_im(:,:,1)), kernel);
final_image_1 = lab2rgb(lab_im);

lab_im = rgb2lab(origin_image);
kernel = [0 -1 0; -1 4 -1; 0 -1 0];
lab_im(:,:,1) = lab_im(:,:,1) + convolve(double(lab_im(:,:,1)), kernel);
final_image_2 = lab2rgb(lab_im);

lab_im = rgb2lab(origin_image);
kernel = [-1 -2 -1; 0 0 0; 1 2 1];
lab_im(:,:,1) = lab_im(:,:,1) + convolve(double(lab_im(:,:,1)), kernel);
final_image_3 = lab2rgb(lab_im);

lab_im = rgb2lab(origin_image);
kernel = [-1 0; 0 1];
lab_im(:,:,1) = lab_im(:,:,1) + convolve(double(lab_im(:,:,1)), kernel);
final_image_4 = lab2rgb(lab_im);

sharpen_im = final_image_4;
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