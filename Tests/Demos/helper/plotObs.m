function void=plotObs(v)
void=[];
nmode=v{4};
data=v{3};
obs=v{1};
nAnlys=v{2};
template=v{5};
rescaling=v{6};

switch nmode
case 'eqm'
mode=0;
case 'simple'
mode=1;
    case 'eqmr'
        mode=2;

otherwise
mode=1;
end

nvar=vectorFieldNames(template);
var=template.(nvar{1});


stats=cellmap(@(s) s.(obs){nAnlys}, data);

Dtheor=cellmap(@(s) s.theorie, stats);
Dv=cellmap(@(s) s.variance, stats);
Dm=cellmap(@(s) s.mean, stats);

theor=cell2mat(Dtheor);
v=cell2mat(Dv);
m=cell2mat(Dm);


if mode==1
%vtheor=0;
vtheor=theor(:,1);
else
vtheor=0;
end
plot(var, vtheor)

if rescaling
    xlabel( 'ln n *');
else
xlabel('ln n');
end
switch obs
    case 'qc'
ylabel('q_c');
    case 'rhoE'
ylabel('\rho_E');
    case 'theta'
        ylabel('\theta');
end


hold all

for k=1:length(template.tau)
if(rescaling)
    varE=var-log(1+0.08*template.tau(k));
else
    varE=var;
end
    
	if mode==1
		errorbar(varE+0.02*(k-1),m(:,k),sqrt(v(:,k)));
    else
        if mode==0
		plot(varE, sqrt((m(:,k)-theor(:,k)).^2+v(:,k)) );
        else
        plot(varE, sqrt((m(:,k)-theor(:,k)).^2+v(:,k))./theor(:,k) );  
        end
	end

end
hold off;
grid on;
end

