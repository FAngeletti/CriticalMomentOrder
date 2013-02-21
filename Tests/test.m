%Modify the path
global PathModified;
if(PathModified==0)
cd ../MVnGSynthesis
LRDLabPath
cd ../CriticalMoment
CriticalPath
PathModified=0;
end

%Define all the possible laws
Weibull=Law(@rvLogWeibull,@logWeibullInfo);
ExpPow=Law(@rvLogExpPow,@LogExpPowInfo);
WeibullCorr=Law(@rvLogWeibullExpCorr2,@logWeibullInfo);
ExpPowCorr=Law(@rvLogExpPowExpCorr,@logExpPowInfo);

rhos=1.2:0.25:3;
rho=2;
n=1000;
taus=10:10:201;
estimated=0.*taus;
pos=0;
for tau=taus
 pos=pos+1;
% Define the parameters of the law
%tau=20;
param=struct('ln', log(n), 'rho', rho, 'tau',tau);
%Select a law
L=WeibullCorr;

% Read theoretical information
Theor=L.info(param);

%Select an analyse

%Simple cumulative analysis
%analyse=cumulative();

%Rejection of adjacent points
%analyse=rejectCumulative(0.001, 50 );

%Rejection of point in a rectangular neighborhood
%analyse=rejectCumulativeSieve(0.002,0.5);

%Create a statistic handler
stat=statN(2);

%Number of realisation
nRealisation=100;

for i=1:nRealisation
    

%Sample a realisation
X=L.rv(param);

%Perform a pre-analysis on the data
pre=preanalysis(X);

seuil=pre.tail(ceil(length(pre.tail)/2));

%Add information about the correlation by hand 
pre.tau=tau;

%Analyse
stat+rankLength(seuil,X);
end
estimated(pos)=stat.mean();
%variance=stat.variance()
end

plot(taus,estimated)