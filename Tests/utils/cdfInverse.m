function inv=cdfInverse(cdf,ccdf, n, destim, cestim)
% Create an inverse function for f with an associated memoization table
% n is the size of the memoization table
% n must be of the form 2*(2^r+1)
% for now the law is supposed positive

%Memoization table
table=cell(2);
table{1}=zeros(n/2,1);
table{2}=zeros(n/2,1);

fun=cell(2);
fun{1}=cdf;
fun{2}=ccdf;

nT=n/2;
deep=log2(nT-1);


% Arborescent construction of the table    

%Higher level optimisation
i=nT; pos=i/n;
table{1}(i)= fzero( @(x) cdf(x) -pos, destim(pos) );
table{2}(i)= fzero( @(x) ccdf(x) -pos, cestim(pos) );

i=1; pos=i/n;
table{1}(i)= fzero( @(x) cdf(x) -pos, destim(pos) );
table{2}(i)= fzero( @(x) ccdf(x) -pos, cestim(pos) );



stride=nT-1; 
            for level=1:deep     
            for i=1:stride:(nT-stride)
                ir=(2*i+stride)/2;
                pos=ir/n;
                
       
                table{1}(ir)= fzero( @(x) cdf(x) -pos, [table{1}(i) table{1}(i+stride)] );
                table{2}(ir)= fzero( @(x) ccdf(x) -pos, [table{2}(i) table{2}(i+stride)] );
                 
            end
            stride=stride/2;
            end
           
% Interpolation function
interpol=cell(2);            
interpol{1}=interp1((1:nT)./n, table{1},'spline','pp');
interpol{2}=interp1((1:nT)./n, table{2},'spline','pp');

    function x=fInv(y)
        
       
       if y>0.5
         y=1-y;
         type=2;
       else
           type=1;
       end
       
       y0=ppval(interpol{type},y);
       pos=floor(n*y);
       if pos==0 
           sup=table{type}(1);
           if type==2
    %           x=fzero(@(x) fun{2}(x)-y, sup);
                x=fzero(@(x) fun{2}(x)-y, y0);
           else
          %      x=fzero(@(x) fun{1}(x)-y, [0 sup]);
               test=fun{type}(y0)<y ;
               if test
                  x=fzero(@(x) fun{1}(x)-y, [y0 sup]);
               else 
                   x=fzero(@(x) fun{1}(x)-y, [0 y0]);
               end
           end
       else
           test=fun{type}(y0)<y ;
           
           inf=table{type}(pos);
           sup=table{type}(pos+1);
         %   x=fzero(@(x) fun{type}(x)-y, [inf sup] );
           if test
               x=fzero(@(x) fun{type}(x)-y, [y0 sup] );
           else
               x=fzero(@(x) fun{type}(x)-y, [inf y0] );
           end
       end
    end
inv=@fInv;
end