function PlotSolution(f_time,bT_time,b0,tspan,harmonics,Vf)

T = tspan(end);
Nt = length(tspan);
clf

%%
subplot(3,2,2)
hold on 
plot(bT_time')
title('$x(\tau) = [\beta_1(\tau) \beta_3(\tau)]$','Interpreter','latex')
xlabel('$\tau$','Interpreter','latex')

yline(0)
ylim([-0.5 0.5])

%%
subplot(3,2,4)

refine_tspan = linspace(0,T,3*Nt);
refine_f_time = interp1(tspan(1:end-1),f_time,refine_tspan,'nearest','extrap');

plot(refine_tspan,refine_f_time)
ylabel('$f(\tau)$','Interpreter','latex')
xlabel('$t$','Interpreter','latex')
ylim([-1.5 1.5])
yline(0)
%%
subplot(4,4,15)
[an,bn] = f2anbn(refine_f_time,refine_tspan,0,harmonics');
jb = bar(bn);
title('Harmónicos Obtenidos','FontSize',10,'Interpreter','latex')
ylim([-1 1])
xticklabels("\beta_{"+harmonics'+'}')


%%
subplot(4,4,16)
ib = bar(b0);
title('Harmónicos Target','FontSize',10,'Interpreter','latex')
ylim([-1 1])
xticklabels("\beta_{"+harmonics'+'}')
%%

b1_span = linspace(-1,1,150);
b2_span = linspace(-1,1,150);
[b1ms ,b2ms] = meshgrid(b1_span,b2_span);

V = zeros(150,150,Nt);
for it = 1:Nt
    for ib1 = 1:150
        for ib2 = 1:150
            V(ib1,ib2,it) = Vf(it,[b1_span(ib1) b2_span(ib2)]);
        end
    end
end
%%
subplot(1,2,1)
hold on
isurf = surf(b1ms,b2ms,V(:,:,1));
colormap jet
view(0,-90)
caxis([0 1e-6])
shading interp
xline(0,'color','w')
yline(0,'color','w')
iplot = plot(bT_time(1,1),bT_time(2,1),'LineWidth',2,'Color',[0.9 0.9 0.9]);
jplot = plot(bT_time(1,1),bT_time(2,1),'Marker','.','MarkerSize',20);

xlabel("$\beta_1$",'Interpreter','latex')
ylabel("$\beta_3$",'Interpreter','latex')

path = "/Users/djoroya/Documents/GitHub/SHE-ControlTheory-slides/videos";

v = VideoWriter(fullfile(path,'solutions'),'MPEG-4');
open(v)
for it = 2:Nt
    isurf.ZData = V(:,:,it);
    %
    iplot.XData = [iplot.XData bT_time(1,it)];
    iplot.YData = [iplot.YData bT_time(2,it)];
    %
    jplot.XData =  bT_time(1,it);
    jplot.YData =  bT_time(2,it);
    frame = getframe(gcf);
    writeVideo(v,frame);
end

close(v);

end

