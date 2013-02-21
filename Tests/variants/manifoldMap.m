function res=manifoldMap (var, source, map, destination )
names=fieldnames(var);
env=cell(length(source),1);

res=struct();

for i=1:length(names)
    n=char(names(i));
    er=1;
    for j=1:length(source)
    if strcmp(source{j},n)
        env{j}=var.(n);
        er=0;
    end
    end
    if er
        res.(n)= var.(n);
    end
end    
   newcoord=map(env);

   for j=1:length(source)
       res.(destination{j})=newcoord{j};
   end
   
end