function estimator = thetaEstimator( ktheta, tauTh )
% thetaEstimator : construct an estimator for  theta with
% parameter k_theta and an estimated correlation of tauTh.
% If no correlation are provided or if tauTh=0, the lasQuantileEstimator analyze is used
% otherwise the sieved version lQESieve is selected


if(nargin<2)
    tauTh=0;
end



if(tauTh==0)
         thetaAnl=lastQuantileEstimator(ktheta);
else
        thetaAnl=lQESieve(0.002,0.5);
end


function theta = f(X)
    pre=preanalysis(X);
    pre.tau=tauTh;
    theta=thetaAnl(pre);
end    
   
estimator=@f 
end



