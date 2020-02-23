% 1D Inversion of Schlumberger Sounding Data using Singular Value Decomposition (SVD) Method

% Created by:
% Ekinci Y L and Demirci A 2008 J. of Appl. Sciences 8 (22) : 4070-4078.
% URL: https://scialert.net/abstract/?doi=jas.2008.4070.4078

% Modified by:
% M. Heriyanto and W. Srigutomo. Journal of Physics: Conference Series 877 (2017) 012066.
% Update:  2016-07-26
% URL: https://github.com/mheriyanto/MH1DDC

close all; clear; clc;
format long;

global x;
global roa;
global models;
global modelr;
global modelt;

global lr;
global lt;

% Model 2
load Model.txt
models = Model(:,1);                          
modelr = [100,60,30,10];    % resistivity (Ohm-m)   
modelt = [10,15,30];        % thickness (m)
mmodel = [modelr modelt];

load data.txt;
x = data(:,1);              % space distance of electrode (AB/2)
roa = data(:,2);            % resistivity for each electrode distance (observed)

% initial model
r = [50,50,50,50];           % initial resistivity (Ohm-m)    
t = [20,20,20];              % iniial thickness (m)
m = [r,t];

lr = length(r); lt = length(t);
kr = 10e-25;
iteration = 0;
maxiteration = 100;
dfit = 1;    
rms_error = 1;
tol = 1e-25;
b = []; 

while(iteration < maxiteration)
    r = m(1:lr);
    t = m(1+lr:lr+lt);

    % firt calculated data (forward modeling)
    for i = 1:length(x)            % length of AB/2
        s = data(i);                
        [g] = VES1DFWD(r,t,s);      % forward output 
        roa1(i,:) = g;              % apparent resistivity (calculated)
    end
    er1 = [log(roa)-log(roa1)];     % error
    dd = er1;        
    misfit1 = er1'*er1;             % misfit
    if(misfit1<kr)                  % misfit < konvergen condition
        break;
    end
    
    [A] = jacobian(data,r,t,roa1);              % jacobian matrix
    [U, S, V] = svd(A,0);    %U(nxp); S(pxp); V(pxp)  % singular value docimposition (SVD)
    ss = length(S);                                 % diagonal matrix (S)
    say = 1;                                        % L-th iteration
    k = 0;               

    while(say<ss)                               % L < lamda length                           
        diagS = diag(S);                        % diagonal of S matrix (lamda)
        beta =  S(say)*(dfit^(1/say));          % epsilon = lamda*deltaX^(1/L)
        if(beta<10e-5)                          
            beta = 0.001*say;                   % epsilon = 0.001*L
        end 
        SS = zeros(ss,ss);
        for i4 = 1:ss
            SS(i4,i4) = S(i4,i4)/(S(i4,i4)^2+beta);     %(diag(lamda)/(diag(lamda)+epsilon))
        end
        dmg = V*SS*U'*dd;               % equation: V*diag(lamda/lamda+epsilon)*U*delta d
        mg = exp(log(m)+dmg');          % model peturbation (LOG)
        r = mg(1:lr);                   % resistivity
        t = mg(1+lr:lr+lt);             % thickness
        
        for i5 = 1:length(x)
            s = data(i5);
            [g] = VES1DFWD(r,t,s);
            roa4(i5,:) = g;             % apparent resistivity (calculated)
        end
        er2 = [log(roa)-log(roa4)];
        misfit2 = er2'*er2;
        
        if(misfit2 > misfit1)                      % misfit2 > misfit1
            say = say+1;                            % L = L+1
            k = k+1;               
            if(k == ss-1)                           % k == lamda length
                iteration = maxiteration;           % exit LOOP (iteration < maxiteration)
                say = ss+1;                         % exit LOOP (say<ss)
            end
        else
            say = ss+1;
            m = mg;
            dfit = (misfit1-misfit2)/misfit1;
            iteration = iteration+1;
            a = iteration;
            if(dfit<kr)
                iteration = maxiteration;           % exit LOOP (iteration < maxiteration)
                disp('Forced Finish!');
                say = say+1;                        % exit LOOP (say<ss)
            end
        end
    end
    [rms_error,iteration] = plot_iterasi(m,roa4,iteration);
    b = [b;rms_error iteration];
    if(rms_error < tol)
        break
    end
end

lenb = length(b);
errorplot = zeros(lenb);
iter = zeros(lenb);
for i = 1:lenb
    errorplot(i) = b(i,1);
    iter(i) = b(i,2);
end

% save final result of inversion
print('-dpng','SVD Final Inversion','-r500');

figure(3)
plot(iter,errorplot,'-','color','r','LineWidth',2);
grid on
title('\bf \fontsize{12}\fontname{Times}Parameters of SVD Inversion');
xlabel('Iteration','fontweight','bold','fontsize',10);
ylabel('RMS Error','fontweight','bold','fontsize',10);
axis tight

% save inversion parameter figure
print('-dpng','Plotting Inversion Parameter','-r500')
save InvDCResSVD.mat
