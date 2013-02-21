function res=genVariantsH(v)

Law=v{1};
n=v{2};
r=v{3};
rhos=v{4};
hs=v{5};


T=struct('law',Law,'rho',rhos,'ln',log(n),'r',r,'h',hs);
V=variants(T);

res={T,V};
end
