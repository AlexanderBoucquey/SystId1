clear all
close all
sigma_i0 = 0.1;
sigma_ni = 0.1;
sigma_nu = 1;
R_0 = 1000;
N = 5000;
fgen = 0.1;
exper = 1000;
figure;
k = 2;
for fnoise = [0.999,0.95,0.6]
    for j=1:exper
        e1 = randn(N,1);
        [bgen,agen] = butter(1,fgen);
        i0(:,k) = (sigma_i0)*filter(bgen,agen,e1/std(filter(bgen,agen,e1)));

        e2 = randn(N,1);
        [bnoise,anoise] = butter(2,fnoise);
        ni(:,k) = (sigma_ni )* filter(bnoise, anoise, e2/std(filter(bnoise, anoise, e2)));
        nu = rand(N,1);
        nu = (sigma_nu )*nu/std(nu);

        i = i0(:,k) + ni(:,k);
        u = i0(:,k)*R_0 + nu;
        s = 1;
        R_LS(j) = sum(u.*i)/sum(i.^2);
        R_IV(j) = sum(u.*circshift(i,s))/sum(i.*circshift(i,s));
    end
   
    
    hold on 
   % bar(w,h_LS);
   
   histogram(R_LS,30,'Displaystyle','stairs','Normalization','pdf');
   histogram(R_IV,30,'Displaystyle','stairs','Normalization','pdf');
   
   
   %histogram(R_LS;
   % histfit(R_LS);
    k = k+1;
end
axis([0 1500 0 0.1]);
ylabel('PDF(R)'),xlabel('R');
title('experiment 1 for different fnoise');
legend('LS(0.999)','IV(0.999)','LS(0.95)','IV(0.95)','LS(0.6)','IV(0.6)');
hold off

fgen = 0.1;
exper = 1000;
fnoise = 0.6;
figure;
for s = [1 2 5 ]
    for j=1:exper
        e1 = randn(N,1);
        [bgen,agen] = butter(1,fgen);
        i0(:,1) = (sigma_i0)*filter(bgen,agen,e1/std(filter(bgen,agen,e1)));

        e2 = randn(N,1);
        [bnoise,anoise] = butter(2,fnoise);
        ni(:,1) = (sigma_ni )* filter(bnoise, anoise, e2/std(filter(bnoise, anoise, e2)));
        nu = rand(N,1);
        nu = (sigma_nu )*nu/std(nu);

        i = i0(:,1) + ni(:,1);
        u = i0(:,1)*R_0 + nu;
 
        R_LS(j) = sum(u.*i)/sum(i.^2);
        R_IV(j) = sum(u.*circshift(i,s))/sum(i.*circshift(i,s));
    end
   
    
    hold on 
   % bar(w,h_LS);
   if(s==1)
    histogram(R_LS,30,'Displaystyle','stairs','Normalization','pdf');
   end
   histogram(R_IV,30,'Displaystyle','stairs','Normalization','pdf');
   
   
   %histogram(R_LS;
   % histfit(R_LS);
    
end
axis([0 1500 0 0.1]);
ylabel('PDF(R)'),xlabel('R');
title('experiment 2 for different s');
legend('LS','IV(1)','IV(2)','IV(5)');
hold off

[N,M] = size(i0);
for i=2:4
    
   [i0corr,i0lag] = xcorr(i0(:,i));
   [nicorr,nilag] = xcorr(ni(:,i));
  
   figure
   hold on
   plot(i0lag(N:N+10),i0corr(N:N+10).*var(i0(:,i))./i0corr(N)),xlabel('Lag'),ylabel('Auto-correlation');
   plot(nilag(N:N+10),nicorr(N:N+10).*var(ni(:,i))./nicorr(N)),xlabel('Lag'),ylabel('Auto-correlation');

  hold off
end

%%
for fnoise = [0.999,0.95,0.6]
    
    
 [bgen,agen] = butter(1,fgen);
 [bnoise,anoise] = butter(2,fnoise);
 figure
 
 [h1,w1] = freqz(bgen,agen,N);
 plot(w1/pi/2,db(h1),'.-')
 hold on
 %figure
 [h2,w2] = freqz(bnoise,anoise,N);
 plot(w2/pi/2,db(h2),'.-')
 ylim([-30 10]),xlim([0 0.5]);
 xlabel('f/fs'),ylabel('Filter [dB]');
 hold off
end