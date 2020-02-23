% 1D DC resistivity forward modeling
% Ekinci Y L and Demirci A 2008 J. of Appl. Sciences 8 (22) : 4070-4078.
% URL: https://scialert.net/abstract/?doi=jas.2008.4070.4078

function [rho_a] = VES1DFWD(r,t,s)
q = 13;
f = 10;
m = 4.438;
x = 0;
e = exp(log(10)/(2*m));
h = 2*q-2;
u = s*exp(-f*log(10)/m-x);      % 1/lamda
l = length(r);
n = 1;

li = n+h;
a = zeros(li);
for i = 1:li
    w = l;                  % w = i (n-1 th layer)
    T = r(l);               % T = T(lamda)
    while(w>1)
        w = w-1;
        aa = tanh(t(w)/u);              % t(w) = depth 
        T = (T+r(w)*aa)/(1+T*aa/r(w));  % r = resistivity,    T = T(lamda) 
    end
a(i) = T;
u = u*e;
end

i = 1;
rho_a = 105*a(i)-262*a(i+2)+416*a(i+4)-746*a(i+6)+1605*a(i+8);
rho_a = rho_a-4390*a(i+10)+13396*a(i+12)-27841*a(i+14);
rho_a = rho_a+16448*a(i+16)+8183*a(i+18)+2525*a(i+20);
rho_a = (rho_a+336*a(i+22)+225*a(i+24))/10000;

return