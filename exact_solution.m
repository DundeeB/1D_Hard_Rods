L = 40;
N = 34;
eta = 0.9;
sig = 1;  % eta*L/n;

X = 0:sig/1e1:L;
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
plot(X_rho/sig,rho,'-');
set(gca,'FontSize',24);
xlabel('x/\sigma');
ylabel('\rho');
grid on;
title(['Exact solution, N=' num2str(N) ', L=' num2str(L) ', \sigma=' num2str(sig)]);
ylim([-0.05 max(rho)*1.1]);