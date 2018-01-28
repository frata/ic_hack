%% 27 January 2018 Miroslav Gasparek
% EpidemicaL starting function
% Function that patient uses to get the action

%% To be finished!!!
clear; clc; close all;
%% Pick the Department
disp(['Select department: ',newline])
disp(['1) Aeronautics: ',newline])
disp(['2) Bioengineering: ',newline])
disp(['3) Chemical Engineering: ',newline])
disp(['4) Civil and Environmental Engineering: ',newline])
disp(['5) Computing: ',newline])
disp(['6) Dyson school of engineering: ',newline])
disp(['7) Earth Science and Engineering: ',newline])
disp(['8) Electrical and Electronic Engineering: ',newline])
disp(['9) Materials: ',newline])
disp(['10) Mechanical Engineering: ',newline])
prompt1 = ['Enter the number of your department: ',newline];
x = input(prompt1);

if x == 1
    disp('Aeronautics selected!')
elseif x == 2
    disp('Bioengineering selected!')
end

prompt2 = ['Enter the number of department with outbreak: ',newline];
y = input(prompt2);
if y == 3
    disp('Chemical Engineering selected!')
elseif y == 4
    disp('Civil and Environmental Engineering selected!')
end

adjacency = Undirected_ErdosRenyi(10,0.2);

risk_func(adjacency,p_s,p_d,t_in,t_rec,n_it,n_runs,x,unhealthy)