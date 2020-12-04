function [S,ftraj] = SHE2OCP_2SYM(aharmonics,harmonics,Lterm,Nt)
%
import casadi.*
%%
ma = length(aharmonics);
aT = zeros(ma,1);

as = SX.sym('a',ma,1);
%%

mb = length(harmonics);
bT = zeros(mb,1);

bs = SX.sym('b',mb,1);
%%

Xs = [as;bs]; 


fs = SX.sym('f',1,1); ts = SX.sym('t');

das = (2/pi)*fs*cos(aharmonics.*ts);
dbs = (2/pi)*fs*sin(harmonics.*ts);

dynfcn = Function('f',{ts,Xs,fs},{[das;dbs]});

%%
T = pi;
tspan = linspace(0,T,Nt);
dt = tspan(2) - tspan(1);
%%
fst = SX.sym('ft',[1 Nt]);
%
Xend = zeros(mb+ma,1);
xt   = [Xend]; 

method = 'rk4';
for it = 2:Nt
    dt = tspan(it) - tspan(it-1);

    switch method
        case 'euler'
            Xend  =  Xend +  dt*dynfcn(tspan(it-1),Xend,fst(:,it-1));
        case 'rk4'
            k1 =  dynfcn(tspan(it-1)        , Xend             , fst(:,it-1));
            k2 =  dynfcn(tspan(it-1)+0.5*dt , Xend + 0.5*k1*dt , 0.5*fst(:,it-1) + 0.5*fst(:,it));
            k3 =  dynfcn(tspan(it-1)+0.5*dt , Xend + 0.5*k2*dt , 0.5*fst(:,it-1) + 0.5*fst(:,it));
            k4 =  dynfcn(tspan(it-1)+dt     , Xend + 1.0*k3*dt , fst(:,it));
            Xend = Xend + (1/6)*dt*(k1 + 2*k2 + 2*k3 + k4);
    end
   xt   = [xt Xend]; 
end

%%
epsilon = 1e-4;
%alpha = 1;

aTs = casadi.SX.sym('aT',size(bT));
bTs = casadi.SX.sym('bT',size(aT));

nlp = struct( 'x' , [fst(:);aTs;bTs]           ,        ...
              'f' , (Xend - [aTs;bTs])'*(Xend-[aTs;bTs]) +      ...
                    epsilon*dt*sum(Lterm(fst)),       ...
              'g' , [fst(:);aTs;bTs]   );
          
opt = struct('ipopt',struct('print_level',0,'tol',1e-12));
S = nlpsol('S', 'ipopt', nlp,opt);

ftraj = Function('F',{fst},{xt});

end

