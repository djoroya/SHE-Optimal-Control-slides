function [fvalues] = angles2fspan3LVL(alphas,tspan)

alphas = [0 alphas];
n_alphas = length(alphas);

values = repmat([1 0],1,ceil(n_alphas/2));

if floor(n_alphas/2) ~= n_alphas/2
    values(end) = [];
end


f = @(tau) values(find(alphas <= tau,1,'last'));

fvalues = arrayfun(@(tau) f(tau),tspan);

end

