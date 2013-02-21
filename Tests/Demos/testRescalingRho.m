rho=2;
mt=stats.value.matrice;
mM=cellfun ( @(s) s.rhoE{2}.mean, mt );

f=@(x) rho;

vln=log(n.value);
vtau=tau.value;
scale=0.*vtau;
rhos=scale;

%for i=1:length(vtau)
%  res=lsqcurvefit(f,1,vln',mM(:,i));  
%  scale(i)=res(1);
%end

a=0.125;
b=3;
ofscale=@(ln,tau) ln-a.* log(tau) -b;

fscale=@(ln,tau) ln-log(1+a*tau);
figure(2);

x=2:0.1:12;
plot(x,f(x));
hold all;



for i=1:1:length(vtau)
   plot(vln,mM(:,i));%,vln, f(scale(i),vln));
end

hold off

g=@(p,x) p.*x;
beta=lsqcurvefit(g,1,vtau,scale);
%figure(2);
%plot(vtau,scale,vtau,g(alpha,vtau));