function r=reconstr(w,num,maxi,mini,m,n,size)
r=zeros(size*size, m/size*n/size);
for i=1:size*size
    if num(i)<=0
        r(i,1:m/size*n/size)=0;
        continue
    end
    interval=(maxi(i)-mini(i))/2^num(i);
    for j=1:m/size*n/size
        idx=1;
        bottom=mini(i);
        while(bottom<=maxi(i))
            if w(i,j)>bottom && w(i,j)<=bottom+interval
                r(i,j)=bottom+0.5*interval;
                break
            end
            bottom=bottom+interval;
        end
    end
    
end
end

