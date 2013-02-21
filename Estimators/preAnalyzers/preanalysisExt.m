function pre=preanalysisExt(x,k)
if nargin<2
k=50;
end

[qu index]=sort(x, 'descend');
%qu=qu( 1:k);
%index=index(1:k);
qu=reshape(qu,length(x),1);
len=rankLength(qu(ceil(length(qu)/2)),x);
ln=log(length(x));

pre=struct('tail',qu, 'index',index, 'ln',ln, 'len',len);


end
