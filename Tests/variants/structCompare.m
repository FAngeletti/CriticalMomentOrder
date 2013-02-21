function bool=structCompare(s,t)
bool=1; i=1;

f=fieldnames(s);
fl=fieldnames(t);
n=length(f);

if n~= length(fl)
    bool=false;
else
    while (bool==1 && i<=n)
        cf=char(f(i)); cfl=char(fl(i)); 
        if  length(cf) ~= length(cfl) || any( cf ~= cfl) ||  ( s.(cf) ~=t.(cfl) )
            bool=0;
        end
        i=i+1;
    end
end

end