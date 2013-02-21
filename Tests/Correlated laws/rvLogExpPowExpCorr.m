function rv = rvLogExpPowExpCorr( par )
%rvLogExpPowExpCorr Create exponentially correlated rv with power exponential marginal
% par : structured parameter with potential argument 
% rho, scale : pdf exp(-(x/scale)^rho)
% tau : correlation exp(-x/tau)
% n number of term
% attention : this function use a complex cache system which should
% accelerate it execution after the second call with the exact same
% parameter

default=struct('rho',2, 'scale', 1, 'ln', 0, 'tau', 1);
m=mask(default,par);
 

persistent gen;

if isempty(gen)
gen=rvCorrSkeleton(@inversion, @corr);
end

rv=gen(m);
end

    function res=inversion(par)  
    rho=par.rho;
    norm=rho/gamma(1/rho);
 
    table=expPowInversionTable(rho,norm,2^15+1);

    function x=fInv(y)
        x=expPowInversion(rho,norm,table,y);
    end

res=@fInv;
    end

    function res=corr(par)
        n=floor(exp(par.ln));
        res=exp(-(1:n)./par.tau);      
    end