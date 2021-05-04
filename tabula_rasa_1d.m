clear all; clc
L=20; 
N=7;
N_real = 1e5;
a = 1;
x = [a*(0.9:0.2:2.5) 3*a:a:L-3*a L-2.5*a:0.2*a:L-0.9*a];
rho = zeros(length(x)-1,1);
for i=1:N_real
    while true
        v = L*rand(N,1);    
        if min(diff(sort([0;v;L])))>a
            break
        end
    end
    for j=2:length(x)
        rho(j-1) = rho(j-1) + (sum(v>x(j-1) & v<x(j)))/(x(j)-x(j-1));
    end
end
%%
x_ = 0.5*(x(1:end-1)+x(2:end));
plot(x_, rho/trapz(x_,rho),'o--');
xlabel('x'); ylabel('\rho');set(gca,'FontSize',24);grid on;xlim([0 L]);
title(['Tabula Rasa. N=' num2str(N) ', a=' num2str(a) ', L=' num2str(L)]);