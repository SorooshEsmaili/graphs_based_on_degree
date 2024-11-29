function [] = stage2()
    global n Stack last_index_of_stack AcceptedStack Next_index_of_accepted_stack
    instance=Stack{last_index_of_stack}; % pick the last instance to process
    tempStack=cell(0); % temporary stack
    x=1; % next stack index
    V_Star=unique(instance.V); % available degrees for the next vertix
    % pick which degree is next vertex gonna get 
    for p1=1:length(V_Star)
        newins=instance; %copy instance
        added_degree=V_Star(p1)-sum(newins.A(newins.i,:)); %how much will the ith vertex degree increase
        if added_degree==0 % vi already has the degree
            newins.i=newins.i+1;
            % see if other vertices contradict V or not                
            try
                mustBeNonnegative(V_Star-sum(newins.A(:,[newins.i:n])))
            catch
                continue
            end
            if newins.i==n % is A completed?
                AcceptedStack{Next_index_of_accepted_stack}=newins;
                Next_index_of_accepted_stack=Next_index_of_accepted_stack+1;
                continue
            end
            % remove V*(p1) from newins.V
            for p2=p1:length(newins.V)
                if newins.V(p2)==V_Star(p1)
                    newins.V(p2)=[];
                    break
                end
            end
            tempStack{x}=newins;
            x=x+1;
        elseif added_degree<0 % contradiction
            continue
        else % we may have multiple instances for the chosen degree
            % UNDER DEVELOPENEMT
            
            % unique columns
            %Ap=unique(A([1:i-1],[i+1:n])','rows')'
        end
    end
    Stack(last_index_of_stack)=[]; % remove last element of stack
    % add tempstack to stack
    for pp=1:length(tempStack)
        Stack{last_index_of_stack}=tempStack{pp};
        last_index_of_stack=last_index_of_stack+1;
    end
    last_index_of_stack=last_index_of_stack-1;
end

