function analyse=rejectCumulativeSieve(alpha,beta,k)
if nargin<3
    k=50;
end
function rho=f(pre)
tau=pre.tau;  

n=length(pre.tail);
sT=alpha*n*(tau/n);

sR=beta*n;
rqu=sieve(sT,sR,pre.tail,pre.index,k);

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