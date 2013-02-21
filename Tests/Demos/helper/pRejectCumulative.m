function analyse=pRejectCumulative(r,k)
if nargin<2
    k=50;
end
function rho=f(pre)
k=50;

tau=pre.tau;
n=floor( exp(pre.ln) );
seuil=n*r*tau;
qu=pre.tail;
index=pre.index;
rqu=zeros(k,1);

rqu(1)=qu(1);
ip=index(1);
p=2;
vp=1;
n=length(qu);
while(p<=k && vp< n)
    vp=vp+1;
    if ( abs(ip-index(vp))>seuil)
        rqu(p)=qu(vp);
        p=p+1;
        ip=index(vp);
    end
end

if (vp==n-1)
    r=r*0.5;
    rho=f(pre);
    r=2*r;
else

x=log(log(rqu));

y=log(-log( (1:k)./n)) ;

x2=horzcat (x, ones(length(x),1));
fp=regress(y',x2);
rho=fp(1);
end
end
analyse=@f;
end