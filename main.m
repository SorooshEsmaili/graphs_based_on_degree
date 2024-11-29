clear
clc
%% Initial Stage
%{
    Ask for V
    check if V is valid
    Show error and ask for V again if not
%}
while 1
    V=input('V?');
    [check,E,V,isolates]=isValidGraphSet(V);
    if check 
        break
    end
    fprintf('Error! The array of vertice degrees %s\n',E)
end
%% Stage 1
clear E
if isempty(V) % is V the empty graph?
    fprintf('tohi\n');
    return
end
global n Stack last_index_of_stack AcceptedStack Next_index_of_accepted_stack
n=length(V);
A=zeros(n);
A(1,[2:V(1)+1])=1;A([2:V(1)+1],1)=1;
if V==sum(A)
    fprintf('done!\n');
    return
end
V(1)=[];
instance.A=A;
instance.V=V;
instance.i=2;
last_index_of_stack=1;
Stack{last_index_of_stack}=instance;
AcceptedStack=cell(0);
Next_index_of_accepted_stack=1;

while last_index_of_stack % see if stack is empty
        stage2
end