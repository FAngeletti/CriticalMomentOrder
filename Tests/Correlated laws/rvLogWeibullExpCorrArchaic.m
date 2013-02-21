function rv=rvLogWeibullExpCorrArchaic(s)
default=struct('rho',2, 'scale', 1, 'ln', 0, 'tau', 1);
m=mask(default,s);

n=floor(exp(s.ln));
persistent stored;
persistent store;

if (isempty(stored))
    stored=0;
end

persistent last;

if (isempty(last))
    last=struct('void',[]);
end



persistent Bm;

 f =@(x)  exp(wblinv(normcdf(x), m.scale, m.rho));
if ~structCompare(last,m)
 
    rY=exp( -(0:n)./ m.tau);
    
   
    
% initalization for Gaussian series
[Y,rYapprox,coeffs,X,rXapprox,Bm] =GenUnivarNonGaussUsingHermite(rY,f,n);
last=m;  
stored=1;
store=X;
end

if stored 
    stored=0;
    rv=(f(store));
else
[rv, store]=SynthStepMultivarGaussBestApprox(Bm,n);
stored=1;
rv=(f(rv));
end

end