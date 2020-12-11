function plotRes_4SYM(bharmonics,bmatrix,variation,fvalues,ylabelstring,tstring)
[~,Nt] = size(fvalues);
    
tspan = linspace(0,pi/2,Nt);

    subplot(2,1,1)
    surf(tspan,variation,fvalues)
    %view(-90,270)
    view(90,-90)
    shading interp
    colorbar 
    %colormap(jet(3))
    xlabel('$u(\tau)$','Interpreter','latex','FontSize',18)
    ylabel(ylabelstring,'Interpreter','latex','FontSize',18)    
    title(tstring)
    
    subplot(2,1,2)

    [~,bn] = f2anbn(fvalues,tspan,[],bharmonics);
    err =sqrt(sum((bmatrix - bn).^2,2));

    plot(variation,err)
    ylabel('$\|\beta(\pi/2) - b_T\|$','Interpreter','latex','FontSize',18)
    xlabel(ylabelstring,'Interpreter','latex','FontSize',18)
    colorbar
end

