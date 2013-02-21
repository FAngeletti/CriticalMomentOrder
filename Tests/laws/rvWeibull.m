function v=rvWeibull(p)
default=struct('rho',2, 'scale', 1, 'ln', 0);
m=mask(default,p);
n=floor(exp(m.ln));
v=wblrnd(m.scale,m.rho, n,1);
end