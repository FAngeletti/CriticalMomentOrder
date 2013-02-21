function fSkel=rvCorrSkeleton( functionnal, corrFunct)
%rvCorrSkeleton Create a cached random value generator with correlation
% functionnal : par -> invCdf generate the inverse transform
% corrFunct par -> correlation
stored=0;
store=[];
last= struct([] ) ;
Bm=[];
f=[];

function rv=Fun(par)


n=floor(exp(par.ln));


if ~structCompare(last,par)
    f = functionnal(par) ;
    rY=corrFunct(par);
    
   
    
% initalization for Gaussian series
[~,~,~,X,~,Bm] =GenUnivarNonGaussUsingHermite(rY,f,n,30);

last=par;  
stored=1;
store=X;
end

if stored 
    stored=0;
    rv=f(store);
else
[rv, store]=SynthStepMultivarGaussBestApprox(Bm,n);
stored=1;
rv=f(rv);
end

    end
fSkel=@Fun;

end