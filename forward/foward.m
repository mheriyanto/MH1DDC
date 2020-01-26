% Forward 1D DC Resistivity
% Reference: Ekinci Y L and Demirci A. 2008. J. of Appl. Sciences 8 (22): 4070-4078
% Modified: M. Heriyanto and W. Srigutomo. 2016. Journal of Physics: Conference Series 877 (2017) 012066.
% URL: https://github.com/mheriyanto/MH1DDC

clc; clear all; close all;

% Model 3
load Model.txt
s = Model(:,1);                                    % resistivity (Ohm-m)
r = [10,10,10];                                     % thickness (m)
t = [10,10];                                         % AB/2 (m)

for ii = 1:length(s)
q = 13;
f = 10;
m = 4.438;
x = 0;
e = exp(log(10)/(2*m));
h = 2*q-2;
u(ii) = s(ii)*exp(-f*log(10)/m-x);                 % 1/lamda
l = length(r);
n = 1;

for i = 1:n+h
    w = l;                                      % w = i (n-1 th layer)
    T = r(l);                                   % T = T(lamda)
    while(w>1)
        w = w-1;
        aa = tanh(t(w)/u(ii));              % t(w) = depth
        T = (T+r(w)*aa)/(1+T*aa/r(w));      % r = resistivity, T = T(lamda) 
    end
    a(i) = T;
    u(ii) = u(ii)*e;
end

i = 1;
rho_a = 105*a(i)-262*a(i+2)+416*a(i+4)-746*a(i+6)+1605*a(i+8);
rho_a = rho_a-4390*a(i+10)+13396*a(i+12)-27841*a(i+14);
rho_a = rho_a+16448*a(i+16)+8183*a(i+18)+2525*a(i+20);
rho_a = (rho_a+336*a(i+22)+225*a(i+24))/10000;
rho_semu(ii) = rho_a;

% add noise
% rho_semu(ii) = rho_a + 0.15*rho_a*rand();
end

rr = [0,r];
tt = [0,cumsum(t),max(t)*10];

% save data
sintetik = [s rho_semu'];
save('data.txt','sintetik','-ascii');

% plotting
figure(1)
subplot(1,6,[1 3])
loglog(s,rho_semu,'.','color','r','MarkerSize',20);
axis([10^0 10^3 10^0 10^3]);
set(gca,'XTick',[1 1e1 1e2 1e3]);
%axis tight
xlabel('AB/2 (m)','fontweight','bold','fontsize',10);
ylabel('Rho App.(Ohm.m)','fontweight','bold','fontsize',10);
title(['\bf \fontsize{12} Respons']);
grid on

subplot(1,6,[5 6])
stairs(rr,tt,'r','LineWidth',2);
set(gca,'Ydir','reverse');
set(gca,'Xscale','log');
title(['\bf \fontsize{12} Model']);
xlabel('Resistivity (Ohm.m)','fontweight','bold','fontsize',10);
ylabel('Depth (m)','fontweight','bold','fontsize',10);    
grid on
axis([10^-1 10^3 0 10^2])
set(gca,'XTick',[1 1e1 1e2]);

% save workspace matlab
print('-dpng','Forward DC Resistivity','-r500')
save ForwardDCRes.mat
