x_f_p = 0.1:0.1:100;
H = @(x) (x>0)+0.5*(x==0);
figure; hold all;
rhos = [0.95 0.9 0.8];
legends = {};
for rho_star = rhos
betaPsig = rho_star*(1-rho_star)^-1;
g = zeros(size(x_f_p));
for i=1:length(x_f_p)
    x =x_f_p(i);
    for n=1:ceil(x)
        g(i) = g(i) + ((1-rho_star)^-1)*(betaPsig^(n-1))/factorial(n-1)*...
            ((x-n)^(n-1))*exp(-betaPsig*(x-n))*H(x-n);
    end
end
plot(x_f_p,g, 'LineWidth',1.5);
legends{end+1} = ['\rho^*=' num2str(rho_star)];
end
%%
legend(legends);
set(gca,'FontSize',20);
grid on;
xlabel('x/\sigma');ylabel('g(x)');