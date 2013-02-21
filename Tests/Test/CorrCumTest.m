ln=log(5000);
n=floor(exp(ln))
param=struct('ln',ln,'rho',2);

r=1-((1:n)./n);
pl=@(x,y) plot(log(x),log(-log(y)));

xT=0:0.125:3;
pl(xT,exp(-xT.^param.rho));

hold all;

x=log(sort(rvLogWeibull(param)));


pl(x,r);

alpha=1.;
beta=0.25;

taus=[100];

for tau=taus
    param.tau=tau;
    
[x index]=sort(rvLogWeibullExpCorr2(param));
x=log(x);
y=sieve(alpha*tau,beta*n,x,index,n);
pl(x,r);

nstar=length(y)
rstar=1-(1:nstar)./nstar;
pl(y,rstar);

end

hold off