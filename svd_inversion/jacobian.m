% Jacobian Function %
% Finite difference %
function[J] = jacobian(data,r,t,roa1)
global x;
global roa;
global lr;
global lt;

par = 0.15;
s = data(:,1)';

r2 = r;
for i2 = 1:lr                       % length of resistivity
    r2(i2) = (r(i2)*par)+r(i2);  
        for ii = 1:length(x)        % length of measurement
            s = data(ii);
            [g] = VES1DFWD(r2,t,s); % forward modeling
            roa2(ii,:) = g;
        end
    J1(:,i2) = [(roa2-roa1)/(r(i2)*par)]*r(i2)./roa;
    r2 = r;
end

t2 = t;
for i3 = 1:lt                       % length of thickness
    t2(i3) = (t(i3)*par)+t(i3);
        for ii = 1:length(x)
            s = data(ii);
            [g] = VES1DFWD(r,t2,s);
            roa3(ii,:) = g;
        end
    J2(:,i3) = [(roa3-roa1)/(t(i3)*par)]*t(i3)./roa;
    t2 = t;
end

    J = [J1 J2];
return