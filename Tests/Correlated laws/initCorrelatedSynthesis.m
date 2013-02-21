function [rXapproxCell,approxFlag,Bm]=initCorrelatedSynthesis( funch, rY, options)
default=struct('M', 30, 'xbound', [], 'zeropadLength', 0 );
if nargin<3 
    options=default;
else 
% Options mask
options=mask(default,options);
end

n=length(rY);
% Determination of the hermitian decomposition of funch
coeffs = HermiteCoeffExpansion(funch,options.M);

[fwdSeq, revSeq] = CovarSequence(coeffs, coeffs, options.zeropadLength);

fwdPolyCoeff = fliplr([0 fwdSeq]);
revPolyCoeff = fliplr([0 revSeq]);


% Normalisation of rY
varY = polyval(fliplr([0 fwdSeq]),1);

rYnormalized = varY/rY(1) * rY;

% Reversion
% Do the reversion but force r^X[0]=1, in case reversion does not work there (which is often the case)
rX = polyval(revPolyCoeff,rYnormalized);
rX(1) = 1; % forcing the variance in the Gaussian sequence to be 1

% Correction
rYreversion = polyval(fwdPolyCoeff,rX);

%PEND! Make this parameter adjustable...
thresh = 1e-4;
indBAD = find(abs(rYnormalized-rYreversion)>thresh);

%for k = 1:length(rYnormalized);
for k=indBAD
     rX2rY = @(t) polyval(fwdPolyCoeff,t)-rYnormalized(k);
     rX(k) = fzero(rX2rY,1);
end

[rXapproxCell,approxFlag,Bm] = InitStepMultivarGaussBestApprox({rX},n);

end