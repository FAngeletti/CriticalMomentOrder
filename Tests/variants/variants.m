function var=variants(template)
names=vectorFieldNames(template);
vect=cellfun( @(n) template.(n),names, 'UniformOutput',0 );

svect=zeros(1,length(vect));
for i=1:length(vect)
   svect(i)=length(vect{i}); 
end

f= @(v) injectS(template,names,access(vect,v));

var=cellgen(f,svect,false);
end

function x=access( vs, p)

x=zeros(length(vs),1);    
for i=1:length(vs)
x(i)=vs{i}(p{i});
end
end
