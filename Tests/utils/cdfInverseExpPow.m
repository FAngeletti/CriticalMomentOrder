function inv=cdfInverseExpPow(rho, n)
% Create an inverse function for the ExpPow Laaw with an associated memoization table
% n is the size of the memoization table
% n must be of the form 2*(2^r+1)
% for now the law is supposed positive





norm=rho/gamma(1/rho);
 
table=expPowInversionTable(rho,norm,n);


           


    function x=fInv(y)
        x=expPowInversion(rho,norm,table,y);
    end

inv=@fInv;
end