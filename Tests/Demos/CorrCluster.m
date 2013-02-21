
ln2=16;
ln=ln2*log(2);
n=floor(exp( ln2*log(2) ));
template=struct('ln',ln,'rho',2,'tau',2.^(1:ln2));
s=struct('ln',ln,'rho',2);
k=floor(exp(10));

ks=1:n;

y=rvWeibull(s);
[~,index]=sort(y);
plot(index,ks,' .r');

v=variants(template);
m=v.matrice();
for i = 1:length(m); 
  
y=rvLogWeibullExpCorr2(m{i});
[~,index]=sort(y);


figure(i+1);
plot(index,ks,' .r');

end

