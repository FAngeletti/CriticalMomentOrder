function estimator = qcEstimator( krho, tauRho )
% qcEstimator : construct an estimator for  rho_E with
% parameter k_rho and an estimated correlation of tauRho
% (which should be equal)
% If no correlation are provide or if tauRho=0, the cumulative analyzer is used for the estimation of rho otherwise the sieved version rejectCumulativeSieve is selected.



if(nargin<2)
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

function rhoE = f(X)
    pre=preanalysis(X);
    pre.tau=tauRho;
    rhoE=rhoAnl(pre);
end    
   
estimator=@f 
end



