clear 

Nt = 150;
tspan = linspace(0,5,Nt);

uspan = linspace(-1.5,1.5,200);


L1 = @(m,u) m*u + abs(u);
L2 = @(m,u) m*u + u.^2;
Lp = @(m,u) m*u +   (-2.0<u).*(u<=-1.0) .*  ((-2.0-1.0) .*u - 2.0) + ...
                    (-1.0<u).*(u<=-0.5) .*  ((-1.0-0.5) .*u - 0.5) + ...
                    (-0.5<u).*(u<=+0.0) .*  ((-0.5+0.0) .*u + 0.0) + ...
                    (+0.0<u).*(u<=+0.5) .*  ((+0.0+0.5) .*u + 0.0) + ...
                    (+0.5<u).*(u<=+1.0) .*  ((+0.5+1.0) .*u - 0.5) + ...
                    (+1.0<u).*(u<=+2.0) .*  ((+2.0+1.0) .*u - 2.0) ;

%
fig = figure('Units','norm','pos',[0 0 0.5 0.5]);
clf
subplot(4,1,[1 2 3])
xline(-1)
xline(1)

hold on

L1_plot = plot(uspan,L1(0,uspan),'r','LineWidth',1.5);
L2_plot = plot(uspan,L2(0,uspan),'b','LineWidth',1.5);
Lp_plot = plot(uspan,Lp(0,uspan),'g','LineWidth',1.5);

min_L1 = plot(0,0,'r.','MarkerSize',35);
min_L2 = plot(0,0,'b.','MarkerSize',35);
min_Lp = plot(0,0,'g.','MarkerSize',35);

title('')
legend([L1_plot,L2_plot,Lp_plot], ...
        {'$\mathcal{L}(u)=|u|$','$\mathcal{L}(u)=u^2$','$\mathcal{L}^d(u)$'}, ...
        'Interpreter','latex', ...
        'FontSize',15,'Location','north')
title('$H^*(u) = mu+\mathcal{L}(u)$','Interpreter','latex','FontSize',20)

grid on 
xlim([-1.5 1.5])
ylim([-1.5 2])
mt = 2*sin(pi*tspan);

subplot(4,1,4)
hold on
implot = plot(1:Nt,mt,'-','LineWidth',2);
jmplot = plot(1,mt(1),'.','MarkerSize',35);
ylabel('m')
xticks('')
grid on 
yline(0)
legend(implot,{'$m$'}, ...
        'Interpreter','latex', ...
        'FontSize',15,'Location','north')
    
path = "../videos";
v = VideoWriter(fullfile(path,'beha-L1-L2-Lp'),'MPEG-4');
v.FrameRate = 10;
open(v)
%%
for it = 1:Nt
    L1_plot.YData = L1(mt(it),uspan);
    L2_plot.YData = L2(mt(it),uspan);
    Lp_plot.YData = Lp(mt(it),uspan);

    [u1,ind1] = min(1e3*(uspan<-1)+ ...
                    1e3*(uspan>+1)+ ...
                    L1(mt(it),uspan));
    [u2,ind2] = min(1e3*(uspan<-1)+ ...
                    1e3*(uspan>+1)+ ...
                    L2(mt(it),uspan));
    [u3,ind3] = min(1e3*(uspan<-1)+ ...
                    1e3*(uspan>+1)+ ...
                    Lp(mt(it),uspan));
                
    %
    min_L1.XData = uspan(ind1);
    min_L1.YData = u1;

    min_L2.XData = uspan(ind2);
    min_L2.YData = u2;
    %
    min_Lp.XData = uspan(ind3);
    min_Lp.YData = u3;
    %
    jmplot.XData = it;
    jmplot.YData = mt(it);
    %
    pause(0.1)
    frame = getframe(gcf);
    writeVideo(v,frame);
    %
end 
close(v)
