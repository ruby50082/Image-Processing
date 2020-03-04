clc;
clear;


I = imread('cameraman.tif');
D = dctmtx(size(I,1));
temp = my_dct_2d(I);
newImage = uint8( my_idct_2d(temp));
%imshow([I temp]);
function A=dctmatrix_1d(N)
     c(1:N,1)=sqrt(2/N);  c(1)=c(1)/sqrt(2);
     
     e=(0:N-1);
     
     A=c.*cos(  e(:)  *  (pi*(2*e+1)/(2*N))  );
end
 function dct = my_dct_2d(image)
  image = double(image);
  N = length(image);
  A=dctmatrix_1d(N);
  
  dct=A*image*A.';
  
  
end
 
function idct = my_idct_2d(image)
  image = double(image);
  N = length(image);
  A=dctmatrix_1d(N);
  
  idct=A\image/A.';
end
