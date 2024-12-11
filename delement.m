function [V] = delement(x,V)
%DELEMENT removes x from V
%{  
DELEMENT finds the number x in the array V 
and removes the first (if any) occurrence of x.
%}
    for i=1:length(V)
        if V(i)==x
            V(i)=[];
            return
        end
    end
end

