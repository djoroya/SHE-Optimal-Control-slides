function [f_time,bT_time,bn] = ComputeSolution(ValueF,tspan,b0,harmonics,Nf)

Nt = length(tspan);

dim = length(b0);
bT_time = zeros(dim,Nt);
bT_time(:,1)= b0;

f_time = zeros(1,Nt-1);

F = @(t,f) -(4/pi)*sin(harmonics'*t)*f;

f_span = linspace(-1,1,Nf);

indexs = 1:Nf;
Va = zeros(Nf,1);

for it = 2:Nt
   dt = tspan(it) - tspan(it-1);
   bTc = bT_time(:,it-1);
   for ifs = 1:Nf
        bTn = bTc + dt*F(tspan(it),f_span(ifs));
        %
        
        Va(ifs) = ValueF(it,bTn');
%        Va(ifs) = ValueFunEx(bTn',tspan(it),harmonics);



        %Va(ifs) = Vf(tspan(it),bTn');
   end
   [Vmin,ind_f] = min(Va);

   % regla 
  if sum(Vmin == Va)>1
      switch 2
          
        case 1
            ind_f = randsample(indexs(Vmin == Va),1,true);
        case 2
            if it > 2
                posibles = indexs(Vmin == Va);
                ind_f = find(f_time(it-2) == f_span(posibles));
                if isempty(ind_f)
                    ind_f = randsample(indexs(Vmin == Va),1,true);
                end
            else
                ind_f = randsample(indexs(Vmin == Va),1,true);
            end
          case 3
            posibles = indexs(Vmin == Va);
            if ismember(1,posibles)
                ind_f = 1;
            end
          case 4
            posibles = indexs(Vmin == Va);
            if ismember(-1,posibles)
                ind_f = -1;
            end
          case 5
              
      end
  end
   f_time(it-1)  = f_span(ind_f);
   bT_time(:,it) = bT_time(:,it-1) + dt*F(tspan(it),f_span(ind_f));

end


[an,bn] = f2anbn(f_time,tspan(1:end-1),0,harmonics');


end

