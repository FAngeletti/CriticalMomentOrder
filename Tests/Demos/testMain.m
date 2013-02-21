
%Define all the possible laws
weibull=Law(@rvLogWeibull,@logWeibullInfo);
ExpPow=Law(@rvLogExpPow,@LogExpPowInfo);
weibullCorr=Law(@rvLogWeibullExpCorr2,@logWeibullInfo);
ExpPowCorr=Law(@rvLogExpPowExpCorr,@logExpPowInfo);

NormPow=Law(@rvLogNormalPow, @logNormalPowInfo);


% Define the domain of the tests
%template=struct('law', @rvLogWeibullExpCorr, 'rho',1.5:0.1:3, 'ln', log(1000), 'r', 300 , 'tau',[0.1 1 10 30]);

law=weibullCorr;

mode='tau';
n=2.^ (10:16);
r=1000;
rhos=2.;
tau=[10 50 100 ];


%template=struct('law', weibullCorr, 'rho',1.5:0.1:3, 'ln', log(1000), 'r', 10 , 'tau',[1 10 50]);

% Variants creation
%var=variants(template);
tempAndVar=genVariants({law,mode, n, r,rhos, tau} );

template=tempAndVar{1};

var=tempAndVar{2} ;


alpha=0.021;
beta=0.5;
n=0.08;
% analysis functions set0
%theta analysis
ThetaAnlys={lastQuantileEstimator(1),lQESieve(alpha,beta,10) };
%RhoAnlys={@cumulative,pRejectCumulative(0.005), pRejectCumulative(0.0075), pRejectCumulative(0.01) };
RhoAnlys={cumulative(100,2),rejectCumulativeSieve(alpha,beta,100)};


QcAnlys={qcSynth(lastQuantileEstimator(1),cumulative(100,2)),qcSynth(lQESieve(alpha,beta,10),rejectCumulativeSieve(alpha,beta,100))};
LenAnlys={@(pre) pre.len};


anlys= multianalysis(struct('rhoE', {RhoAnlys} , 'theta',{ThetaAnlys},'qc', {ThetaAnlys},'len',{LenAnlys}));
% analysis function
%anlys=multianalysis(setAnlys);


% analysis
stats= cellmap(anlys,var);

logW=logStats({template,stats});

%Statical analysis along the r realisations
%stat=anlysRho.reduce(2,@plus,@(x) statN(2));

%For now we want to look at the mean of rho
obs='rhoE';
modeP=1;

nAnlys=1;
rescaling=false;

graph=plotObs ( {obs,nAnlys,stats,modeP,template,rescaling});

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

