ln=template.value.ln;
mt=stats.value.matrice;
mM=cellfun ( @(s) s.theta{1}.mean, mt );
f=@(x,y) ln./(ln - log(x(1))).^(1./y);

vrho=rhos.value;
vtau=tau.value;
scale=0.*vtau;

for i=1:length(vtau)
   scale(i)=lsqcurvefit(f,1,vrho',mM(:,i));  
end

figure(1);
plot(vrho,f(1,vrho));
hold all;

for i=1:5:length(vtau)
   plot(vrho,mM(:,i),vrho, f(scale(i),vrho));
end

hold off

g=@(p,x) p(2)+p(1).*(x.^(p(3)));
alpha=lsqcurvefit(g,[1 0 1],vtau,scale);
figure(2);
plot(vtau,scale,vtau,g(alpha,vtau));