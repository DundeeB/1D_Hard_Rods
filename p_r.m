function pr = p_r(x, sig, r, N, L)
eps = 1e-4;
pr = (F_r(x+eps, sig, r, N, L)-F_r(x-eps, sig, r, N, L))/(2*eps);
end