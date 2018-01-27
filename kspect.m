function gap = kspect(lam,xi0,kFa,eps0,Nc,ksteps)

del = 1;

xvec = 1:Nc;
yvec = 1:Nc;
[xij,yij] = meshgrid(xvec,yvec);
rij = bsxfun(@hypot,xij,yij);

Nm = 1 + lam/sqrt(1+lam^2);
Np = 1 - lam/sqrt(1+lam^2);
kFm = kFa*(sqrt(1+lam^2) + lam);
kFp = kFa*(sqrt(1+lam^2) - lam);

I1m = @(rij) Nm/del*real( besselj(0,(kFm+1i/xi0)*rij) + 1i*StruveH0((kFm+1i/xi0)*rij) );
I1p = @(rij) Np/del*real( besselj(0,(kFp+1i/xi0)*rij) + 1i*StruveH0((kFp+1i/xi0)*rij) );
I0m = @(rij) Nm*real( 1i*besselj(1,(kFm+1i/xi0)*rij) + StruveH_1((kFm+1i/xi0)*rij) );
I0p = @(rij) Np*real( 1i*besselj(1,(kFp+1i/xi0)*rij) + StruveH_1((kFp+1i/xi0)*rij) );

A0 = -eps0; %the element at the origin
A = @(rij) del^2/2*(I1m(rij) + I1p(rij));
B = @(rij) del/2*(I0m(rij) - I0p(rij)).*xij.*rij.^-1;
Bx = @(xvec) del/2*(I0m(xvec) - I0p(xvec)); % y=0 and x assumed to be positive
C = @(rij) del/2*(I0m(rij) - I0p(rij)).*yij.*rij.^-1;
Cy = @(yvec) del/2*(I0m(yvec) - I0p(yvec)); % x=0 and y assumed to be positive


% Fourier summation. The matrix product produces a meshgrid of Fourier sums
% for the vectors kx and ky.

kx = linspace(0,pi,ksteps);
ky = linspace(0,pi,ksteps);

coskx = cos(xvec.'*kx);
cosky = cos(ky.'*yvec);
sinkx = sin(xvec.'*kx);
sinky = sin(ky.'*yvec);

Ak = A0 + 2*ones(ksteps,1)*A(xvec)*coskx + 2*cosky*A(yvec.')*ones(1,ksteps) ...
    + 4*cosky*A(rij)*coskx;
Bk = 2*ones(ksteps,1)*Bx(xvec)*sinkx + 4*cosky*B(rij)*sinkx;
Ck = 2*sinky*Cy(yvec.')*ones(1,ksteps) + 4*sinky*C(rij)*coskx;
Ek = sqrt(Ak.^2 + Bk.^2 + Ck.^2);

gap = min(min(Ek));

