function   E12plot(harmonics,ValueF,Nt,tspan,W,b)

%% Take a values of modulation index 

%% Create Solver

N1 = 70;
N2 = 70;
bT1_span = linspace(-2,2,N1);
bT2_span = linspace(-2,2,N2);
%
[bT1_ms,bT2_ms] = meshgrid(bT1_span,bT2_span);
%
f_span = [-1,1,0];


%%
V = zeros(N1,N2,Nt);

[nn,~] = size(W);
clf
hold on
for ii = 1:nn
    jplot(ii) = plot( [W(ii,2).*b(ii,1) W(ii,2).*b(ii,1)+W(ii,1)  W(ii,2).*b(ii,1)-W(ii,1)], ...
                      [W(ii,1).*b(ii,1) W(ii,1).*b(ii,1)-W(ii,2)  W(ii,1).*b(ii,1)+W(ii,2)] ,'y-','LineWidth',1.25);
end


for it = 1:Nt
    for i = 1:N1
        for j = 1:N2
                bnn = [bT1_span(i) bT1_span(j)];
                V(i,j,it) = ValueF(it,bnn);
        end
    end
end
%%
%mymap = jet(10);

isurf = surf(bT1_ms,bT2_ms,V(:,:,1));
colormap jet
zlim([-3 3])
caxis([0 1e-3])

view(0,-90)
xlabel("\beta_{"+harmonics(1)+"}","FontSize",18)
ylabel("\beta_{"+harmonics(2)+"}","FontSize",18)
%ic = colorbar;
%set(ic,'YTick',[-1 1])
%colormap(mymap)
shading interp

ititle = title('');
daspect([1 1 1])
hold on; 

iplot = plot( W(:,2).*b(:,1)  , W(:,1).*b(:,1) ,'Color','c','Marker','.','LineStyle','none','MarkerSize',14);


for it = (Nt):-20:1
    isurf.ZData = V(:,:,it);
    ititle.String = "V_t(\beta_{"+harmonics(1)+"},\beta_{"+harmonics(2)+"}) | t = "+num2str(tspan(it)/pi,'%.2f')+"\pi";
    iplot.XData = W(:,2).*b(:,it);
    iplot.YData = W(:,1).*b(:,it);
    
for ii = 1:nn
    jplot(ii).XData = [W(ii,2).*b(ii,it) W(ii,2).*b(ii,it)+W(ii,1)  W(ii,2).*b(ii,it)-W(ii,1)];                      
    jplot(ii).YData = [W(ii,1).*b(ii,it) W(ii,1).*b(ii,it)-W(ii,2)  W(ii,1).*b(ii,it)+W(ii,2)];

end
    pause(0.2)
end



 