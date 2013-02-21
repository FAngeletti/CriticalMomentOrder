function estimator = totalEstimator( ktheta,krho, tauTh,tauRho )
% totalEstimator : construct an estimator for  [theta, rho, q_c] with
% parameter k_theta and k_rho with an estimated correlation of tauTh and tauRho
% (which should be equal)


if(nargin<4)
    tauRho=0;
if (nargin<3)
	tauTh=0;
end
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

function [theta, rhoE, qc] = f(X)
    pre=preanalysis(X);
    pre.tau=tauTh;
    theta=thetaAnl(pre);
    pre.tau=tauRho;
    rhoE=rhoAnl(pre);
    qc=theta*rhoE;
end    
   
estimator=@f 
end



