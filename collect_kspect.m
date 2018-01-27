% clear('totalBlocks','eps0min','eps0max','lam','xi0','Nc','ksteps'); 
clear('totalBlocks','lammin','lammax','eps0','xi0','Nc','ksteps');

load('out/oute1-par')

kFavec = [];
time = 0;
% eps0vec = linspace(eps0min,eps0max,ysteps);
lamvec = linspace(lammin,lammax,ysteps);
gapmat = zeros(ysteps,totalBlocks);

for index=1:totalBlocks
    
    % read the output from the jobs
    filename = strcat( 'out/oute1-', int2str(index) );
    load(filename);
    
    kFavec = cat(2,kFavec,kFa);
    gapmat(:,index) = minEvec;
    
    if t > time
        time = t;
    end
end

nhrs = floor(time/3600);
nmins = floor( (time - nhrs*3600)/60 );
sprintf('time = %i h %i min',nhrs,nmins)


figure
% imagesc(kFavec/pi,eps0vec,gapmat)
imagesc(kFavec/pi,lamvec,gapmat)
set(gca,'YDir','normal')
contourcbar;
% title(sprintf('\\lambda=%0.2f, \\xi =%0.0f, N_c=%0.0f, #k=%i^2',lam,xi0,Nc,ksteps),'fontweight','normal','fontsize',9)
title(sprintf('\\epsilon_0=%0.2f, \\xi =%0.0f, N_c=%0.0f, #k=%i^2',eps0,xi0,Nc,ksteps),'fontweight','normal','fontsize',9)
xlabel('k_Fa/\pi')
% ylabel('\epsilon_0')
ylabel('\lambda')



