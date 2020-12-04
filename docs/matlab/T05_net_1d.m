clear 
harmonics = [1 3];

fspan = [-1,1];
Nt = 5;
tspan = linspace(0,pi,Nt);
dt = tspan(2) -tspan(1);
D = @(t) +(2/pi)*[sin(t)];

clf
hold on
colors = {'r','b'};

x0 = [0]';
figure(1)
clf
plot(x0(1),Nt,'.r')
xlabel('\alpha_1')
ylabel('t')

ylim([1 Nt])
xlim([-1.5 1.5])
hold on
grid on
posibles = {x0};

for it = Nt:-1:1
   new_posibles = {};
   iter = 0;
   for ip = posibles
      iter = iter +1;
      new_posibles{iter} = ip{:} + dt*D(tspan(it)); 
      plot([ip{:}(1) new_posibles{iter}(1)],[it it-1], ...
           'LineStyle','-','Marker','o','MarkerFaceColor','k','Color','c') 

      iter = iter +1;
      new_posibles{iter} = ip{:} - dt*D(tspan(it)); 
      plot([ip{:}(1) new_posibles{iter}(1)],[it it-1], ...
      'LineStyle','-','Marker','o','MarkerFaceColor','k','Color','m') 

   end

   posibles = new_posibles;
   pause(0.5)
end