% 1D Inversion of Schlumberger Sounding Data using Levenberg-Marquardt (LM) Method
% M. Heriyanto and W. Srigutomo. 2016. Journal of Physics: Conference Series 877 (2017) 012066.
% URL: https://github.com/mheriyanto/MH1DDC

close all; clear all; clc;

global data;
global ab;
global rhoa;
global models;
global modelr;
global modelt;

global lr;
global lt;

% Load model for forward modeling
load Model.txt
models = Model(:,1);                          
modelr = [100,60,30,10];    % resistivity (Ohm-m)   
modelt = [10,15,30];        % thickness (m)
mmodel = [modelr modelt];

% Inversion
load data.txt;
ab = data(:,1);              % space distance of electrode (AB/2)
rhoa = data(:,2);            % resistivity for each electrode distance

% initial model
r = [50,50,50,50];           % initial resistivity (Ohm-m)    
t = [20,20,20];              % thickness (m)
m = [r,t];                   

lr = length(r); lt = length(t); 
kr = 10e-20;                     % convergence tolerance
j = 1;                           % initial iteration
iteration(j) = 1;
itermax = 100;

r = m(1:lr);
t = m(1+lr:lr+lt);

% firt calculated data (forward modeling)
for(i = 1:length(ab))
    s = data(i);
    [g] = VES1DFWD(r,t,s);      % forward output 
    rhoa_cal(i,:) = g;          % apparent resistivity (calculated)
end

rms_err = norm(rhoa_cal-rhoa)/sqrt(length(rhoa));
rms_error(j) = rms_err;

if(rms_err < kr)
    plot_iterasi(m,rhoa_cal,j);
end

while(rms_err > kr)
    
    % find lamda value using golden section search
     [lamda] = gss_lm(m,0.001,10);  
     disp('lamda'); disp(lamda);
     lamda_plot(j) = lamda;

    % === Find optimum lamda === %
    % Jacobian matrix (using input: r,t, rhoa_cal)
    [J] = jacobian(data,r,t,rhoa_cal);   
    
    % Levenberg-marquardt algorithm
    jac = inv(J'*J+lamda*eye(size(J'*J)));
    dm = jac*J'*[rhoa-rhoa_cal];
    m = m + dm';  
     
    r = m(1:lr);                    % resistivity
    t = m(1+lr:lr+lt);              % thickness
     
    % find next model
    for(i = 1:length(ab))
       s = data(i);
       [g] = VES1DFWD(r,t,s);
       rhoa_cal(i,:) = g;
    end
     
    rms_err = norm(rhoa_cal-rhoa)/sqrt(length(rhoa));

    j = j + 1;
    rms_error(j) = rms_err; 
    iteration(j) = iteration(j-1)+1; 
     if (iteration(j) > itermax)
         break
     end
     plot_iterasi(m,rhoa_cal,j);
    
end

% get final lamda
[lamda] = gss_lm(m,0.001,10); 
lamda_plot(j) = lamda;

print('-dpng','LM Final Inversion','-r500');

% plotting lamda vs rms error
figure(3)
plot(lamda_plot,rms_error,'-','color','r','LineWidth',2);
grid on
xlabel('Lamda','fontweight','bold','fontsize',10);
ylabel('RMS Error','fontweight','bold','fontsize',10);

% save lamda figure
print('-dpng','Plotting Lamda','-r500')

figure(4)
plot(iteration,rms_error,'-','color','r','LineWidth',2);
grid on
title(['\bf \fontsize{12}\fontname{Times}Parameters of LM Inversion']);
xlabel('Iteration','fontweight','bold','fontsize',10);
ylabel('RMS Error','fontweight','bold','fontsize',10);
axis tight

% save inversion parameter figure
print('-dpng','Plotting Inversion Parameter','-r500')
save InvDCResLM.mat
