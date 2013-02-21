rho=2;
mt=stats.value.matrice;
mM=cellfun ( @(s) s.theta{2}.mean, mt );
f=@(p,x) abs(x-p).^(-1./rho);

vln=log(n.value);
vh=hs.value;
scale=0.*vh;
rhos=scale;

for i=1:length(vh)
  res=lsqcurvefit(f,1,vln',mM(:,i)./vln');  
  scale(i)=res(1);
end

a=0.;



fscale=@(ln,h) ln-(1./(1-h)).^a+2.^a;
figure(2);


plot(vln,f(0,vln));
hold all;


for i=1:1:length(vh)
   plot(fscale(vln,vh(i)),mM(:,i)./vln')
end

hold off

