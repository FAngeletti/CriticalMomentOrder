function f=cumulative(k,s)

if nargin<2
    s=2;
if nargin<1
    k=50;
end
end

    function rho=analyzer(pre)
x=log(log(pre.tail(s:k)));
n=floor( exp(pre.ln) );
y=log(-log( (s:k)./n)) ;


x2=horzcat (x, ones(length(x),1));
fp=regress(y',x2);
rho=fp(1);
    end
f=@analyzer;
end
