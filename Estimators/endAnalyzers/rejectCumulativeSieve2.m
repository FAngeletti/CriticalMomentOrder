function analyse=rejectCumulativeSieve2(alpha,k)
if nargin<2
    k=50;
end

function rho=f(pre)

n=length(pre.tail);
sT=alpha*pre.len;

sR=0.5*n;
rqu=sieve(sT,sR,pre.tail;pre.index,k);


kr=length(rqu);
x=log(log(rqu));
n=floor( exp(pre.ln) );
%n=n/(1+gamma*tau);
y=log(-log( (1:kr)./n)) ;

x2=horzcat (x, ones(length(x),1));
fp=regress(y',x2);
rho=fp(1);
end
analyse=@f;
end