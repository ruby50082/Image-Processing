function [ C ] = dct_mtx( N )
for k = 0:N-1
    for n = 0:N-1
       tmp(k+1,n+1) = sqrt(2/N)*cos((0.5+n)*k*pi/N);
    end
end

tmp(1,:) = tmp(1,:) / sqrt(2);
C = tmp;
end
