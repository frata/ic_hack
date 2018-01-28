%% 27 January 2018 Miroslav Gasparek
% EpidemicaL average time of reach
% Function that calculates the average time requried to infect the subject

function threat_time = time_to_ill_func(adjacency,p_s,p_d,t_in,t_rec,n_it,n_runs,user_pos,unhealthy)
%% Set the initial parameters
% Check the initial time of simulation

% Choose the transmission probability, p_s
% Choose the mortality probability, p_d
% Choose the incubation period (days), t_in
% Choose the recovery period t_rec (days), = 14
% Number of iterations (days), n_it = 1000;
% Number of runs, n_runs = 100;
% Adjacency matrix, adjacency
% Your position, user_pos
% Unhealthy position, unhealthy
% Initialize the matrix of steady state times
t_min = zeros(1,n_runs);

%% Insert the adjacency matrix
% adjacency = Undirected_ErdosRenyi(N,0.054);
% Select your index
% The position of the user in the adjacency matrix
% Select the index of the unhealthy patient
% Select a subject from the network that is ill, this depends on the
% position of the patient in the network

%% Run the loop
for j = 1:n_runs
    % Initialize the population as healthy (No infection, no deads, no recovery)
    S = ones(1,N,'logical');
    InC = zeros(1,N,'uint8');
    InS = zeros(1,N,'uint8');
    Rec = zeros(1,N,'logical');
    D = zeros(1,N,'logical');
    
    % Initialize the unhealthy patient
    InC(unhealthy) = 1;
    
    % Initialize the initial vectors for states
    S_new = S;
    InC_new = InC;
    InS_new = InS;
    Rec_new = Rec;
    D_new = D;
    % Initialize the matrix of the total population counts
    susceptible_count = zeros(1,n_it);
    infected_count = zeros(1,n_it);
    dead_count = zeros(1,n_it,'uint8');
    immune_count = zeros(1,n_it,'uint8');
    % Initialize the time till user gets infected
    t_inf = zeros(1,n_it);
    
    for q = 1:n_it
        S_prev = S_new;
        InC_prev = InC_new;
        InS_prev = InC_new;
        Rec_prev = Rec_new;
        D_prev = D_new;
        [S_new,InC_new,InS_new,Rec_new,D_new] = spread_alg(adjacency,S_new,InC_new,InS_new,Rec_new,D_new,p_s,t_in,t_rec,p_d);
        if( InC_new(user_pos) ~= 0) % Find out when user becomes infected
            t_inf(q) = q;
            
        end
        % Count up susceptible
        S_count(q) = sum(S_new);
        % Count up those in incubation period
        l = find(InC_new ~= 0);
        InC_new_norm = InC_new;
        InC_new_norm(l) = 1;
        InC_count(q) = sum(InC_new_norm);
        % Count up those in incubation period
        k = find(InS_new ~= 0);
        InS_new_norm = InS_new;
        InS_new_norm(k) = 1;
        InS_count(q) = sum(InS_new_norm);
        % Count up recovered
        Rec_count(q) = sum(Rec_new);
        % Count up dead
        D_count(q) = sum(D_new);
    end
    %% Time to getting infected (start of incubation period)
    if any(t_inf) == 0
        t_inf_min(j) = n_it + 1;
    else
        t_inf_min(j) = min(t_inf(t_inf>0));
    end
    % Total counts of susceptible, incubation period, patients with symptoms, recovered and dead for each run
    S_f(j) = S_count(q);
    InC_f(j) = InC_count(q);
    InS_f(j) = InS_count(q);
    Rec_f(j) = Rec_count(q);
    D_f(j) = D_count(q);
end
%%

% Average final counts of susceptible, incubation period, patients with symptoms, recovered and dead for each run
S_avg = sum(S_f)/n_runs;
InC_avg = sum(InC_f)/n_runs;
InS_avg = sum(InS_f)/n_runs;
Rec_avg = sum(Rec_f)/n_runs;
D_avg = sum(D_f)/n_runs;

% Average time to becoming infected
t_inf_avg = sum(t_inf_min)/size(t_min,2);

% disp(['Time to becoming infected: ',num2str(t_inf_avg),' days'])
% % Display the population distribution
% disp(['Total average population distribution:',...
%     newline,'Number of susceptible patients: ',num2str(round(S_avg)),...
%     newline,'Number of patients in the incubation period: ',num2str(round(InC_avg)),...
%     newline,'Number of patients with symptoms: ',num2str(round(InS_avg)),...
%     newline,'Number of recovered patients: ',num2str(round(Rec_avg)),...
%     newline,'Number of dead patients: ',num2str(round(D_avg))])
end