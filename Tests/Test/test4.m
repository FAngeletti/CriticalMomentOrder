%% Paths
% addpath /Users/pabry/MATLAB/Estim_qc/
% CriticalPathOwn
% addpath /Users/pabry/MATLAB/LONGDEP/LRDLab/MVnGSynthesis/
% LRDLabPathOwn

%% Def 

clear all
% close all

%Define all the possible laws
Weibull=Law(@rvLogWeibull,@logWeibullInfo);
ExpPow=Law(@rvLogExpPow,@LogExpPowInfo);
WeibullCorr=Law(@rvLogWeibullExpCorr2,@logWeibullExpCorrInfo);
ExpPowCorr=Law(@rvLogExpPowExpCorr,@logExpPowInfo);

L=WeibullCorr ;
rho =   2 ; 
tau =  100 ; 
param=struct('ln', log(10000), 'rho', rho, 'tau',tau);

%%  generation
Theor=L.info(param)
X=L.rv(param) ;
figure(1) ; clf ; plot(X,'k') ; 

%%  Estimation

%Rejection of point in a rectangular neighborhood
alpha_rho = 0.021 ; beta_rho = 0.5 ; 
k_rho = 100 ; % k_rho = fix() ; 
alpha_theta = 0.021 ; beta_theta = 0.5 ; 
k_theta = 10 ; % k_theta  = fix() 
% tauTh = 2*tau ;  tauRho= 2*tau ;
% tauTh = tau ;  tauRho= tau ;
% tauTh = 0 ;  tauRho = 0 ;

%[ theta,rhoE,qc] = globAnalysis( X,ktheta,krho, tauTh,tauRho )
% if(tauTh==0)
%         analyse_theta=lastQuantileEstimator(k_theta);
% else
%         % analyse_theta=lQESieve(alpha,beta);
%         analyse_theta=lQESievebis(alpha_theta,beta_theta,k_theta);
% end
% if(tauRho==0)
%         analyse_rho=cumulative(struct('k',k_rho,'seuil',1)); 
% else
%         analyse_rho =rejectCumulativeSieve(alpha_rho,beta_rho,k_rho);
% end

nbreal = 200 ; 
% tauThliste = [0 50 100 150] ; 
tauThliste = [0 10 25 50 75 87 100 112 125 150 200] ; 
analyse_theta=lQESieve(alpha_theta,beta_theta,k_theta);
analyse_rho =rejectCumulativeSieve(alpha_rho,beta_rho,k_rho);
for k=1:1:nbreal
 k
    X=L.rv(param) ;
    for n=1:1:length(tauThliste)
        tauTh = tauThliste(n) ; 
%         if(tauTh==0)
%             analyse_theta=lastQuantileEstimator(k_theta);
%             analyse_rho=cumulative(struct('k',k_rho,'seuil',1)); 
%         else
%             analyse_theta=lQESieve(alpha_theta,beta_theta,k_theta);
%             analyse_rho =rejectCumulativeSieve(alpha_rho,beta_rho,k_rho);
%         end
        pre=preanalysis(X); 
        pre.tau=tauTh;
        pre.lnstar=Theor.lnstar;
        theta_est(k,n) = analyse_theta(pre);
        % pre.tau=tauRho;
        rho_est(k,n)   = analyse_rho(pre);
        qc_est(k,n)    = theta_est(k,n)*rho_est(k,n);
    end
end
 
display('rho')
[tauThliste
    Theor.rhoE*ones(size(tauThliste))
    mean(rho_est)
std(rho_est)]

display('theta')
[tauThliste
    Theor.theta*ones(size(tauThliste))
 mean(theta_est)
std(theta_est)]

display('qc')
[tauThliste 
    Theor.qc*ones(size(tauThliste))
mean(qc_est)
std(qc_est)]

figure(2) ; clf
errorbar(tauThliste,mean(rho_est),std(rho_est),'ok-') ; grid on ; hold on ; V = axis ; 
plot([tau tau], [V(3) V(4)],'r--') ; 
plot(tauThliste,Theor.rhoE*ones(size(tauThliste)),'r--') ; 
title('rho') ; xlabel('tau') 

figure(3) ; clf
errorbar(tauThliste,mean(theta_est),std(theta_est),'ok-') ; grid on ; hold on ; V = axis ; 
plot([tau tau], [V(3) V(4)],'r--') ; 
plot(tauThliste,Theor.theta*ones(size(tauThliste)),'r--') ; 
title('theta') ; xlabel('tau') 

figure(4) ; clf
errorbar(tauThliste,mean(qc_est),std(qc_est),'ok-') ; grid on ; hold on ; V = axis ; 
plot([tau tau], [V(3) V(4)],'r--') ; 
plot(tauThliste,Theor.qc*ones(size(tauThliste)),'r--') ; 
title('qc') ; xlabel('tau') ; axis([V(1) V(2) 0 V(4)])
