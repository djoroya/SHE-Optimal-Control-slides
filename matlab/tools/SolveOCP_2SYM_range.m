function [fopts, x_opt]= SolveOCP_2SYM_range(amatrix,bmatrix,S,ftraj,Nt,fconstraints)

import casadi.*


plots = true;


[ndata,ndim] = size(bmatrix);
[ndata,ndim_a] = size(amatrix);

fopts = zeros(ndata,Nt);

x_opt = zeros(ndim+ndim_a,Nt,ndata);

u0 = zeros(1,Nt);

for i = 1:ndata

    bT = bmatrix(i,:)';
    aT = amatrix(i,:)';

    lbg = [fconstraints(1)*ones(size(u0)),aT',bT'];
    ubg = [fconstraints(2)*ones(size(u0)),aT',bT'];

    r = S('x0',[u0(:);aT(:);bT(:)], 'lbg',lbg,'ubg',ubg);
    u_opt = r.x;
    u_opt = reshape(full(u_opt(1:Nt)),1,Nt);
    
    fopts(i,:) = u_opt;
    x_opt(:,:,i) = full(ftraj(u_opt));
    %
    if plots 
        subplot(1,2,1);
        plot(u_opt');title('u')
        subplot(1,2,2);
        plot(x_opt(:,:,i)');title('x')
        pause(0.1)
    end

    fprintf("=================== iter ====================== :"+i+"/"+ndata)
    u0 = u_opt;

end

% agregamos una columna mas para respetar la discretizacion en el tiempo
%fopts = [fopts fopts(:,end)];
end

