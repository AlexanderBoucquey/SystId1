clear all
close all
sigma_i0 = 0.01;
sigma_ni = 0.001;
sigma_nu = 1;
R_0 = 1000;
N = 5000;
fgen = 0.1;
exper = 1000;
figure;


for j=1:exper
    e1 = randn(N,1);

    i0(:,1) = (sigma_i0)*e1/std(e1);

    e2 = randn(N,1);

    ni(:,1) = (sigma_ni )* e2/std(e2);
    nu = rand(N,1);
    nu = (sigma_nu )*nu/std(nu);

    i = i0(:,1) + ni(:,1);
    u = i0(:,1)*R_0 + nu;
    s = 1;
    R_LS(j) = sum(u.*i)/sum(i.^2);
    R_EIV(j) = (sum(u.^2)./sigma_nu^2 -sum(i.^2)./sigma_ni^2 + sqrt((sum(u.^2)./sigma_nu^2 -sum(i.^2)./sigma_ni^2)^2 + 4*(sum(u.*i)).^2./(sigma_nu^2*sigma_ni^2)))./(2*sum(u.*i)./sigma_nu.^2);
end
   
    
   
hold on
   
histogram(R_LS,100,'Displaystyle','stairs','Normalization','pdf');
histogram(R_EIV,100,'Displaystyle','stairs','Normalization','pdf');
   
 
 

axis([950 1050 0 0.2]);
ylabel('PDF(R)'),xlabel('R');
%title('experiment 1 for different fnoise');
legend('LS','EIV');
hold off

