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
A = G(1:end-1,:)\G(2:end,:);
%zie slides vanaf 300

%x = C\y';
error= H-G*D;

periode = [ 0 5 7 8 9 6 5];
periode = repmat(periode,1,60);
d = 1;
for t= [5,6,7,8,9,10,25,50,200]
    for i=1:t
        for j=1:t
            Y(i,j,d) = periode(i+j-1);
            
        end
    end
    s(1:t,d) = svd(Y(1:t,1:t,d));
    d = d+1;
end



