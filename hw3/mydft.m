clc;
clear;

im=imread('./img/transform/sevilla_800x448.jpg');
im=im2double(im);
[m,n]=size(im);
subplot(1,2,1);
imshow(im);

size=4;
k=6;
N=256;
mtx = dft_mtx(size);

for i = 1:m/size
    for j = 1:n/size
        dft_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size)  = mtx * im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size) * mtx';
    end
end


dft_im=k_first(dft_im,m,n,size,k);
%dft_im=k_largest(dft_im,m,n,size,k);
%dft_im=nbit(dft_im,m,n,size,N);

vari=variance(dft_im,m,n,size);
avg_vari=mean(vari)/(m/size*n/size);
avg_vari=sqrt(avg_vari*conj(avg_vari))

for i = 1:m/size
    for j = 1:n/size
        idft_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size)=inv(mtx)*dft_im((i-1)*size+1:(i-1)*size+size,(j-1)*size+1:(j-1)*size+size)*inv(mtx');
    end
end

A=log(1+abs(idft_im));
final=( A - min(A(:)) ) / ( max(A(:)) - min(A(:)) ) ;
subplot(1,2,2);
imshow( ( A - min(A(:)) ) / ( max(A(:)) - min(A(:)) ) );

%imwrite(final,'./img/transform/dft/sevilla_dft_klargest_4x4_6.png');

err=0;
signal=0;
for i = 1:m
    for j = 1:n
        err = err + (idft_im(i,j)-im(i,j))^2;
        signal = signal + idft_im(i,j)^2;
    end
end
err=sqrt(err*conj(err));
signal=sqrt(signal*conj(signal));
erms=sqrt(err/(m*n))
snr=signal/err


function dftmat =  dft_mtx(N)

for k=0:N-1
    for l=0:N-1
        w(k+1,l+1)=cos((2*pi*k*l)/N)-1i*sin((2*pi*k*l)/N);
    end
end

dftmat=w;
end