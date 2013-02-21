function f=contractedCumulative(alpha,p)

if nargin<2
    k=50;s=2;
else
    k=p.k;s=p.seuil;
end

    function rho=fun(pre)
    
x=log(log(pre.tail(s:k)));
n=floor( exp(pre.ln) );
n=n*(max(1,alpha*pre.tau));
y=log(-log( (s:k)./n)) ;


x2=horzcat (x, ones(length(x),1));
fp=regress(y',x2);
rho=fp(1);
    end
f=@fun;
end
