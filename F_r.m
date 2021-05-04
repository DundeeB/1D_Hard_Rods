function Fr = F_r(x, sig, r, N, L)
H = @(x) (x>0)+0.5*(x==0);
F = @(x) x./(L-N*sig).*H(x).*H(L-N*sig-x)+H(x-(L-N*sig));
Fr = zeros(size(x));
for i=1:length(x)
for j=r:N
    Fr(i) = Fr(i) + nchoosek(N,j)*(F(x(i)-(r-1/2)*sig))^j*(1-F(x(i)-(r-1/2)*sig))^(N-j);
end
end
end