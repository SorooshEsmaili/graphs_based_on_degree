function [] = stage2()
%% initialization
%{
Each instance has three properties:
    A is the current adj. matrix
    V is the remaining vertex degrees
    i represents the current vertex to get a degree
    when i=n, A is complete
main.m runs this algorithm until all A are complete or discarded. In other
words, until Stack is empty.
%}
    global n Stack last_index_of_stack AcceptedStack Next_index_of_accepted_stack V
    instance=Stack{last_index_of_stack}; % pick the last instance to process
    Stack(last_index_of_stack)=[]; % remove last element of stack
    V_Star=unique(instance.V); % available degrees for the next vertex     
%% Implementation
    for p1=1:length(V_Star) % pick which degree is next vertex gonna get 
        added_degree=V_Star(p1)-sum(instance.A(instance.i,:)); %how much will the next vertex degree increase
        if added_degree<0 % contradiction
            continue % terminate computation
        else % we may have multiple instances for the chosen degree
            %% divide and conquer
            %{
            First, we partition a segment of A to see how many slots we
            have for incrementing degrees, if we have less slots than
            added_degree, we can't move forward, otherwise, we have nCk
            choices as to where increments happen, where:
                n is the number of cols in A_partition (not the global n)
                k is the added_degree
            We create A for every possible outcome, then we compare and
            remove repetitions.
            %}
            Ap=instance.A([1:instance.i-1],[instance.i+1:n]); %  A_partition
            if size(Ap,2)<added_degree % contradiction
                continue  % terminate computation
            end
            combs=nchoosek(1:size(Ap,2),added_degree);
            nCk=size(combs,1);
            nums=zeros(nCk,size(Ap,2));
            ins=cell(2,nCk);
            for x=1:nCk
                repeated=0;
                nums(x,combs(x,:))=1;
                temp1=[Ap;nums(x,:)];
                temp2=unique(temp1','rows')';
                for y=1:x-1
                    try
                        if all(temp2==ins{2,y},'all')
                            repeated=1;
                            break
                        end
                    catch
                    end
                end
                if ~repeated
                    ins{1,x}=temp1;
                    ins{2,x}=temp2;
                end
            end
            %{
                now, we have all possible ways of distributing added_degree
                for the chosen degree. so we 
                %}
            %% Combine
             for x=1:size(ins,2)
                 if size(ins{1,x})~=[0 0] % if not repeated
                     % create a new instance for inserting into a stack
                     newins.A=instance.A;
                     newins.A([1:instance.i],[instance.i+1:n])=ins{1,x};
                     newins.A([instance.i+1:n],[1:instance.i])=ins{1,x}';
                     newins.V=delement(V_Star(p1),instance.V);  
                     newins.i=instance.i+1;
                     if newins.i==n % if A is completed...
                         try % ... and has no contradictions, add it to AcceptedStack
                             mustBeNonnegative(V-sort(sum(newins.A),'descend'))
                            AcceptedStack{Next_index_of_accepted_stack}=newins;
                            Next_index_of_accepted_stack=Next_index_of_accepted_stack+1;
                         catch 
                         end
                     else % if A is not completed, add it to Stack
                         Stack{last_index_of_stack}=newins;
                         last_index_of_stack=last_index_of_stack+1;
                     end
                 end
             end
        end
    end
    last_index_of_stack=last_index_of_stack-1; % QoL
end

