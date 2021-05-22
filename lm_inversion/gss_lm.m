function [xfinal] = gss_lm(m,a,b)
% Golden Section Search
%   for determining optimum value of 

% a = 0;                            % start of interval
% b = 1000;                         % end of interval
epsilon = 1e-10;                  % accuracy value
iter = 50;                        % maximum number of iterations
tau = double((sqrt(5)-1)/2);      % golden proportion coefficient, around 0.618
k = 0;                            % number of iterations

%=== Equation ===%
x1 = a+(1-tau)*(b-a);             % computing x values
x2 = a+tau*(b-a);

fx1 = funcGSS(m,x1);                      % computing values in x points
fx2 = funcGSS(m,x2);

while ((abs(b-a) > epsilon) && (k < iter))
    k = k+1;
    
    if(fx1 < fx2)
        b = x2;
        x2 = x1;
        x1 = a+(1-tau)*(b-a);
        
        fx1 = funcGSS(m,x1);
        fx2 = funcGSS(m,x2);
    else
        a = x1;
        x1 = x2;
        x2 = a+tau*(b-a);
        
        fx1 = funcGSS(m,x1);
        fx2 = funcGSS(m,x2);
    end
    
    k = k+1;
end

% chooses minimum point
if(fx1 < fx2)
    xfinal = x1;
else
    xfinal = x2;
end

end

