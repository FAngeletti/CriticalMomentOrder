function anlys=lQESieve2(alpha,beta,k)

persistent eulerGamma;
if isempty(eulerGamma)
    eulerGamma=-psi(0,1);
end



    function theta=f(pre)
       n=length(pre.tail);
    
       
       st=pre.len*alpha;     
       sr=n*beta;
       
       if(isempty(k))
           kl=exp(1.6*sqrt(pre.ln));
       else
           kl=k;
       end
       
       y=sieve(st,sr,pre,kl);
       kr=length(y);
       
       c= (Harm(kr-1)-eulerGamma);
       ac=1-c;
       c=c/(kr-1);

       w=c*ones(kr,1);
       w(kr)=ac;

       v=log(y);

        theta= pre.lnstar/sum(v.*w);
       
       
    end

anlys=@f;

end