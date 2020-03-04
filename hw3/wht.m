clc;
clear;

im=imread('./img/transform/sevilla_800x448.jpg');
im=im2double(im);
[m,n]=size(im);
subplot(1,2,1);
imshow(im);

size=4;
k=6;
N=200;

for i = 1:m/size
    for j = 1:n/size
        wht_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size) = fwht2d(im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size));
    end
end

%wht_im=k_first(wht_im,m,n,size,k);
%wht_im=k_largest(wht_im,m,n,size,k);
wht_im=nbit(wht_im,m,n,size,N);

vari=variance(wht_im,m,n,size);
avg_vari=mean(vari)/(m/size*n/size)

for i = 1:m/size
    for j = 1:n/size
        iwht_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size) = ifwht2d(wht_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size));
    end
end

subplot(1,2,2);
imshow(iwht_im);

imwrite(iwht_im,'./img/transform/wht/sevilla_wht_nbit_4x4_256.png');

err=0;
signal=0;
for i = 1:m
    for j = 1:n
        err = err + (iwht_im(i,j)-im(i,j))^2;
        signal = signal + iwht_im(i,j)^2;
    end
end
erms=sqrt(err/(m*n))
snr=signal/err



function xx = fwht2d(xx)
% The function implement the 2D fast Walsh-Hadamard transform.
% The dimension of the matrix must be an integer power of 2.
N = length(xx);
    for i = 1:N
        xx1(i,:) = fhtseq(xx(i,:)); 
    end
% REPLACE fhtseq BY fhtdya FOR DYADIC ORDER AND fhtnat FOR NATURAL ORDER
xx = zeros(N);
    for j = 1:N
        xx(:,j) = fhtseq(xx1(:,j)')';
    end
end

function xx = ifwht2d(xx)

N = length(xx);
    for i = 1:N
        xx1(i,:) = ifhtseq(xx(i,:)); 
    end
xx = zeros(N);
    for j = 1:N
        xx(:,j) = ifhtseq(xx1(:,j)')';
    end
end

%-------------------------------------------------------
%1D sequency(Walsh)ordered Fast Walsh-Hadamard Transform
%-------------------------------------------------------
function x=fhtseq(data)
x=bitrevorder(data);
N=length(x);
k1=N; k2=1; k3=N/2;
for i1=1:log2(N)
    L1=1;
    for i2=1:k2
        for i3=1:k3
            i=i3+L1-1; j=i+k3;
            temp1= x(i); temp2 = x(j); 
            if(mod(i2,2) == 0)
              x(i) = temp1 - temp2;
              x(j) = temp1 + temp2;
            else
              x(i) = temp1 + temp2;
              x(j) = temp1 - temp2;
            end
        end
            L1=L1+k1;
    end
        k1 = k1/2;  k2 = k2*2;  k3 = k3/2;
end
x=inv(N)*x; %Delete this line for inverse transform
end

function x=ifhtseq(data)
x=bitrevorder(data);
N=length(x);
k1=N; k2=1; k3=N/2;
for i1=1:log2(N)
    L1=1;
    for i2=1:k2
        for i3=1:k3
            i=i3+L1-1; j=i+k3;
            temp1= x(i); temp2 = x(j); 
            if(mod(i2,2) == 0)
              x(i) = temp1 - temp2;
              x(j) = temp1 + temp2;
            else
              x(i) = temp1 + temp2;
              x(j) = temp1 - temp2;
            end
        end
            L1=L1+k1;
    end
        k1 = k1/2;  k2 = k2*2;  k3 = k3/2;
end

end

%------------------------------------------------------
%1D Dyadic(Paley)ordered Fast Hadamard Transform
%------------------------------------------------------
function x=fhtdya(data)
% The function implement the 1D dyadic (Paley) ordered fast Hadamard transform,
x=bitrevorder(data);
N=length(x);
k1=N; k2=1; k3=N/2;
for i1=1:log2(N)   
    L1=1;
    for i2=1:k2
        for i3=1:k3
            i=i3+L1-1; j=i+k3;
            temp1= x(i); temp2 = x(j); 
            x(i) = temp1 + temp2;
            x(j) = temp1 - temp2;
        end
            L1=L1+k1;
    end
        k1 = k1/2;  k2 = k2*2;  k3 = k3/2;
end
x=inv(N)*x; %Delete this line for inverse transform
end
%------------------------------------------------------
%1D Natural(Hadamard)ordered Fast Hadamard Transform
%------------------------------------------------------
function x=fhtnat(data)
% The function implement the 1D natural(Hadamard)ordered Fast Hadamard Transform,
N = pow2(floor(log2(length(data))));
x = data(1:N);
k1=N; k2=1; k3=N/2;
for i1=1:log2(N)
    L1=1;
    for i2=1:k2
        for i3=1:k3
            i=i3+L1-1; j=i+k3;
            temp1= x(i); temp2 = x(j); 
            x(i) = temp1 + temp2;
            x(j) = temp1 - temp2;
        end
            L1=L1+k1;
    end
        k1 = k1/2;  k2 = k2*2;  k3 = k3/2;
end
x=inv(N)*x; %Delete this line for inverse transform
end
%------------------------------------------------------
% Function for bit reversal
%------------------------------------------------------
function R = bitrevorder(X)
%Rearrange vector X to reverse bit order,upto max 2^k size <= length(X)
[f,e]=log2(length(X));
I=dec2bin(0:pow2(0.5,e)-1);
R=X(bin2dec(I(:,e-1:-1:1))+1);
end

%%%%%

function xx=fwhtdya2d(data2)
xx=data2;
N=length(xx);
for i=1:N
    xx1(i,:)=fwhtdyald(xx(i,:));
end
xx=zeros(N);
for j=1:N
    xx(:,j)=fwhtdyald(xx1(:,j));
end
end

function x=fwhtdyald(data1)
N=length(data1);
x=bitrevorder(data1);
L=log2(N);
k1=N;k2=1;k3=N/2;
for i1=1:L
    L1=1;
    for i2=1:k2
        for i3=1:k3
            i=i3+L1-1;j=i+k3;
            temp1=x(i);temp2=x(j);
            x(i)=temp1+temp2;
            x(j)=temp1-temp2;
        end
        L1=L1+k1;
    end
    k1=k1/2;k2=k2*2;k3=k3/2;
end
x=inv(N)*x;
end