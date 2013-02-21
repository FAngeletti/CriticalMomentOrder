function info=logWeibullInfo(s)

theta= s.ln^(1-1/s.rho);
info=struct('theta', theta, 'rhoE', s.rho,'qc',theta*s.rho,'len',0 );

end