function log_im = LoG(origin_image)

lab_im = rgb2lab(origin_image);
gray_im = rgb2gray(origin_image);

[h,w] = size(origin_image(:,:,1));

sigma = 1;
kernelSize = 2*ceil(2*sigma)+1;

lin = round(linspace(-floor(kernelSize/2),floor(kernelSize/2),kernelSize));
[X,Y] = meshgrid(lin,lin);
hg = exp(-(X.^2 + Y.^2)/(2*(sigma^2)));
kernel_t = hg.*(X.^2 + Y.^2-2*sigma^2)/(sigma^4*sum(hg(:)));
% make the filter sum to zero
kernel = kernel_t - sum(kernel_t(:))/kernelSize^2;


log_im(:,:) = convolve(double(lab_im(:,:,1)), kernel);
%log_im(:,:) = convolve(double(gray_im(:,:)), kernel);

threshold = 1;
for i = 1:h
    for j = 1:w
        if log_im(i,j) < threshold
            log_im(i,j) = 0;
        else
            log_im(i,j) = 1;
        end
    end
end

%{

final_im(:,:,1) = convolve(double(origin_image(:,:,1)), kernel);
final_im(:,:,2) = convolve(double(origin_image(:,:,2)), kernel);
final_im(:,:,3) = convolve(double(origin_image(:,:,3)), kernel);

threshold = 2.5;
for i = 1:h
    for j = 1:w
        
        if final_im(i,j,1) > threshold || final_im(i,j,2) > threshold || final_im(i,j,3) > threshold
            log_im(i,j) = 1;
        else
            log_im(i,j) = 0;
        end
       
    end
end
%}

%imwrite(log_im,'Prog2_images/4_bilateral_log_lab_1.bmp');

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