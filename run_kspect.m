function run_kspect(blockIndex,totalBlocks,ysteps)
tic

xi0 = 15;

Nc = 6*xi0;
ksteps = 3000;

kFamin = 4*pi;
kFamax = 5*pi;

% lam = 0.05;
% eps0min = -0.3;
% eps0max = 0.3;
eps0 = 0.0;
lammin = 0;
lammax = 0.05;

kFa = kFamin + (blockIndex-1)*(kFamax-kFamin)/(totalBlocks-1);
% eps0vec = linspace(eps0min,eps0max,ysteps);
lamvec = linspace(lammin,lammax,ysteps);

if blockIndex == 1
%     save('out/oute1-par','totalBlocks','ysteps','eps0min','eps0max','lam','xi0','Nc','ksteps','-v7.3'); 
    save('out/oute1-par','totalBlocks','ysteps','lammin','lammax','eps0','xi0','Nc','ksteps','-v7.3');
end


minEvec = zeros(1,ysteps);
for ind = 1:ysteps
%     eps0 = eps0vec(ind);
%     xi = xi0;
    lam = lamvec(ind);
    xi = xi0*sqrt(1+lam^2);
    minE = kspect(lam,xi,kFa,eps0,Nc,ksteps);
    minEvec(ind) = minE;
end
t = toc


filename=strcat('out/oute1-',int2str(blockIndex));
save(filename, 'kFa', 'minEvec', 't', '-v7.3');


fprintf('SUCCESS blockIndex %d\n',blockIndex);
%exit;
