n=10;
sr=5;
st=5;
k=5;
error=false;
iterM=100000;
it=0;
while((error==false) && it<iterM)
    x=randn(n,1);
    [t i]=sort(x,'descend');
    rM=sieveM(st,sr,t,i,5);
    r=sieve(st,sr,t,i,5);

    if(length(r)~=length(rM) || ~isempty(find(r~=rM, 1)))
        error=true;
    end
    it=it+1;
end

error

