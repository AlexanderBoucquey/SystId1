clear all
close all
k=19;
y = linspace(1,k,k);
for i=1:ceil(k/2)
    for j=1:ceil(k/2)
        H(i,j) = y(i+j-1);
    end
end
[U,S,V] = svd(H);
G = U(:,1:2)*S(1:2,1:2)^(1/2);
D = S(1:2,1:2)^(1/2)*(V(:,1:2)');
C = U(:,1:2)*S(1:2,1:2)^(1/2);
C = C(1,:);
%zie slides vanaf 300

error= H-G*D;
