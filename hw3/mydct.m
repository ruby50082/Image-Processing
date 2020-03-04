clc;
clear;

im=imread('./img/transform/sevilla_800x448.jpg');
im=im2double(im);
[m,n]=size(im);
subplot(1,2,1);
imshow(im);

size=16;
k=55;
N=128;
mtx = dct_mtx(size);


for i = 1:m/size
    for j = 1:n/size
        dct_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size) = mtx * im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size) * mtx';
    end
    
end


%dct_im=k_first(dct_im,m,n,size,k);
dct_im=k_largest(dct_im,m,n,size,k);
%dct_im=nbit(dct_im,m,n,size,N);

vari=variance(dct_im,m,n,size);
avg_vari=mean(vari)/(m/size*n/size)

for i = 1:m/size
    for j = 1:n/size
        idct_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size) = inv(mtx) * dct_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size) * inv(mtx');
    end
end
subplot(1,2,2);
imshow(idct_im);
imwrite(idct_im,'./img/transform/sevilla_dct_klargest_16x16_55.png');

err=0;
signal=0;
for i = 1:m
    for j = 1:n
        err = err + (idct_im(i,j)-im(i,j))^2;
        signal = signal + idct_im(i,j)^2;
    end
end
erms=sqrt(err/(m*n))
snr=signal/err












