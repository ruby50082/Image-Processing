clc;
clear;

im2= imread('./img/cameraman.tif');
%im2=rgb2gray(im2);
im1=imresize(im2,0.3);
im3=im2double(im2);
subplot(1,3,1);
imshow(im3);
%y=DFT2(im3);
%y_shift=fftshift(y);
%subplot(1,2,2);
%imshow(log(1+abs(y)),[]);



[m,n]=size(im3);

for l=1:1:m
    for k=1:1:n
        im3(l,k)=im3(l,k)*(-1)^(l+k-1);
    end
end

c1=0;
h = waitbar(0,'Calculating DFT please wait......'); 
k=1;l=1;
for l=0:1:m-1
    for k=0:1:n-1
        for x=0:1:m-1
            for y=0:1:n-1
                c= im3(x+1,y+1) * exp(-1i*2*pi*(l*x/m + k*y/n));
                c1=c1+c;
            end
        end
        im(l+1,k+1)=c1;
        c1=0;
    end
    waitbar(l / m);
end
%{
for l=1:1:m
    for k=1:1:n
        im(l,k)=im(l,k)*(-1)^(l+k-1);
    end
end
%}
%im=fftshift(im);

ims = im*255;
close(h)
%imshow(ims);title('dft plot');
% figure
%d=ifft2(im);
subplot(1,3,2);
imshow(log(1+abs(im)),[]);

A=log(1+abs(im));
final=( A - min(A(:)) ) / ( max(A(:)) - min(A(:)) ) ;
subplot(1,3,3);
imshow( ( A - min(A(:)) ) / ( max(A(:)) - min(A(:)) ) );
%imwrite(final,'./img/cameraman_dft.tif');