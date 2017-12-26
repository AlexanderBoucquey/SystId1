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
B = D(:,1);
A = G(1:end-1,:)\G(2:end,:);
%zie slides vanaf 300
x(:,1) = B;
y2(1) = C*B;
for k=2:21
    x(:,k) = A*x(:,k-1);
    y2(k) = C*x(:,k);


end
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


for i=1:8
        for j=1:8
            H2(i,j) = periode(i+j-1);
            
        end
end

[U2,S2,V2] = svd(H2);
G2 = U2(:,1:7)*S2(1:7,1:7)^(1/2);
D2 = S2(1:7,1:7)^(1/2)*(V2(:,1:7)');
C2 = U2(:,1:7)*S2(1:7,1:7)^(1/2);
C2 = C2(1,:);
B2 = D2(:,1);
A2 = G2(1:end-1,:)\G2(2:end,:);
lambda = eig(A2);
%zie slides vanaf 300
x2(:,1) = B2;
y3(1) = C2*B2;
for k=2:1001
    x2(:,k) = A2*x2(:,k-1);
    y3(k) = C2*x2(:,k);


end

