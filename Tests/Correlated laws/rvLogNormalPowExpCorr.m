function rv = rvLogNormalPowExpCorr( param )
%RVLOGNORMALPOWEXPCORR log-Normal power with exponential correlation

default=struct('rho',2,'sigma',1,'ln',0,'tau',1);
m=mask(default,param);

persistent gen
if isempty(gen)
    gen=rvCorrSkeleton(@inverse,@corr);
end
rv=gen(m);


end


    function f=inverse(p)
         f =@(x)  exp( abs(x).^(2/p.rho));
    end

    function c=corr(par)
        n=floor(exp(par.ln));
        c=exp(-(1:n)./par.tau);
    end