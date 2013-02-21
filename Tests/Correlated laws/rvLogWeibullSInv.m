function rv=rvLogWeibullSInv(s)
default=struct('rho',2, 'scale', 1, 'ln', 0, 'h', 0.5);
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
        v=([1 0:n]).^(2*par.h);
        c=v(1:n)+v(3:(n+2))-2*v(2:(n+1));
        c(1)=1;
    end
