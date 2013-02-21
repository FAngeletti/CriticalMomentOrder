
s=struct('ln',10,'rho',2);

y=rvWeibull(s);

[ys,index]=sort(y);

plot(index,ys);