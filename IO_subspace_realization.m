clear all
close all 
Data=[0 1000 550 9.990000000000000e+02;
1 950 600 1.451547000000000e+03;
2 920 500 1.805551641000000e+03;
3 1050 1500 2.230548295923000e+03;
4 1080 750 1.787689940810769e+03;
5 900 400 2.122723010633200e+03;
6 880 800 2.628591179665100e+03;
7 1300 1200 2.716396953204095e+03;
8 950 730 2.824446144063707e+03;
9 900 990 3.052699482495898e+03;
10 1100 1000 2.971947580943385e+03;
11 860 400 3.080763423686215e+03;
12 1200 700 3.549545713957273e+03;
13 1000 850 4.059694351099145e+03;
14 990 950 4.221723434152442e+03;
15 900 1000 4.274348604454899e+03;
16 930 600 4.187271650268263e+03;
17 1000 550 4.529503465219067e+03;
18 950 600 4.992641975614724e+03;
19 920 500 5.357269901541567e+03;
20 1050 1500 5.792921711246191e+03;
21 1080 750 5.360750476379930e+03;
22 900 400 5.706502727809069e+03;
23 880 800 6.223122235992496e+03;];
for i=1:18
    for j = 1:19
        W(i,j) = Data(j+floor((i-1)/3),rem((i-1),3)+2);
    end
end
Wp = W(1:9,:);
Wf = W(10:18,:);
x = Data(4:22,4)/0.999;
a4 = Wp'\x;
b4 = Wf'\x;
test2 = Wp'*a4-Wf'*b4;
% a = ones(1,9)/3;
% 
% x = Wp'*a';
% b = Wf'\x;
% x2 = Wf'*b;
% a2 = Wp'\x2;
% x3 = Wp'*a2;
% for i=1:1000
% 
%     b = Wf'\x3;
%     x2 = Wf'*b;
%     a2 = Wp'\x2;
%     x3 = Wp'*a2; 
% end
% test = a2'*Wp;
system = [x(1:end-1) Data(4:21,2) Data(4:21,3)]\[x(2:end) Data(4:21,4)];

% [U,S,V] = svd(W);
% [Up,Sp,Vp] = svd(Wp);
% [Uf,Sf,Vf] = svd(Wf);
% [U,S,V] = svd(W);
% G = U(:,1:13)*S(1:13,1:13)^(1/2);
% D = S(1:13,1:13)^(1/2)*(V(:,1:13)');
% C = U(:,1:13)*S(1:13,1:13)^(1/2);
% C = C(1:3,:);
% B = D(:,1);
% A = G(1:end-1,:)\G(2:end,:);
% %zie slides vanaf 300
% x(:,1) = B;
% y2(:,1) = C*B;
x4(1) = 1000;
y(1)= 990;
for k=2:23
    x4(k) = system(1,1)*x4(k-1) + system(2,1)*Data(k-1,2) + system(3,1)*Data(k-1,3);
    y(k) = system(1,2)*x4(k);


end

