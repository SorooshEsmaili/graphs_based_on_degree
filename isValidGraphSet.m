function [check,E,V_star,isolates] =isValidGraphSet(V)
    check=false; 
    E=''; 
    V_star=[];
    isolates=0; 
    
    try % V only has positive integers
        mustBeInteger(V), mustBeNonnegative(V)
    catch
        E='must contain only positive integers!';
        return
    end
    try % V is not empty
        mustBeNonNan(V), mustBeNonempty(V)
    catch
        E='must not be empty!';
        return
    end
    try % V is finite
         mustBeFinite(V)
    catch
        E='must be finite!';
        return
    end
    if rem(sum(V),2) % q is even
        E='adds up to an odd amount!';
        return
    end
    isolates=sum(V==0);
    V_star=sort(V(V~=0),'descend');
    if sum(V_star>=length(V_star)) % deg(v_i)<n
        E='may have a degree larger than the possible amount!';
        return
    end
    check=true;
end

