function f = funcGSS(m,x)
%FUNCGSS Summary of this function goes here
%   Detailed explanation goes here

global lr;
global lt;

global ab;
global rhoa;
global data;

r = m(1:lr);                    % resistivity value
t = m(1+lr:lr+lt);              % thickness value
for(i = 1:length(ab))          % AB/2 distance
    s = data(i);                % saving AB/2 on s varible
    [g] = VES1DFWD(r,t,s);      % forward TEST, output 
    roac1(i,:) = g;          % resistivitas hasil forward (calculated)
end

[J] = jacobian(data,r,t,roac1);   
jac = inv(J'*J+x*eye(size(J'*J)));
dm = jac*J'*[rhoa-roac1];
m = m + dm';  

% next model
r = m(1:lr);
t = m(1+lr:lr+lt);
for(i = 1:length(ab))
    s = data(i);
   [g] = VES1DFWD(r,t,s);
   roac2(i,:) = g;
end

f = ((norm(roac2-rhoa))^2)/length(roac2);
end

