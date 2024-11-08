clear
clc
%% Initial Stage
while 1
    V=input('V?');
    [check,E,V_star,isolates]=isValidGraphSet(V);
    if check 
        break
    end
    fprintf('Error! The array of vertice degrees %s\n',E)
end
%% Stage 1
