function [rms_error,iteration] = plot_iterasi(m,roacal,iteration)
%PLOT_AFTER Summary of this function goes here
%   Detailed explanation goes here
global x;
global roa;
global modelr;
global modelt;

global lr;
global lt;

figure(2)
subplot(1,6,[1 3])
hold off
loglog(x,roa,'.','color','r','MarkerSize',15);
hold on
loglog(x,roacal,'-','color','b','LineWidth',2);
set(gca,'XTick',[1 1e1 1e2 1e3]);
grid on
axis tight
xlabel('\bf \fontsize{10}\fontname{Times}AB/2(m)');
ylabel('\bf \fontsize{10}\fontname{Times}Rho App.(Ohm.m)');
rms_error = norm(roacal-roa)/sqrt(length(roa));
title(['\bf \fontsize{12}\fontname{Times}RESPONS - SVD || RMS : ', num2str(rms_error),' || iter : ', num2str(iteration)]);
leg = legend('rho app obs','rho app cal'); set(leg,'Location','South','fontsize',8);
pause(0.001)
    
format bank;
fprintf('Observed \t Calculated \n')
mmodel = [modelr,modelt];

for i = 1:length(m)
    fprintf('%f \t %f \n',mmodel(i),m(i))
end
fprintf('\n')

r = m(1:lr); t = m(1+lr:lr+lt);
rr = [0,r];
tt = [0,cumsum(t),max(t)*10000];           
modelrr = [0,modelr];
modeltt = [0,cumsum(modelt),max(modelt)*10000];  

subplot(1,6,[5 6]);
hold off
stairs(modelrr,modeltt,'--','color','r','LineWidth',2);
hold on
stairs(rr,tt,'b','LineWidth',2);
set(gca,'Ydir','reverse');
set(gca,'Xscale','log');
axis([10^0.5 1000 0 100]);
grid on
xlabel('Resistivity (Ohm-m)','fontweight','bold','fontsize',10);
ylabel('Depth (m)','fontweight','bold','fontsize',10);
set(gca,'XTick',[1e-3 1e-2 1e-1 1 1e1 1e2 1e3]);
title('\bf \fontsize{12} \fontname{Times}Model');
leg = legend('Real','SVD'); set(leg,'Location','South','fontsize',8);
end

