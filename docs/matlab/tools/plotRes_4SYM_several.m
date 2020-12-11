function plotRes_4SYM(bharmonics,bmatrix,variation,fvalues,ylabelstring,tstring)
[~,Nt] = size(fvalues);
    
    tspan = linspace(0,pi/2,Nt);

    surf(tspan,variation,fvalues)
    %view(-90,270)
    view(90,-90)
    shading interp
    colorbar 
    %colormap(jet(3))
    xlabel('$u(\tau)$','Interpreter','latex','FontSize',18)
    ylabel(ylabelstring,'Interpreter','latex','FontSize',18)    
    title(tstring)
    xlim([0 pi/2])
    xticks([0 pi/4 pi/2])
    xticklabels({'0','\pi/4','\pi/2'})
end

