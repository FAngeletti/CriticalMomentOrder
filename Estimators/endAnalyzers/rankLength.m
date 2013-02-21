function l = rankLength(seuil, vx )

l=0;
s=0;
n=0;


for i=1:length(vx)
x=vx(i);
    if(x>=seuil)
        l=l+1;
    else if((x<seuil) && (l>0))
        s=s+l; n=n+1; l=0;
        end
    end
            
end

l=s/n;

end

