pro timescale

read, "Enter mass (M_sun): ", m
read, "Enter luminosity (L_sun): ", l
read, "Enter radius (R_sun): ", r

tdyn = 30.*(r)^(3/2)
tkh = 30.*(m)^2 * (r)^(-1) * (l)^(-1)
tnuc = 10.^10 * m * (l)^(-1)

print, "Dynamical time (min) = ", tdyn
print, "KH time (Myr) = ", tkh
print, "Nuclear time (Myr) = ", tnuc/10.^6

end
