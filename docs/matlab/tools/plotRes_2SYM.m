function plotRes_2SYM(aharmonics,bharmonics,amatrix,bmatrix,variation,fvalues,ylabelstring,tstring)
    [~,Nt] = size(fvalues);
    
    tspan = linspace(0,pi,Nt);

    subplot(2,1,1)
    surf(tspan,variation,fvalues)
    %view(-90,270)
    view(90,-90)
    shading interp
    colorbar 
    %colormap(jet(3))
    xlabel('$f(\tau)$','Interpreter','latex','FontSize',18)
    ylabel(ylabelstring,'Interpreter','latex','FontSize',18)    
    title(tstring)
    
    subplot(2,1,2)

    [an,bn] = f2anbn_2SYM(fvalues,tspan,aharmonics,bharmonics);
    err =sqrt(sum(  (amatrix - an).^2,2) +sum((bmatrix - bn).^2,2));

    plot(variation,err)
    ylabel('$\Delta$','Interpreter','latex','FontSize',18)
    xlabel(ylabelstring,'Interpreter','latex','FontSize',18)
    colorbar
end

