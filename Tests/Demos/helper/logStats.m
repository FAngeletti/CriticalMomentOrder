function void=logStats(v)
void=[];
dyn=v{2};
templ=v{1};

nvars=vectorFieldNames(templ);
var=templ.(nvars{1});
taus=templ.(nvars{2});
mat=dyn.matrice();
sVar=length(var);
sTaus=length(taus);

n=fieldnames(mat{1,1});

for i=1:length(n)
   fname=char(n(i));
for met=1:length(mat{1,1}.(fname))
    s=sprintf('data/%s_%d.data',fname,met);
   f=fopen(s,'w');
   fprintf(f, '#%s, Theor', nvars{1});
   for k=1:sTaus
      fprintf(f,', $\\tau=%f $, std ', taus(k));
   end
   fprintf(f,'\n');
   for j=1:sVar
      fprintf(f,'%f ', var(j));
      
      stat=mat{j,1}.(fname){met};
      fprintf(f,'%f ', stat.theorie);
      
      for k=1:sTaus
      stat=mat{j,k}.(fname){met};
      fprintf(f,'%f %f ', stat.mean,sqrt(stat.variance));
      
      end
      fprintf(f,'\n');
       
   end
   
   
   fclose(f);
end
end


end
