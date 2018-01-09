function [ sysbj ] = bj_model( u, y )
% Probeer ideaal aantal parameters te berekenen mbv van het aic criterium
% Initialisatie van aantal parameters
nb = [10 20 30 40];
nc = [10 20 30 40];
nd = [10 20 30 40];
nf = [10 20 30 40];
nk = [0 10 20 30 40];

% Estimate BJ models with all possible combinations of chosen order ranges.
NN = struc(nb,nc,nd,nf,nk); 
models = cell(size(NN,1),1);
parfor ct = 1:size(NN,1)
   models{ct} = bj([y u], NN(ct,:), 10, 0);
end
% Compute the small sample-size corrected AIC values for the models,
% and return the smallest value.
V = aic(models{:},'AICc');
[~,I] = min(V);

% Return the optimal model that has the smallest AICc value.
sysbj = models{I};

end

