clear all; clc
L=20; 
N=7;
total_step = L/N;
N_real = 1e6;
a = 1;
x = [a*(0.9:0.2:2.5) 3*a:a:L-3*a L-2.5*a:0.2*a:L-0.9*a];
rho = zeros(length(x)-1,1);
while true
    v = a+(L-2*a)*rand(N,1);    
    if min(diff(sort([0;v;L])))>a
        break
    end
end
v = [0 ;sort(v); L];
for i=1:N_real
    i_p = 1 + randi(N);
    sg = randi(2)*2-3;
    step = total_step;
    while step > 0
        if sg > 0
            next_step = v(i_p + 1) - v(i_p) - a;
            if next_step < step
                v(i_p) = v(i_p) + next_step;
                if i_p < N + 1  % collision
                    i_p = i_p + 1;
                else  % wall
                    sg = -sg;
                end
                step = step - next_step;
            else  % free
                v(i_p) = v(i_p) + step;
                step = 0;
            end
        else
            next_step = v(i_p) - v(i_p - 1) - a;
            if next_step < abs(step)
                v(i_p) = v(i_p) - next_step;
                if i_p > 2  % collision
                    i_p = i_p - 1;
                else  % wall
                    sg = -sg;
                end
                step = step - next_step;
            else  % free
                v(i_p) = v(i_p) - step;
                step = 0;
            end
        end
    end
    v_n_b = v(2:end-1);
    for j=2:length(x)
        rho(j-1) = rho(j-1) + (sum(v_n_b>x(j-1) & v_n_b<x(j)))/(x(j)-x(j-1));
    end
end
%%
plot(0.5*(x(1:end-1)+x(2:end)), rho/sum(rho),'o--');
xlabel('x'); ylabel('\rho');set(gca,'FontSize',24);grid on;xlim([0 L]);
title(['Event Chain. N=' num2str(N) ', a=' num2str(a) ', L=' num2str(L)]);