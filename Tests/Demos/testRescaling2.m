rho=2;
mt=stats.value.matrice;
mM=cellfun ( @(s) s.theta{1}.mean, mt );
mL=cellfun ( @(s) s.len{1}.mean, mt );
vL=mL(1,:);

f=@(x) x.^(-1./rho);

vln=log(n.value);
vtau=tau.value;
scale=0.*vtau;
rhos=scale;

%for i=1:length(vtau)
%  res=lsqcurvefit(f,1,vln',mM(:,i));  
%  scale(i)=res(1);
%end

aL=0.25;
aT=0.1;
ofscale=@(ln,tau) ln-a.* log(tau) -b;

fscale=@(ln,t) ln -log(t) ;

figure(1);
x=5:0.1:12;
plot(x,f(x));
hold all;
for i=1:1:length(vtau)
   plot(fscale(vln,aL*vL(i)),mM(:,i)./vln');%,vln, f(scale(i),vln));
end
hold off

figure(2);
x=5:0.1:12;
plot(x,f(x));
hold all;
for i=1:1:length(vtau)
   plot(fscale(vln,1+aT*vtau(i)),mM(:,i)./vln');%,vln, f(scale(i),vln));
end
hold off


g=@(p,x) p.*x;
beta=lsqcurvefit(g,1,vtau,scale);
%figure(2);
%plot(vtau,scale,vtau,g(alpha,vtau));
