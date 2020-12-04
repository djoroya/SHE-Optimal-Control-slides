function [W] = nsphere(dim,ntheta,nphi)


    %%% Create the matrix of weigths by choosing points in the unit ball
    
    
    
%     cosphi = linspace(-1,1,nphi+2);
%     cosphi = cosphi(2:end-1);
%     phi = acos(cosphi);
%     
    dphi = 2*pi/nphi;
    phi = linspace(0, 2*pi-dphi, nphi);
    
    
    phi_ms = [];
    dtheta = pi/ntheta;
    for idim = 1:dim-2
        costheta = linspace(-1,1,ntheta+2);
        costheta = costheta(2:end-1);
        theta{idim} = acos(costheta);
        %theta{idim} = linspace(dtheta,pi-dtheta,ntheta);
        theta_ms{idim} = [];
    end

    if dim >2
        [theta_ms{:},phi_ms] = ndgrid(theta{:},phi);
    else
        phi_ms = phi;
    end
    senos = 0*phi_ms + 1;

    for i = 1: dim-2
        x{i} = senos.*cos(theta_ms{i});
        senos = senos.*sin(theta_ms{i});
    end

    x{dim-1} = senos.*cos(phi_ms);
    x{dim} = senos.*sin(phi_ms);


    W = reshape(cat(dim,x{:}),ntheta^(dim-2)*nphi,dim);

end

