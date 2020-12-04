function [Vf] = ComputeValueFunction(harmonics,tspan)

dim = length(harmonics);
Nt = length(tspan);
dt = tspan(2) - tspan(1);
%%% Number of neurons in the NN
nphi = 20; %discretization for the meridian
ntheta = 20; %discretization for the lattitude (discret. points without the poles)
[W] = nsphere(dim,ntheta,nphi);

W = cat(1,W,eye(dim),-eye(dim) );

[neurons,~] = size(W);


%%
% clf
% colors = jet(neurons);
% line(W(:,1),W(:,2),W(:,3),'Marker','*','LineStyle','none');
% view(3)
% grid on 
%% 


%%% Evolution for the bias
[harm_grid, t_grid] = meshgrid(harmonics, tspan);

method = 'euler';
switch method
    case 'euler'
        P = -(4/pi)*dt*sin(harm_grid.*t_grid);
end

%%% Create the bias
b = zeros(neurons, Nt);

for it = (Nt-1):(-1):1
    b(:,it) = b(:,it+1) + abs(W*P(it,:)');
end

%%% Define the value function

hevitheta = @(x) 0.5 + 0.5*tanh(100*x);
relu  = @(x) x.*hevitheta(x);
hevitheta = @(x) max(x,0);

Vf = @(t_index,x) norm(hevitheta(W*x' - b(:,t_index))).^2;



end

