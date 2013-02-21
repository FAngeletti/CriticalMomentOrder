function estimator = qcEstimator( ktheta,krho, tauTh,tauRho )
% qcEstimator : construct an estimator for  q_c with
% parameter k_theta and k_rho with an estimated correlation of tauTh and tauRho
% (which should be equal)
% If no correlation tauTh are provided or if tauTh=0, the lasQuantileEstimator analyze is used
% otherwise the sieved version lQESieve is selected
% If no correlation are provide or if tauRho=0, the cumulative analyzer is used for the estimation of rho otherwise the sieved version rejectCumulativeSieve is selected.



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

function qc = f(X)
    pre=preanalysis(X);
    pre.tau=tauTh;
    theta=thetaAnl(pre);
    pre.tau=tauRho;
    rhoE=rhoAnl(pre);
    qc=theta*rhoE;
end    
   
estimator=@f 
end



