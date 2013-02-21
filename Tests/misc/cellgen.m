function C= cellgen( f, sh, extended )
%cellgen(f,sh) Create a cell C of shape sh, where C{i}=f(i); 
% if extended==true or not defined the arguments of f are extented, i.e f must be a n-ary function
% otherwise, the position cell is directly to f

if (nargin<3)
	extended=true;
end

dim=length(sh);
if(dim==1)
    C=cell(dim,1);
else
    C=cell(sh);
end

indice=init(dim);

len =prod(sh);

if (extended==true)
for i=1:len
    C{indice{:}}=f(indice{:});
    indice=incr(sh,indice);
end
else
for i=1:len
    C{indice{:}}=f(indice);
    indice=incr(sh,indice);
end
end

end

function c=init(dim)

c=cell(1,dim);

for i=1:dim
    c{i}=1;
end

end

function v=incr(sh,indice)
    v=indice;
    v{1}=v{1}+1;
    i=1;
    dim=length(sh);
    while(i < dim && v{i}>sh(i) )
        v{i}=1; v{i+1}=v{i+1}+1; i=i+1;
    end

    
end

