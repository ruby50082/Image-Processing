function vari=variance(dct_im,m,n,size)

w=zeros(size*size, m/size*n/size);
index=1;
for i = 1:m/size
    for j = 1:n/size
        w(:,index)=reshape(dct_im((i-1)*size+1:(i-1)*size+size,(j-1)*size+1:(j-1)*size+size),[],1);
        index=index+1;
    end
end

vari=zeros(size*size,1);
for i=1:size*size % for each coefficient
    sum=0;
    for j=1:m/size*n/size
        sum=sum+w(i,j);
    end
    mean=sum/(m/size*n/size);
    sum2=0;
    for j=1:m/size*n/size
        sum2=sum2+(w(i,j)-mean)^2;
    end
    %vari(i)=sum2/(m/size*n/size);
    vari(i)=sum2;
end
end