function f=functionSemanticTest()
counter=0;
    function incr()
        counter=counter+1
    end

f=@incr;
end