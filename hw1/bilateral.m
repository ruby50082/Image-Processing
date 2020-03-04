function B = bilateral(A,w,sigma)
A = im2double(A);
if size(A,3) == 1
   B = bfltGray(A,w,sigma(1),sigma(2));
else
   B = bfltColor(A,w,sigma(1),sigma(2));
end
end

function B = bfltGray(A,w,sigma_d,sigma_r)
[X,Y] = meshgrid(-w:w,-w:w);
G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));
dim = size(A);
B = zeros(dim);
for i = 1:dim(1)
   for j = 1:dim(2)
         
         iMin = max(i-w,1);
         iMax = min(i+w,dim(1));
         jMin = max(j-w,1);
         jMax = min(j+w,dim(2));
         I = A(iMin:iMax,jMin:jMax);
         H = exp(-(I-A(i,j)).^2/(2*sigma_r^2));
      
         F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
         B(i,j) = sum(F(:).*I(:))/sum(F(:));
               
   end
end
end

function B = bfltColor(A,w,sigma_d,sigma_r)
if exist('applycform','file')
   A = applycform(A,makecform('srgb2lab'));
else
   A = colorspace('Lab<-RGB',A);
end
[X,Y] = meshgrid(-w:w,-w:w);
G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));
sigma_r = 100*sigma_r;

dim = size(A);
B = zeros(dim);
for i = 1:dim(1)
   for j = 1:dim(2)
      
         iMin = max(i-w,1);
         iMax = min(i+w,dim(1));
         jMin = max(j-w,1);
         jMax = min(j+w,dim(2));
         I = A(iMin:iMax,jMin:jMax,:);
         
         dL = I(:,:,1)-A(i,j,1);
         da = I(:,:,2)-A(i,j,2);
         db = I(:,:,3)-A(i,j,3);
         H = exp(-double(dL.^2+da.^2+db.^2)/double(2*sigma_r^2));
     
         F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
         
         I = double(I);
         norm_F = sum(F(:));
         B(i,j,1) = sum(sum(F.*I(:,:,1)))/norm_F;
         B(i,j,2) = sum(sum(F.*I(:,:,2)))/norm_F;
         B(i,j,3) = sum(sum(F.*I(:,:,3)))/norm_F;
   end
end
if exist('applycform','file')
   B = applycform(B,makecform('lab2srgb'));
else  
   B = colorspace('RGB<-Lab',B);
end
end

