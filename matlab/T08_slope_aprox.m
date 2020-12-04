
Nt = 400;
tspan = linspace(0,pi,Nt);
path = "/Users/djoroya/Documents/GitHub/SHE-ControlTheory-slides/videos";

dt = tspan(2) -tspan(1);
D = @(t) +(2/pi)*[cos(t);sin(t)];
%%
ntheta = 30;
theta = linspace(0,2*pi,ntheta+1);
theta = theta(1:end-1);

x = 0.1*sin(theta);
y = 0.1*cos(theta);

figure('Units','norm','pos',[0 0 0.5 0.5])

clf
daspect([1 1 1])
grid on 
xlim([-2 2])
ylim([-2 2])

hold on 

xlabel('$\alpha_1$','Interpreter','latex')
ylabel('$\beta_1$','Interpreter','latex')

for i = 1:ntheta
    pplot(i) = plot(x(i),y(i),'.','markersize',10,'color','b');
    
    rplot(i) = plot([x(i)-y(i)   x(i)   x(i)+y(i)], ...
                    [y(i)+x(i)   y(i)   y(i)-x(i)], ...
                    '-','markersize',10,'color','r');

end
%
dir = D(tspan(end));
Dplot = plot([0 dir(1)],[0 dir(2)],'-','Marker','.','MarkerSize',20);
legend(Dplot,'$\mathcal{D}(\tau)$','Interpreter','latex')
v = VideoWriter(fullfile(path,'region-al2'),'MPEG-4');
%v.FrameRate = 0.8;
open(v);

for it = 1:60;
    frame = getframe(gcf);

   writeVideo(v,frame);

end
for it = Nt:-1:1
    title("t = "+it)
    dir = D(tspan(it));
    Dplot.XData(2) = dir(1);
    Dplot.YData(2) = dir(2);
    for i = 1:ntheta
        r = [pplot(i).XData pplot(i).YData]';
        unit_r = r/norm(r);
        r = r + dt*abs(dot(dir,unit_r))*unit_r ;
        
        
        pplot(i).XData  = r(1);
        pplot(i).YData  = r(2);

        rplot(i).XData  = [r(1)-1.5*r(2)   r(1)   r(1)+1.5*r(2)];
        rplot(i).YData  = [r(2)+1.5*r(1)   r(2)   r(2)-1.5*r(1)];
    end
    frame = getframe(gcf);
    writeVideo(v,frame);
    
end

close(v)