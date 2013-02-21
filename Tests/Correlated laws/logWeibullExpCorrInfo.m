function info=logWeibullExpCorrInfo(s)

kappa=0.08;
lnstar=s.ln-log(1+kappa*s.tau);
theta= lnstar^(1-1/s.rho);
info=struct('theta', theta, 'rhoE', s.rho,'qc',theta*s.rho,'len',0,'lnstar',lnstar );

end