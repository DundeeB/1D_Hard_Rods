function [] = exact_solution(L,N,sig)

X = sig*0.4:sig*0.1:L-0.4*sig;
RHO = zeros(size(X));
for i=1:length(X)
    x = X(i);
    R = 0;
    for r=1:N
        R = R + F_r(x, sig, r, N, L);
    end
    RHO(i) = R;
end
%%
rho = diff(RHO)./diff(X);
X_rho = 1/2*(X(1:end-1)+X(2:end));
plot(X_rho/sig,rho,'-', 'LineWidth', 1.5, 'DisplayName', 'Exacat Solution');
% set(gca,'FontSize',24);
% xlabel('x/\sigma');
% ylabel('\rho');
% grid on;
% title(['Exact solution, N=' num2str(N) ', L/\sigma=' num2str(L)]);
% ylim([-0.05 max(rho)*1.1]);
end