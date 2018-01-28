%% Barnabasi-Alberts model Simulation
% Degree of a node = number of connections/edges the node has to other nodes
% Degree distribution = the probability distribution of these degrees over
    % the whole network
    % the fraction of nodes in the network with degree k
    % i.e. P(k) = n_k/n
        % n = no. of nodes
        % n_k = no. of nodes with degree k

% Parameters
n_count = 4;        % Node count; initiating number

population = 400;  % Population of students & staff at Imperial College London

% Initating all nodes to zero degree and probability
    % Information that we want for each node: index & degree
n_info = zeros(1,n_count);
    % degree of node

% Assuming that only the first 4 nodes are all connected
n_info(1,1) = 3;    % Starting degree of 3 (1--2,3,4)
n_info(1,2) = 3;    % Starting degree of 3 (2--1,3,4)
n_info(1,3) = 3;    % Starting degree of 3 (3--1,2,4)
n_info(1,4) = 3;    % Starting degree of 3 (4--1,2,3)

% Initiating adjacency matrix
adjacency = zeros(population);
adjacency(1,2) = 1;    % Linking starting nodes
adjacency(1,3) = 1;    % Linking starting nodes
adjacency(1,4) = 1;    % Linking starting nodes

adjacency(2,1) = 1;    % Linking starting nodes
adjacency(2,3) = 1;    % Linking starting nodes
adjacency(2,4) = 1;    % Linking starting nodes

adjacency(3,1) = 1;    % Linking starting nodes
adjacency(3,2) = 1;    % Linking starting nodes
adjacency(3,4) = 1;    % Linking starting nodes

adjacency(4,1) = 1;    % Linking starting nodes
adjacency(4,2) = 1;    % Linking starting nodes
adjacency(4,3) = 1;    % Linking starting nodes

% Updating adjacency matrix when adding a new node
while n_count < population
    new_edge_count = 0; % variable to hold count of new edges
    for n = 1:n_count % iterating through all current nodes
        n_prob = (n_info(1,n)*4)/sum(n_info(1,:)); % p_i = 4*k_i/sum_j(k_j)
            % ^ calculating singular probability distribution according
            % to Barnabasi Alberts model
            % multiplying by 4 because it's 4x more probable to have a
            % connection: teams of at least 4
        n_rand = rand(1);
            % ^ generating random number
        if n_rand > n_prob
            % do nothing
        else
            % increment degree for node n
            n_info(1,n) = n_info(1,n)+1;
            % hold this edge count
            new_edge_count = new_edge_count + 1;
            % update adj matrix with new node
                % Remember: adj matrix already hosts all possibly nodes
            adjacency(n,n_count+1) = 1; 
            adjacency(n_count+1,n) = 1;
        end
    end
    % append new edge count to node info table
    n_info = [n_info,new_edge_count];
    n_count = n_count + 1;  % Adding and considering a new code
end
%ward_n_info{ward} = n_info;
%ward_adj_matrix{ward} = adj_matrix;
clear n_rand new_edge_count n n_count n_prob population;
save('adj_matrix');