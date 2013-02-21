classdef Law
   properties 
       rvGen
       infoF
   end
   methods
       function obj=Law(gen,info)
           obj.rvGen=gen;
           obj.infoF=info;
       end
       function r=rv(obj,p)
           r=obj.rvGen(p);
       end
       function inf=info(obj,p)
           inf=obj.infoF(p);
       end
   end
end

