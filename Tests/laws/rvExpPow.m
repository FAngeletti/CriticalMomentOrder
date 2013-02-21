% Code inspire de gsl/randist/expow => sous licence gpl?
function v=rvExpPow(s)
default=struct('rho',2,'ln',0, 'scale',1, 'symmetric', 0);
m=mask(default,s);

r=m.rho;
n=floor(exp(m.ln));

% If rho <1 or rho>4, the pdf cannot be approched by the gaussian or the
% exponential pdf in the rejection algorithm, so we use directly the
% inverse cumulative function.
if (r<1 || r>4)
    v=gamrnd(1/r,1,n,1);
    v=(2*unidrnd(2,n,1)-3).*v.^(1/r);
%If 1<rho<2, we apply the rejection algorithm with an exponential law as a
%initial guess.
elseif r<2
    k=0;
    l=(1/r)^(1/r);
    v=[];
    while(k<n)
        x=exprnd(l,n,1);
        if m.symmetric
        x=(2*unidrnd(2,n,1)-3).*x;
        end
        u=rand(n,1);
        i=find(-abs(x).^r+abs(x)./l+1/r-1>log(u),n- k);
        v=vertcat(v,x(i));
        k=k+length(i);
    end
% This is a gaussian    
elseif r==2
    v=1/sqrt(2) .* randn(n,1);
    if ~m.symmetric
        v=abs(v);
    end
%If 1<rho<2, we apply the rejection algorithm with an normal law as a
%initial guess.  
else 
    k=0;
    s=(1/r)^(1/r);
    v=[];
    while(k<n)
        x=s*randn(n,1);
        u=rand(n,1);
        i=find(-abs(x).^r+x.*x/(2*s*s)+1/r-0.5>log(u),n- k);
        v=vertcat(v,x(i));
        k=k+length(i);
    end
    if ~m.symmetric
        v=abs(v);
    end
end
v=m.scale*v;
end
