function rho = rho_N_bar(sig, N, L)
x = 0:L/1e3:L;
Fr = @(x, r) F_r(x, sig, r, N, L);
pr = @(x, r) p_r(x, sig, r, N, L);

I1 = x>(3/2)*sig;
rho1 = trapz(x(I1), pr(x(I1),1));

rho2 = 0;
for r=2:N
    rho2 = rho2 + trapz(x, pr(x,r).*Fr(x-2*sig,r-1));
end

rho3 = Fr(L-3*sig/2,N);

rho = (rho1+rho2+rho3)/(N+1);
end