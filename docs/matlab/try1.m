clear 
U = linspace(-1,1,7)';

uspan = linspace(-1,1,500);

Luk = uspan.*(U(2:end) + U(1:end-1)) - (U(2:end).*U(1:end-1));

one =(U(1:end-1)<=uspan).*(uspan < U(2:end));

plot(uspan,sum(Luk.*one,1),'.-')


%%
theta = @(x) 0.5 + 0.5*tanh(100*x);

plot(uspan,-1 +theta(uspan-0.5) + theta(-uspan+0.75) )