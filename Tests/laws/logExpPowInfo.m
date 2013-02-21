function s=logExpPowInfo(s)
rho=s.rho;
    function r=h(x)
       r=-log(gammainc(x.^rho,1/rho,'upper')) ;
    end

    function r=hInv(y)
        f=@(x) h(x)-y;
     
        r=fsolve(f,y^1/rho);      
    end
ydag=hInv(s.ln);

theta=s.ln/ydag;
n=exp(s.ln);
rhoE= n* exp( - ydag^s.rho)/theta;

s=struct('theta',theta,'rhoE',rhoE, 'qc', theta*rhoE,'len',0);
end