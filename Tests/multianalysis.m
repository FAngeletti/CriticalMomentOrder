function f=multianalysis(set)

function st=test(var)
    	theor=var.law.info(var);
        r=var.r;
        names=fieldnames(set);
        st=struct();
        for i=1:length(names)
            n=char(names(i));
            st.(n)=cell(length(set.(n)),1);
        end

 
    for i=1:length(names)
    n=char(names(i));
        for a=1:length(set.(n))
            st.(n){a}=statN(2,theor.(n));
        end
    end

        

	for i=1:r
            
            v=var.law.rv(var);
            pre=preanalysisExt(v);
            
            pre.tau=var.tau;
            kappa=0.08;
            pre.lnstar=pre.ln -log(1+kappa*pre.tau);
            
         for j=1:length(names)
             n=char(names(j));    
	     analyzers=set.(n);
             analyzes=st.(n);
             for a=1:length(set.(n))
                  analyzes{a}+analyzers{a}(pre);
             end
             
         end
         
    
	 end
        
        
    end

f=@test;

end
