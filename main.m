clear
clc
%% Stage 1
%{
    Ask for V
    check if V is valid
    Show error and ask for V again if not
%}
global V %sequence of vertice degrees
while 1
    V=input('V?'); % input V
    % check to see if V is valid and if yes, separate isolated vertices
    [check,E,V,isolates]=isValidGraphSet(V); 
    if check % is V valid?
        break
    end % if not, display appropriate error message
    fprintf('Error! The array of vertice degrees %s\n',E)
end
%% Stage 2
%{
First, we check if we have the empty gragh.
If not, we set the 1st row,col of A since it's independent.
Check to see if we're done.
If not, use stage2 divide-and-conquer algorithm along with stacks to find
suitable A matrices.
%}
clear E check
if isempty(V) % is V the empty graph?
    fprintf('empty Graph with %d nodes\nA=\n',isolates);
    disp(zeros(isolates))
    return
end
global n Stack last_index_of_stack AcceptedStack Next_index_of_accepted_stack
%{
n is the size of the graph (without isolated vertices)
Stack is the stack of matrices that need processing
AcceptedStack is the stack of completed matrices (results)
%}
n=length(V); % initialize n
A=zeros(n); % initialize A
A(1,[2:V(1)+1])=1;A([2:V(1)+1],1)=1; % 1st row,col of A
if V==sum(A) % are we done?
    fprintf('A=\n');
    A(n+isolates,n+isolates)=0; % adding isolated vertices
    disp(A)
    return
end
% if not... 1st instance (matrix in need of processing) is...
instance.A=A;
instance.V=V([2:n]); % since the 1st element is already implemented
instance.i=2; % the ith vertex needs degree
% initializing stacks
last_index_of_stack=1;
Stack{last_index_of_stack}=instance; 
AcceptedStack=cell(0);
Next_index_of_accepted_stack=1; 
% beginning stage2 algorithm until Stack is empty
while last_index_of_stack
        stage2
end
%% Stage 3
%{
Now we have all the answers, but some may have been repeated and in any
case, we must add the isolated vertices we removed in stage 1. So,
basically, this stage is just the finishing touch.
%}
clear A instance last_index_of_stack Stack Next_index_of_accepted_stack V

