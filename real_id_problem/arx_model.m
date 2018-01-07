function [ sysarx ] = arx_model( u, y )
% Probeer ideaal aantal parameters te berekenen mbv van het aic criterium
% Initialisatie van aantal parameters
na = [10 20 30 40];
nb = [10 20 30 40];
nk = [10 20 30 40];

% Estimate arx models with all possible combinations of chosen order ranges.
NN = struc(na,nb,nk); 
models = cell(size(NN,1),1);
parfor ct = 1:size(NN,1)
   models{ct} = arx([y u], NN(ct,:));
end
% Compute the small sample-size corrected AIC values for the models,
% and return the smallest value.
V = aic(models{:},'AICc');
[~,I] = min(V);

% Return the optimal model that has the smallest AICc value.
sysarx = models{I};

end

