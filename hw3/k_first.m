function dct_im=k_first(dct_im,m,n,size,k)
index=0;
mask=zeros(size,size);
for i=1:size
    for j=1:size
        if i+j <= (-1+sqrt(1+8*k))/2+1
            mask(i,j)=1;
            index=index+1;
        end
        if index==k
            break
        end
    if index==k
        break
    end
    end
end

for i = 1:m/size
    for j = 1:n/size
        dct_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size) = dct_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size) .* mask;
    end
end

end
