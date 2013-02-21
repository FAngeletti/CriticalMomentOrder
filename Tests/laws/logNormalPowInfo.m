function [ inf ] = logNormalPowInfo( param )
%logNormalPowInfo Return the theoretical rho_E, theta and qc of a
%log-Normal power law for the parameter param
% see NormalPowInfo for more detailed information for param

%Complete the structure with default value
default=struct('rho',2,'sigma',1,'ln',0);
param=mask(default,param);

n=floor(exp(param.ln));

ydag=FInv(param,1/n);

inf.ydag=ydag;
inf.theta=param.ln/ydag;
inf.rhoE= ydag*n * Prob(param,ydag)/ param.ln;
inf.qc=inf.theta*inf.rhoE;
inf.len=0;

end

function y=FInv(p,q)

y=(sqrt(2)*p.sigma*erfcinv( q)).^(2/p.rho);

end

function p=Prob(param,y)
 p=sqrt(1/(2*pi))/param.sigma * param.rho*y.^(param.rho/2-1).*exp(-y.^param.rho./(2*param.sigma^2));
end