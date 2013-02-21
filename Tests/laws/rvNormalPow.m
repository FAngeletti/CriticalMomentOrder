function [ v ] =rvNormalPow( p )
%RVNORMALPOW Power of a (positive) normal law
%   ln : log of the number of desired sample
%   rho : desired power behaviour
%   sigma  :standard deviation of the gaussian
default=struct('rho',2,'sigma',1,'ln',0);
p=mask(default,p);
n=floor(exp(p.ln));
v=(abs(p.sigma*randn(n,1))).^(2/p.rho);

end

