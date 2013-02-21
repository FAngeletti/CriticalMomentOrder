function anlys=lastQuantileEstimator(k)
if(nargin<1)
   k=5; biais=0; 
else
biais=0;
end

function theta=f(pre)
persistent eulerGamma;
if isempty(eulerGamma)
    eulerGamma=-psi(0,1);
end

if(k>1)
c= (Harm(k-1)-eulerGamma);
if (biais)
c=c/k;
else
c=c/(k-1);
end
ac=1-(k-1)*c;
else
c=0;
ac=1;
end

w=c*ones(k,1);
w(k)=ac;

v=log(pre.tail(1:k));

theta= pre.ln/sum(v.*w);
end
anlys=@f;
end
