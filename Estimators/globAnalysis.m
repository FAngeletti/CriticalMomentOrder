function [ theta,rhoE,qc] = globAnalysis( X,ktheta,krho, tauTh,tauRho )
% globAnalysis : estimates theta, rho and q_c
if(nargin<=3)
    tauTh=0;
    tauRho=0;
end

if(tauTh==0)
         thetaAnl=lastQuantileEstimator(ktheta);
else
        thetaAnl=lQESieve(0.002,0.5);
end

if(tauRho==0)
        rhoAnl=cumulative(struct('k',krho,'seuil',1)); 
else
        rhoAnl=rejectCumulativeSieve(0.002,0.5);
end

    pre=preanalysis(X);
    pre.tau=tauTh;
    theta=thetaAnl(pre);
    pre.tau=tauRho;
    rhoE=rhoAnl(pre);
    qc=theta*rhoE;
    
   
  
end



