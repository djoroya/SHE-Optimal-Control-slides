clf 
path = "/Users/djoroya/Documents/GitHub/SHE-ControlTheory-slides/videos";
Nt = 100
tspan = linspace(0,pi,Nt);

ft = sin(4*tspan) + cos(2*tspan+0.2);
ft = sign(ft);

f = @(t) interp1(tspan,ft,t);

dyn = @(t,x) (2/pi)*f(t)*[sin(t)];

x0 = [0];

[~,xt] = ode45(dyn,tspan,x0);


xT = (2/pi)*trapz(tspan,cos(tspan).*ft);

figure('Units','norm','pos',[0 0 0.5 0.5])
clf
subplot(1,3,1)
hold on
plot(xt(end,1) - xt(:,1),1:Nt,'LineWidth',2)

yline(0)
xline(0)

iplot = plot(xt(end,1) - xt(1,1),1,'Marker','.','MarkerSize',18);

xlim([-0.5 0.5])

title("Sistema dinámico","Interpreter","latex")
ylabel('$t$','Interpreter','latex','FontSize',21)
xlabel('$\beta_1$','Interpreter','latex','FontSize',21)
%%

subplot(1,3,2)
hold on
plot(ft,1:Nt,'LineWidth',2);
jplot =plot(1,ft(1),'Marker','.','MarkerSize',18);

title("Control")
ylabel("$t$",'FontSize',21,'Interpreter','latex')
xlabel("$f_t$",'Interpreter','latex','FontSize',21)
xlim([-1.5 1.5])
%xlim([0 pi])
xline(0)
%%
subplot(1,3,3)


bar([1],[xT]);
title('Coeficiente de Fourier')
xticklabels({'\beta_1'})
ylim([-0.3  0.3])
%%
v = VideoWriter(fullfile(path,'peaks'),'MPEG-4');
open(v);
%
for it = 1:Nt
   iplot.XData = xt(end,1) - xt(it,1); 
   iplot.YData = it;
   
   jplot.YData = it;
   jplot.XData = ft(it);
   
   if false
    frame = getframe(gcf);
    writeVideo(v,frame);
   else
     pause(0.1)  
   end
end
close(v);
%%
