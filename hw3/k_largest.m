function dct_im=k_largest(dct_im,m,n,size,k)
for i = 1:m/size
    for j = 1:n/size
        t = maxk(dct_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size),k);
        for p=1:size
            for q=1:size
                if dct_im((i-1)*size+p, (j-1)*size+q) < t
                    dct_im((i-1)*size+p, (j-1)*size+q) = 0;
                end
            end
        end
    end
end
end

