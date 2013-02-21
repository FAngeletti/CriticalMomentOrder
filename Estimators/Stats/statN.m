classdef statN < handle
    properties
        moments
        order
	valTheor
        n
    end
    methods
        function obj=statN(order,theor)
            obj.n=0;
            obj.order=order;
            obj.moments=zeros(1,order);
	    if (nargin>=2)
	    obj.valTheor=theor;
	    end
        end
	
        function res=mean(obj)
            res=obj.moments(1)/obj.n;
        end
	
        function res=variance(obj)
            res=obj.moments(2)/obj.n - obj.mean()^2;
        end
	
	function res=biais(obj)
	 res=obj.valTheor-obj.moyenne;
	end
	
	
	function res=theorie(obj)
		res=obj.valTheor;
	end
	
	function res=eqm(obj)
		res=(obj.valTheor-obj.moyenne).^2 + obj.variance;
	end

        function plus(obj,x)
           
            for i=1:length(obj)
            e=obj(i);
            y=x(i);
            e.n=1.+e.n;
            e.moments= e.moments+y.^(1:length(e.moments));
            end
        end
	
    end
end
        
