function rv=rvLogWeibullExpCorr2(s)
default=struct('rho',2, 'scale', 1, 'ln', 0, 'tau', 1);
m=mask(default,s);

persistent gen
if isempty(gen)
    gen=rvCorrSkeleton(@inverse,@corr);
end
rv=gen(m);

end

    function f=inverse(m)
         f =@(x)  exp(wblinv(normcdf(x), m.scale, m.rho));
    end

    function c=corr(par)
        n=floor(exp(par.ln));
        c=exp(-(1:n)./par.tau);
    end