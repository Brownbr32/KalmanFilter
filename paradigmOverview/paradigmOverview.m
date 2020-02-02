%%  Created by Brock Brown
%   other header stuff here

%% choose which case here
which = [1,2,4]
if any(which == 0)
    disp("which = 0:  no case run.");
end
close all
%%  initial variables set
dt = .1;
duration = 10;
t = 0:dt:duration;
sz_t = size(t);
sz_t = sz_t(2);
p_init = 0;
v_init = 0;
a_init = 1;
pAct = a_init/2*t.^2 + v_init*t + p_init;
vAct = a_init*t + v_init;
pstd = 3;
vstd = 3;
astd = 3;


%%  using position information only
if any(which == 1)
    pEst = pAct + pstd*randn(size(t));
    figure('Name','Position Only');
    plot(t,pAct,'r');
    hold on;
    plot(t,pEst,'g');
    title('Position Estimation from Current Position Readings only');
    legend('Actual Position', 'Estimated Position');
    saveas(gcf,'p.png');
end



%%  using velocity information only
if any(which == 2) || any(which == 4)
    vEst = zeros(size(t));
    pvEst = zeros(size(t));
    for i = 1:sz_t
        vEst(i) = vAct(i) + vstd*randn();
        if i>1
            pvEst(i) = pvEst(i-1) + vEst(i-1)*dt;
        else
            pvEst(i) = 0;
        end
    end
    if any(which == 2)
        figure('Name','Velocity Only');
        plot(t,pAct,'r');
        hold on;
        title('Position Estimation from Velocity Readings only');
        plot(t,pvEst,'g');
        legend('Actual Position', 'Estimated Position');
        saveas(gcf,'v.png');
    end
end



%%  using acceleration information only
if any(which == 3) || any(which == 5)
    aEst = zeros(size(t));
    paEst = zeros(size(t));
    vaEst = zeros(size(t));
    for i = 1:sz_t
        aEst(i) = a_init + astd*randn();
        if i>1
            vaEst(i) = vaEst(i-1) + aEst(i-1)*dt;
            paEst(i) = paEst(i-1) + vaEst(i-1)*dt;
        else
            paEst(i) = 0;
        end
    end
    if any(which == 3)
        figure('Name','Acceleration Only');
        plot(t,pAct,'r');
        hold on;
        title('Position Estimation from Acceleration Readings only');
        plot(t,paEst,'g');
        legend('Actual Position', 'Estimated Position');
        saveas(gcf,'a.png');
    end
end



%% using position and velocity, show norm of predict
if any(which == 4)
    pEst = pAct + pstd*randn(size(t));
    fAct = pAct(sz_t);
    fMeas = fAct + pstd*randn();
    x = fAct-9:.01:fAct+9;
    
    fpvMeas = pvEst(sz_t);
    
    
    % getting distributions
    fActPdf     = normpdf(x,fAct,0.001);
    fMeasPdf    = normpdf(x,fMeas,pstd);
    fpvMeasPdf  = normpdf(x,fpvMeas,vstd);
    fpvEstPdf   = fMeasPdf.*fpvMeasPdf; % *This needs work!!
    
    %scaling distributions
    fActPdf     = fActPdf/max(fActPdf);
    fMeasPdf = fMeasPdf/max(fMeasPdf);
    fpvMeasPdf = fpvMeasPdf/max(fpvMeasPdf);
    fpvEstPdf = fpvEstPdf/max(fpvEstPdf);
    
    %graphing distributions
    
    figure('Name','Acceleration Only');
    plot(x,fActPdf,'k');
    hold on;
    plot(x,fMeasPdf,'r');
    hold on;
    plot(x,fpvMeasPdf,'b');
    hold on;
    plot(x,fpvEstPdf,'g');
    title('Final Position Estimation from Position, Velocity, and Combination');
    legend('Actual Final Position', 'Position-based estimation', 'Velocity-based estimation', 'Position-Velocity-based estimation');
    saveas(gcf,'pv.png');
    
    disp("Not done yet. Sorry!");
end


%% using position and acceleration



%% using velocity and acceleration



%% using position, velocity, and acceleration
if any(which == 7)
    disp("Not done yet. Sorry");
end

