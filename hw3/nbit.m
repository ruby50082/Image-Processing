function dct_im=nbit(dct_im,m,n,size,N)
vari=variance(dct_im,m,n,size);
q=log(vari);
s=0;
for i =1:size*size
    if q(i)<0
        q(i)=0;
    end
    s=s+q(i);
end
num=round(N/s*q);


w=zeros(size*size, m/size*n/size);
index=1;
for i = 1:m/size
    for j = 1:n/size
        w(:,index)=reshape(dct_im((i-1)*size+1:(i-1)*size+size,(j-1)*size+1:(j-1)*size+size),[],1);
        index=index+1;
    end
end

for i =1:size*size
    maxi(i)=max(w(i,:));
    mini(i)=min(w(i,:));
end

r=reconstr(w,num,maxi,mini,m,n,size);

index=1;
for i = 1:m/size
    for j = 1:n/size
        tmp=reshape(r(:,index),size,size);
        dct_im((i-1)*size+1 : (i-1)*size+size, (j-1)*size+1 : (j-1)*size+size)=tmp;
        index=index+1;
    end
end
end