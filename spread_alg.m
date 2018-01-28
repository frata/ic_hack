%% 27 January 2018 Miroslav Gasparek
%% EpidemicaL updating algorithm
% Function for the update of the state of the  London inhabitants
% Aimed on getting the time it takes for the epidemics to reach you

% Inputs are the vectors of the states of each possible state
function [S_new,InC_new,InS_new,Rec_new,D_new] = spread_alg(adjacency,S,InC,InS,Rec,D,p_s,t_in,t_rec,p_d)

% Each row describes connection of an individual to other members
S_new = S; % Values of 0 or 1
InC_new = InC; % Vaules of 0 to t_in
InS_new = InS; % Values of 0 to t_rec
Rec_new = Rec; % Values of 0 or 1
D_new = D; % Values of 0 or 1

%% Consider the case when subject is not susceptible:
% It can be InC, InS, Rec, D
for j = 1:size(adjacency,2)
    j_S = S(j);
    j_InC = InC(j);
    j_InS = InS(j);
    if (j_S == 0 && j_InC == 0 && j_InS == 0) % Lets consider that it is Rec or D, then it does not change.
        if (D(j) == 1) % If subject is dead, subject stays dead
            S_new(j) = 0;
            InC_new(j) = 0;
            InS_new(j) = 0;
            Rec_new(j) = 0;
            D_new(j) = 1;
        elseif (Rec(j) == 1) % If subject is recovered, subject stays recovered
            S_new(j) = 0;
            InC_new(j) = 0;
            InS_new(j) = 0;
            Rec_new(j) = 1;
            D_new(j) = 0;
        end
    elseif (j_S == 0 && j_InC ~= 0 && j_InS == 0) % Now consider the case when the subject is infected and in the incubation period
        S_new(j) = 0; % It will never be susceptible again
        if (InC(j) <= t_in) % Count the value of InC
            InC_new(j) = InC(j) + 1;
            InS_new(j) = 0;
        elseif (InC(j) >= t_in) % If the incubation period elapsed, symptoms occur
            InC_new(j) = 0;
            InS_new(j) = 1;
        end
        Rec_new(j) = 0; % It is not recovered, it must first exhibit symptoms
        D_new(j) = 0; % It is not dead, it must first exhibit symptoms
    elseif (j_S == 0 && j_InC == 0 && j_InS ~= 0) % Now consider the case when the subject is in the period with symptons
        S_new(j) = 0; % It will never be susceptible again
        InC_new(j) = 0; % It will never be in the incubation period again
        if (InS(j) <= t_rec) % Count the value if InS
            r1 = rand;
            if (r1 < p_d) % Subject can die at any time during the recovery period
                InS_new(j) = 0;
                Rec_new(j) = 0;
                D_new(j) = 1;
            else
                InS_new(j) = InS(j) + 1;
                Rec_new(j) = 0;
                D_new(j) = 0;
            end
        else % If the recovery period elapsed and subject did not die, it recovered
            InS_new(j) = 0;
            Rec_new(j) = 1;
            D_new(j) = 0;
        end
    elseif (j_S == 1) % Consider the subject to be susceptible, it stays susceptible, if it is not connected to any infected user
        S_new(j) = 1; % If we do not enter the conditions, user stays susceptible by default
        InC_new(j) = 0;
        InS_new(j) = 0;
        Rec_new(j) = 0;
        D_new(j) = 0;
        for i = 1:size(adjacency,1) % Loop over the all users
            if (adjacency(j,i) == 1 && (InC(i) ~= 0 || InS(i) ~= 0)) % Case when subject is connected to another infected user, either in InC or InS
                r2 = rand;
                if (r2 < p_s) % Case when subject gets infected
                    S_new(j) = 0;
                    InC_new(j) = 1;
                    InS_new(j) = 0;
                    Rec_new(j) = 0;
                    D_new(j) = 0;
                    break; % Break out of the loop
                else % The user did not get infected
                    S_new(j) = 1; %% I AM NOT REALLY THAT SURE ABOUT THIS!!!!!!!!!!
                    InC_new(j) = 0;
                    InS_new(j) = 0;
                    Rec_new(j) = 0;
                    D_new(j) = 0;
                end
            elseif (adjacency(j,i) == 1 && InC(i) == 0 && InS(i) == 0) % Case when user is connected to another non-infected user, subject stay healthy
                S_new(j) = 1; % User does not get infected
                InC_new(j) = 0;
                InS_new(j) = 0;
                Rec_new(j) = 0;
                D_new(j) = 0;
            end
        end
        %%
    end
end
    
end