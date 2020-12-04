function [an,bn] = f2anbn_2SYM(fvalues,tspan,aharmonics,bharmonics)

    [ndata,~] = size(fvalues);
    anfcn = @(f,n) (2/pi)*trapz(tspan,cos(n*tspan).*f);
    bnfcn = @(f,n) (2/pi)*trapz(tspan,sin(n*tspan).*f);


    Na = length(aharmonics);
    an = zeros(ndata,Na);
    for n = 1:Na
        for id = 1:ndata
            an(id,n) = anfcn(fvalues(id,:),aharmonics(n))';
        end
    end
    
  
    Nb = length(bharmonics);
    bn = zeros(ndata,Nb);
    for n = 1:Nb
        for id = 1:ndata
            bn(id,n) = bnfcn(fvalues(id,:),bharmonics(n))';
        end
    end
    
end

