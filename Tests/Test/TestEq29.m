%Modify the path
% Modi PA FAn Mai 2012 
% Test Eq 29 in SP paper

% global PathModified;
% 
% if(PathModified==0)
% cd ../MVnGSynthesis
% LRDLabPath
% cd ../CriticalMoment
% CriticalPath
% PathModified=0;
% end

%Define all the possible laws
Weibull=Law(@rvLogWeibull,@logWeibullInfo);
ExpPow=Law(@rvLogExpPow,@logExpPowInfo);


%Parameters 
n=1000000;
ln=log(n);
rho=2;
nRealisation=100;


    % Define the parameters of the law
    param=struct('ln', ln, 'rho', rho);
    %Select a law
    L=ExpPow;

    % Read theoretical information
    Theor=L.info(param)

 
	qc=Theor.qc;
    qliste = (2*qc):(0.1*qc):(4*qc) ; 
    nqliste = length(qliste) ; 
    mom=zeros(1,nqliste);
    

     for i=1:nRealisation

            %Sample a realisation
            X=L.rv(param);

            for k = 1:1:nqliste
                mom(k) = mom(k)+ log(sum(abs(X).^qliste(k))) ; 
            end  
    end

    mom = mom ./ nRealisation ; 
    
    qliste
    mom
    
    pp = polyfit(qliste,mom,1) ; 
    
    slopeL=param.ln * ( rho/Theor.qc  )
	slopeE= param.ln * (Theor.rhoE/Theor.qc)
    [pp(1) slopeL slopeE]

	figure(1);
	xlabel('q'); ylabel('\ln S');
	plot(qliste,mom,'k'); hold on;
	plot(qliste, ln*(rho*qliste./Theor.qc),'r' );
	plot(qliste, ln*(Theor.rhoE*qliste./Theor.qc),'b'); hold off;
	
	
	

