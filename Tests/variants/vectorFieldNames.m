function names=vectorFieldNames(s)

t=fieldnames(s);
names={};

for i=1:length(t)
n={char(t(i))};
if  ~isscalar(s.(n{1}) )  
	names= [names n];
end


end
