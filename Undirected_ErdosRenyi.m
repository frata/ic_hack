%% 27 January 2018 Miroslav Gasparek
%% Generate the adjacency matrix representing undirected Erdos-Renyi network

function adj_mat = Undirected_ErdosRenyi(N,q)
tic
 % N = Number of nodes/size of the population
 % q = Probability of existence of the self edge 
adj_mat = logical(zeros(N,N));
k_bar = q*(N-1); % Average degree

for i = 1:N
    for j = (i+1):N
        t = rand;
        if (t < q)
            adj_mat(i,j) = 1;
            adj_mat(j,i) = 1;
        else
            adj_mat(i,j) = 0;
            adj_mat(j,i) = 0;
        end
    end
end

% Visualize the adjacency matrix
figure(1)
spy(adj_mat)
title('Sparsity matrix for undirected Erdos-Renyi network with no self-edges')
%%
toc
end