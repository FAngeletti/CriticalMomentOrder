function res=genVariants(v)
nmode=v{2};
Law=v{1};
n=v{3};
r=v{4};
rhos=v{5};
taus=v{6};
switch nmode
case 'nBytau'
mode=1;
case 'tau'
mode=0;
otherwise
mode=0;
end


if mode==0
T=struct('law',Law,'rho',rhos,'ln',log(n),'r',r,'tau',taus);
V=variants(T);
else 
T=struct('law',Law,'rho',rhos,'nBytau',n,'r',r,'tau',taus);

y=variants(T);

V=cellmap( @(s) manifoldMap( s, {'tau','nBytau'},@mmap,{'ln','tau'}), y );


end

res={T,V};
end

function res=mmap(v)
res={log(v{1}*v{2}), v{1} };
end
