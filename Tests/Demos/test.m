
%Define all the possible laws
weibull=Law(@rvLogWeibull,@logWeibullInfo);
ExpPow=Law(@rvLogExpPow,@LogExpPowInfo);
weibullCorr=Law(@rvLogWeibullExpCorr,@logWeibullInfo);
ExpPowCorr=Law(@rvLogExpPowExpCorr,@logExpPowInfo);


% Define the domain of the tests
%template=struct('law', @rvLogWeibullExpCorr, 'rho',1.5:0.1:3, 'ln', log(1000), 'r', 300 , 'tau',[0.1 1 10 30]);

law=weibullCorr;
mode='nBytau';
n=100;
r=10;
rhos=1.5:0.25:3;
tau=[1 10 50];


%template=struct('law', weibullCorr, 'rho',1.5:0.1:3, 'ln', log(1000), 'r', 10 , 'tau',[1 10 50]);

% Variants creation
%var=variants(template);
V=genVariants({law,mode, n, r,rhos, tau});
template=V{1};
var=V{2};

% analysis functions set
setAnlys=struct('rhoE', {{@cumulative}}, 'theta', {{@lastQuantileEstimator}})
% analysis function
anlys=multianalysis(setAnlys);


% analysis
stats=var.map(anlys);

%Statical analysis along the r realisations
%stat=anlysRho.reduce(2,@plus,@(x) statN(2));

%For now we want to look at the mean of rho
obs='theta';

plotObs({obs,stats,1,template})
%means=stats.map(@(s) s.(obs){1}.mean);
%variance=stats.map(@(s) s.(obs){1}.variance);

%theor=stats.map( @(s) s.(obs){1}.theorie);


%mat=cell2mat(means.matrice);
%matV=sqrt(cell2mat(variance.matrice));
%vtheor=cell2mat(theor.matrice);
%errorbar(template.rho,mat,matV); 
%hold all;
%plot(template.rho, vtheor);
%hold off

