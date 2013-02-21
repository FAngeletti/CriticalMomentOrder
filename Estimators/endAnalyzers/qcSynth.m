function qcAnl=qcSynth(thetaAnl,rhoAnl)
% qcSynth(thetaAnl,rhoAnl) Generate a qc estimator from the two end analyzers
% thetaAnl and rhoAnl
    function qc=qcAnlf(pre)
    theta=thetaAnl(pre);
    rhoE=rhoAnl(pre);
    qc=rhoE*theta;
    end

qcAnl=@qcAnlf;
end
