n=10000;
param.ln=log(n);
n=floor(exp(param.ln));
param.rho=1.5;
param.sigma=1;

x=rvNormalPow(param);
prA=preanalysis(exp(x));
x=sort(x);
r=(n:-1:1)./n;

p= @(y) sqrt(1/(2*pi))/param.sigma * param.rho*y.^(param.rho/2-1).*exp(-y.^param.rho./(2*param.sigma^2));
F= @(x) erfc(x.^(param.rho/2)./(sqrt(2)*param.sigma));
h= @(x) -log(F(x));
rhoE= @(x) x.*p(x)./(F(x).*h(x));

ydag= @(x) (sqrt(2).*param.sigma.*erfcinv(1./x)).^(2/param.rho);

figure(1)
plot(x,-log(r),x,h(x))

figure(2)
lx=0:0.1:50;
plot(x, rhoE(x) )

figure(3)
plot(log(x),log(-log(r)),log(x),log(h(x)))



figure(4)
p=1:n;
ydag(p);
plot(p,rhoE(ydag(p)));

nR=1000;

k=15:500;
Est=0.*k;
for i=1:nR

x=rvNormalPow(param);
prA=preanalysis(exp(x));


for i=1:length(k)
    s=struct('k',k(i),'seuil',10);
    A=cumulative(s);
    Est(i)=Est(i)+A(prA);
end

end
figure(5);
plot(k,rhoE(ydag(n)),k,Est./nR)