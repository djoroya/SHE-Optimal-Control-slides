clear all

%%% Number of harmonics (dimension of the dynaical system)
harmonics = [1 3];
%harmonics = [1 3];

dim = length(harmonics);
%%% Time discretization
Nt = 400;
T = pi/2;
tspan = linspace(0,T,Nt);

ValueF = ComputeValueFunction(harmonics,tspan);
%%
rand_only_b1 = false;

if rand_only_b1
    b0 = zeros(length(harmonics),1);
    b0(1) = 0.5*rand;
else
    b0 = 0.5*rand(length(harmonics),1);
end
%b0 = [0.5 0.0 0.0 0.0 0.0];
[f_time,bT_time] = ComputeSolution(ValueF,tspan,b0,harmonics,2);
%
%%
figure('unit','norm','pos',[0 0 0.5 0.5])
PlotSolution(f_time,bT_time,b0,tspan,harmonics,ValueF)
%

%%