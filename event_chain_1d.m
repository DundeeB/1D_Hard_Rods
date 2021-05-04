clear all; clc
L=12; 
N=10;
N_real = 1e6;
a = 1;

h = (L-(N+1)*a)/(N+1);
total_step = pi/3*h*N;
% cells = [a*(0.4:0.2:2.5) 3*a:a:L-3*a L-2.5*a:0.2*a:L-0.4*a];
% x = cells(1:length(cells)-1) + diff(cells)/2;
x = a*0.5:a*0.2:L-0.5*a;
% while true
%     v = a+(L-2*a)*rand(N,1);    
%     if min(diff(sort([0;v;L])))>a
%         break
%     end
% end
v = (a/2+h:a+h:L-a/2-h)';
%%
v = [-a/2 ;sort(v); L+a/2];
rho = zeros(length(x)-1,1);
for i=1:N_real
    i_p = 1 + randi(N);
    direction = randi(2)*2-3;
    current_step = total_step;
    while current_step > 0
        if direction > 0
            free_space = v(i_p + 1) - v(i_p) - a;
            if free_space < current_step
                v(i_p) = v(i_p) + free_space;
                if i_p < N + 1  % collision
                    i_p = i_p + 1;
                else  % wall
                    direction = -direction;
                end
                current_step = current_step - free_space;
            else  % free
                v(i_p) = v(i_p) + current_step;
                current_step = 0;
            end
        else
            free_space = v(i_p) - v(i_p - 1) - a;
            if free_space < current_step
                v(i_p) = v(i_p) - free_space;
                if i_p > 2  % collision
                    i_p = i_p - 1;
                else  % wall
                    direction = -direction;
                end
                current_step = current_step - free_space;
            else  % free
                v(i_p) = v(i_p) - current_step;
                current_step = 0;
            end
        end
    end
    v_n_b = v(2:end-1);
    for j=2:length(x)
        rho(j-1) = rho(j-1) + (sum(v_n_b>x(j-1) & v_n_b<x(j)))/(x(j)-x(j-1));
    end
end
%%
x_ = 0.5*(x(1:end-1)+x(2:end));
RHO = rho/trapz(x_,rho)*N;
plot(x_, RHO,'.--', 'LineWidth', 1.5, ...
    'MarkerSize', 20, 'DisplayName','Event Chain Walls extension');
xlabel('x/\sigma'); ylabel('\rho');set(gca,'FontSize',24);grid on;
xlim([0 L]);ylim([0 5]);
title(['N=' num2str(N) ', L/\sigma=' num2str(L/a)]);
hold all;
exact_solution(L,N,a);
legend;