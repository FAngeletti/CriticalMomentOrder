function f=lQEReject(par)
default=struct('r',0.0075,'biais',0,'k',3);
m=mask(default,par);
   
    function theta=estim(pre)

     k=m.k; biais=m.biais;tau=pre.tau; r=m.r;
     n=floor(exp(pre.ln));
    seuil=r*n*tau;
    

        persistent eulerGamma;
        if isempty(eulerGamma)
            eulerGamma=-psi(0,1);
        end

        c= (Harm(k-1)-eulerGamma);
        if (biais)
            c=c/k;
        else
            if k~=1 
                c=c/(k-1);
            else
                c=0;
            end
        end
     
    ac=1-(k-1)*c;

    
    w=c*ones(k,1);
    w(k)=ac;

    v=zeros(k,1);
   
    q=pre.tail;
    ind=pre.index;
    v(1)=log(q(1));
    i=ind(1);
    ct=1;
    pos=1;
    
    while( ct ~=k)
        pos=pos+1;
        if (abs(ind(pos)-i)>seuil)
            ct=ct+1;
            v(ct)=log(q(pos));   
            i=ind(pos);
        end
    end
    theta= pre.ln/sum(v.*w);
    end
f=@estim;
end
