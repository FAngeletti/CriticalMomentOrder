function y=sieveM(st,sr,x,index,k)


n=length (x);


function eliminate(rank, temps )

for i=rank:min(n,rank+sr)
    if  ( abs(temps-index(i))<st )
        sieveT(i)=0;
    end

end
end



y=zeros(k,1);
sieveT=ones(n,1);
r=1;
j=1;
t=index(r);
y(j)=x(r); 
eliminate(r,t)

while(j<k && r<=n) 
pos=find(sieveT((1+r):n),1,'first') ;
if(isempty(pos))
    r=n+1;
else    
r=r+pos;

t=index(r);
j=j+1;
y(j)=x(r);

eliminate(r,t)
end
end
if(j<k)
    y=y(1:j);
end
end

