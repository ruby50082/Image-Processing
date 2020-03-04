function ccm_im = ccm(origin_image)

double_image = im2double(origin_image); %轉換到0~1之間

[h,w] = size(double_image(:,:,1));

final_image = zeros(h,w);
for i = 1:h
    for j = 1:w
        
        tmp = [1.1 0 0; 
               0.2 1.1 -0.2; 
               0  0  1.1] * [double_image(i,j,1);double_image(i,j,2);double_image(i,j,3)];
        
        final_image(i,j,1) = tmp(1,1);
        final_image(i,j,2) = tmp(2,1);
        final_image(i,j,3) = tmp(3,1);
            
    end
end

ccm_im = final_image;
end