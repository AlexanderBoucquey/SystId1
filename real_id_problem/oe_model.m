function [ sysoe ] = oe_model( u, y)
% Probeer ideaal aantal parameters te berekenen mbv van het aic criterium
% Initialisatie van aantal parameters
nf = [10 20 30 40];
nb = 1:4;
nk = 0:4;

% Estimate OE models with all possible combinations of chosen order ranges.
NN = struc(nf,nb,nk); 
models = cell(size(NN,1),1);
for ct = 1:size(NN,1)
   models{ct} = oe([y u], NN(ct,:));
end
% Compute the small sample-size corrected AIC values for the models,
% and return the smallest value.
V = aic(models{:},'AICc');
[~,I] = min(V);

% Return the optimal model that has the smallest AICc value.
sysoe = models{I};

% Plot the aic criterium
figure()
plot(V);
title('oe aic criterium');


end

