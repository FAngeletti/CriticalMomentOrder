function analyse=rejectCumulative(alpha,k)
if nargin<2
    k=50;
end
function rho=f(pre)

n=floor( exp(pre.ln) );
seuil=alpha*n*pre.tau;
qu=pre.tail;
index=pre.index;
rqu=zeros(k,1);

rqu(1)=qu(1);
ip=index(1);
p=2;
vp=1;
while(p<=k&&vp<=n)
    vp=vp+1;
    if ( abs(ip-index(vp))>seuil)
        rqu(p)=qu(vp);
        p=p+1;
        ip=index(vp);
    end
end

if(p-1<k)
k=p-1;
rqu=rqu(1:k);
warning('reduction');
end


x=log(log(rqu));

y=log(-log( (1:k)./n)) ;

x2=horzcat (x, ones(length(x),1));
fp=regress(y',x2);
rho=fp(1);
end
analyse=@f;
end