%%  Created by Brock Brown
%   other header stuff here

%% choose which case here
which = [1,2,3]
if which == 0
    disp("which = 0:  no case run.");
end
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
if any(which == 2)
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
    figure('Name','Velocity Only');
    plot(t,pAct,'r');
    hold on;
    title('Position Estimation from Velocity Readings only');
    plot(t,pvEst,'g');
    legend('Actual Position', 'Estimated Position');
    saveas(gcf,'v.png');
end



%%  using acceleration information only
if any(which == 3)
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
    figure('Name','Acceleration Only');
    plot(t,pAct,'r');
    hold on;
    title('Position Estimation from Acceleration Readings only');
    plot(t,paEst,'g');
    legend('Actual Position', 'Estimated Position');
    saveas(gcf,'a.png');
end



%% using position and velocity



%% using position and acceleration



%% using velocity and acceleration



%% using position and acceleration

