function masked=mask(default, x)
masked=default;
names=fieldnames(default);
for i=1:length(names)
    n=char(names(i));
if (isfield(x,n)==1 )
    masked.(n)=x.(n);
end
end