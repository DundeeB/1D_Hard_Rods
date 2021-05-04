sig = 1;
figure; hold all;
Ns = [5 10 15];
etas = [0.1:0.1:0.8 0.85 0.9 0.95 0.99];
legends = {};
for N=Ns
    rho = zeros(size(etas));
    for i = 1:length(etas)
        L = N*sig/etas(i);
        rho(i) = rho_N_bar(sig,N,L);
    end
    plot(etas, rho,'.--','MarkerSize',20);
    legends{end+1} = ['N=' num2str(N)];
end
%%
xlabel('\eta=N*\sigma/L');
ylabel('\rho_N');
set(gca,'FontSize',20);grid on;
legend(legends);