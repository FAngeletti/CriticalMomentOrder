function qcAnl=qcSynth(thetaAnl,rhoAnl)

    function qc=qcAnlf(pre)
    theta=thetaAnl(pre);
    rhoE=rhoAnl(pre);
    qc=rhoE*theta;
    end

qcAnl=@qcAnlf;
end
