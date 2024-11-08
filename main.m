clear
clc
%% Initial Stage
while 1
    V=input('V?');
    [check,E,V,isolates]=isValidGraphSet(V);
    if check 
        break
    end
    fprintf('Error! The array of vertice degrees %s\n',E)
end
%% Stage 1
if isempty(V)
    fprintf('tohi\n');
    return
end
n=length(V);
A=zeros(n);
A(1,[2:V(1)+1])=1;A([2:V(1)+1],1)=1;
if V==sum(A)
    fprintf('done!\n');
    return
end
V(1)=[];