clear 
harmonics = [1 3];
path = "/Users/djoroya/Documents/GitHub/SHE-ControlTheory-slides/videos";

fspan = [-1,1];
Nt = 8;

tspan = (linspace(0,pi^0.95,Nt)).^(1/0.95);
%tspan = linspace(0,pi,Nt);

dt = tspan(2) -tspan(1);
D = @(t) +(2/pi)*[cos(t);sin(t)];

clf
hold on
colors = {'r','b'};

x0 = [0,0]';
figure('Units','norm','pos',[0 0 0.5 0.5])
clf
subplot(1,2,1)
plot(x0(1),x0(2),'.r')
xlim([-2 2])
ylim([-2 2])
xlabel('$\alpha_1$','Interpreter','latex')
zlabel('$t$','Interpreter','latex')
ylabel('$\beta_1$','Interpreter','latex')
hold on
view(2)
grid on
posibles = {x0};

%v = VideoWriter(fullfile(path,'peaks-allpos'),'MPEG-4');
%v.FrameRate = 0.8;
%open(v);
subplot(1,2,2)
direc = D(tspan(1));
jjplot = plot([0 direc(1)],[0 direc(2)],'LineStyle','-','LineWidth',2,'Marker','.','MarkerSize',20);
xline(0)
yline(0)
ylabel('$\mathcal{D}_\beta$','Interpreter','latex')
xlabel('$\mathcal{D}_\alpha$','Interpreter','latex')
xlim([-1 1])
ylim([-1 1])

for it = Nt:-1:2
   dt = tspan(it) -tspan(it-1);
   new_posibles = {};
   iter = 0;
   subplot(1,2,2)
   direc = D(tspan(it));
   jjplot.XData(2) = [direc(1)];
   jjplot.YData(2) = [direc(2)];
   title("t = "+it)
   for ip = posibles
      iter = iter +1;
      subplot(1,2,1)

      new_posibles{iter} = ip{:} + dt*D(tspan(it)); 
      
      plot3([ip{:}(1) new_posibles{iter}(1)], ...
           [ip{:}(2) new_posibles{iter}(2)],[it it-1], ...
           'LineStyle','-','Marker','o','MarkerFaceColor','k','Color','c') 
      iter = iter +1;
      new_posibles{iter} = ip{:} - dt*D(tspan(it)); 

      plot3([ip{:}(1) new_posibles{iter}(1)], ...
      [ip{:}(2) new_posibles{iter}(2)],[it it-1], ...
      'LineStyle','-','Marker','o','MarkerFaceColor','k','Color','m') 
     
      
   end

   posibles = new_posibles;
   pause(0.1)
   for u = 1:20
%   frame = getframe(gcf);
%   writeVideo(v,frame);
   end
end
%%
for i = 0:100
   view(i,90+0.5*i) 
      for u = 1:2

%      frame = getframe(gcf);
%      writeVideo(v,frame);
      end
end

%close(v)
