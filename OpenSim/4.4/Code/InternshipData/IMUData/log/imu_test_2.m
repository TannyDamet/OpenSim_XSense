clc;
clear all;
close all;

% data1 = readmatrix("3\Xsens_1.csv");
% data2 = readmatrix("3\Xsens_2.csv");
% data3 = readmatrix("3\Xsens_3.csv");
% data4 = readmatrix("3\Xsens_4.csv");
% data5 = readmatrix("3\Xsens_5.csv");

data1 = readmatrix("pos_init_2\Xsens_1.csv");
data2 = readmatrix("pos_init_2\Xsens_2.csv");
data3 = readmatrix("pos_init_2\Xsens_3.csv");
data4 = readmatrix("pos_init_2\Xsens_4.csv");
data5 = readmatrix("pos_init_2\Xsens_5.csv");

init_shift = 1;

quat0_1 = data1(init_shift, 3:6);
quats_1 = data1(init_shift:end, 3:6);
quat0_2 = data2(init_shift, 3:6);
quats_2 = data2(init_shift:end, 3:6);
quat0_3 = data3(init_shift, 3:6);
quats_3 = data3(init_shift:end, 3:6);
quat0_4 = data4(init_shift, 3:6);
quats_4 = data4(init_shift:end, 3:6);
quat0_5 = data5(init_shift, 3:6);
quats_5 = data5(init_shift:end, 3:6);

% etalonnage poure trouver wRixw
wRi0_x = [-1 0 0; 0 0 1; 0 1 0];

i1wRi1 = quat2rotm(quat0_1);
wRi1w = wRi0_x / i1wRi1;

i2wRi2 = quat2rotm(quat0_2);
wRi2w = wRi0_x / i2wRi2;

i3wRi3 = quat2rotm(quat0_3);
wRi3w = wRi0_x / i3wRi3;

i4wRi4 = quat2rotm(quat0_4);
wRi4w = wRi0_x / i4wRi4;

i5wRi5 = quat2rotm(quat0_5);
wRi5w = wRi0_x / i5wRi5;

% utilisation du changement de repere
wRi1_est = wRi1w * i1wRi1;
wRi2_est = wRi2w * i2wRi2;
wRi3_est = wRi3w * i3wRi3;
wRi4_est = wRi4w * i4wRi4;
wRi5_est = wRi5w * i5wRi5;

% IMU 1

% orientation de l'imu dans son repere propre
i1wFi1 = rotateFrame(i1wRi1);
% orientation de l'imu dans le repere monde
wFi1 = rotateFrame(wRi1_est);

% IMU 2

% orientation de l'imu dans son repere propre
i2wFi2 = rotateFrame(i2wRi2);
% orientation de l'imu dans le repere monde
wFi2 = rotateFrame(wRi2_est);

% IMU 3

% orientation de l'imu dans son repere propre
i3wFi3 = rotateFrame(i3wRi3);
% orientation de l'imu dans le repere monde
wFi3 = rotateFrame(wRi3_est);

% IMU 4

% orientation de l'imu dans son repere propre
i4wFi4 = rotateFrame(i4wRi4);
% orientation de l'imu dans le repere monde
wFi4 = rotateFrame(wRi4_est);

% IMU 5

% orientation de l'imu dans son repere propre
i5wFi5 = rotateFrame(i5wRi5);
% orientation de l'imu dans le repere monde
wFi5 = rotateFrame(wRi5_est);

figure(1)

subplot(2, 5, 1)
plotFrame(i1wFi1,'o')
title("i1wFi1")
subplot(2, 5, 6)
plotFrame(wFi1, 's')
title("wFi1")

subplot(2, 5, 2)
plotFrame(i2wFi2,'o')
title("i2wFi2")
subplot(2, 5, 7)
plotFrame(wFi2,'s')
title("wFi2")

subplot(2, 5, 3)
plotFrame(i3wFi3, 'o')
title("i3wFi3")
subplot(2, 5, 8)
plotFrame(wFi3, 's')
title("wFi3")

subplot(2, 5, 4)
plotFrame(i4wFi4, 'o')
title("i4wFi4")
subplot(2, 5, 9)
plotFrame(wFi4, 's')
title("wFi4")

subplot(2, 5, 5)
plotFrame(i5wFi5, 'o')
title("i5wFi5")
subplot(2, 5, 10)
plotFrame(wFi5, 's')
title("wFi5")

% check size
taille = min([size(quats_1,1), size(quats_2,1), size(quats_3,1), size(quats_4,1), size(quats_5,1)]);
display(taille)

% init
euli1wRi1 = [];
euli2wRi2 = [];
euli3wRi3 = [];
euli4wRi4 = [];
euli5wRi5 = [];

euliwRi1_est = [];
euliwRi2_est = [];
euliwRi3_est = [];
euliwRi4_est = [];
euliwRi5_est = [];

figure(2)

for i = 1:taille

    display('---------------------')
    display(i)
    display('---------------------')

    i1wRi1 = quat2rotm(quats_1(i,:));
    i2wRi2 = quat2rotm(quats_2(i,:));
    i3wRi3 = quat2rotm(quats_3(i,:));
    i4wRi4 = quat2rotm(quats_4(i,:));
    i5wRi5 = quat2rotm(quats_5(i,:));

    wRi1_est = wRi1w * i1wRi1;
    wRi2_est = wRi2w * i2wRi2;
    wRi3_est = wRi3w * i3wRi3;
    wRi4_est = wRi4w * i4wRi4;
    wRi5_est = wRi5w * i5wRi5;

    euli1wRi1 = [euli1wRi1; euleurDeg(i1wRi1)];
    euli2wRi2 = [euli2wRi2; euleurDeg(i2wRi2)];
    euli3wRi3 = [euli3wRi3; euleurDeg(i3wRi3)];
    euli4wRi4 = [euli4wRi4; euleurDeg(i4wRi4)];
    euli5wRi5 = [euli5wRi5; euleurDeg(i5wRi5)];

    euliwRi1_est = [euliwRi1_est; euleurDeg(wRi1_est)];
    euliwRi2_est = [euliwRi2_est; euleurDeg(wRi2_est)];
    euliwRi3_est = [euliwRi3_est; euleurDeg(wRi3_est)];
    euliwRi4_est = [euliwRi4_est; euleurDeg(wRi4_est)];
    euliwRi5_est = [euliwRi5_est; euleurDeg(wRi5_est)];

    % IMU 1

    % orientation de l'imu dans son repere propre
    i1wFi1 = rotateFrame(i1wRi1);
    % orientation de l'imu dans le repere monde
    wFi1 = rotateFrame(wRi1_est);

    % IMU 2

    % orientation de l'imu dans son repere propre
    i2wFi2 = rotateFrame(i2wRi2);
    % orientation de l'imu dans le repere monde
    wFi2 = rotateFrame(wRi2_est);

    % IMU 3

    % orientation de l'imu dans son repere propre
    i3wFi3 = rotateFrame(i3wRi3);
    % orientation de l'imu dans le repere monde
    wFi3 = rotateFrame(wRi3_est);

    % IMU 4

    % orientation de l'imu dans son repere propre
    i4wFi4 = rotateFrame(i4wRi4);
    % orientation de l'imu dans le repere monde
    wFi4 = rotateFrame(wRi4_est);

    % IMU 5

    % orientation de l'imu dans son repere propre
    i5wFi5 = rotateFrame(i5wRi5);
    % orientation de l'imu dans le repere monde
    wFi5 = rotateFrame(wRi5_est);

    % Mise à jour de data1
    data1(i, 3:6) = rotm2quat(wRi1_est);

    % Mise à jour de data2
    data2(i, 3:6) = rotm2quat(wRi2_est);

    % Mise à jour de data3
    data3(i, 3:6) = rotm2quat(wRi3_est);

    % Mise à jour de data4
    data4(i, 3:6) = rotm2quat(wRi4_est);

    % Mise à jour de data5
    data5(i, 3:6) = rotm2quat(wRi5_est);

    % Pour l'affichage

    if mod(i, 10) == 0
        subplot(2, 5, 1)
        plotFrame(i1wFi1, 'o')
        title(sprintf("i1wFi1 %02d", i))
        subplot(2, 5, 6)
        plotFrame(wFi1, 's')
        title(sprintf("wFi1 %02d", i))

        subplot(2, 5, 2)
        plotFrame(i2wFi2, 'o')
        title(sprintf("i2wFi2 %02d", i))
        subplot(2, 5, 7)
        plotFrame(wFi2, 's')
        title(sprintf("wFi2 %02d", i))

        subplot(2, 5, 3)
        plotFrame(i3wFi3, 'o')
        title(sprintf("i3wFi3 %02d", i))
        subplot(2, 5, 8)
        plotFrame(wFi3, 's')
        title(sprintf("wFi3 %02d", i))

        subplot(2, 5, 4)
        plotFrame(i4wFi4, 'o')
        title(sprintf("i4wFi4 %02d", i))
        subplot(2, 5, 9)
        plotFrame(wFi4, 's')
        title(sprintf("wFi4 %02d", i))

        subplot(2, 5, 5)
        plotFrame(i5wFi5, 'o')
        title(sprintf("i5wFi5 %02d", i))
        subplot(2, 5, 10)
        plotFrame(wFi5, 's')
        title(sprintf("wFi5 %02d", i))
    end

    %    pause(0.00001);
    
    % Mise à jour de data1
    data1 = data1(1:taille, :);

    % Mise à jour de data2
    data2 = data2(1:taille, :);

    % Mise à jour de data3
    data3 = data3(1:taille, :);

    % Mise à jour de data4
    data4 = data4(1:taille, :);

    % Mise à jour de data5
    data5 = data5(1:taille, :);

end

eulwRi1w = euleurDeg(wRi1w);
eulwRi2w = euleurDeg(wRi2w);
eulwRi3w = euleurDeg(wRi3w);
eulwRi4w = euleurDeg(wRi4w);
eulwRi5w = euleurDeg(wRi5w);

euler = [eulwRi1w;eulwRi2w;eulwRi3w;eulwRi4w;eulwRi5w]

% Sauvegarder les données modifiées dans de nouveaux fichiers CSV
% writematrix(data1, "3\Xsens_1_modified.csv");
% writematrix(data2, "3\Xsens_2_modified.csv");
% writematrix(data3, "3\Xsens_3_modified.csv");
% writematrix(data4, "3\Xsens_4_modified.csv");
% writematrix(data5, "3\Xsens_5_modified.csv");

writematrix(data1, "pos_init_2\Xsens_1_modified.csv");
writematrix(data2, "pos_init_2\Xsens_2_modified.csv");
writematrix(data3, "pos_init_2\Xsens_3_modified.csv");
writematrix(data4, "pos_init_2\Xsens_4_modified.csv");
writematrix(data5, "pos_init_2\Xsens_5_modified.csv");

figure(3)
plot(euli1wRi1, 'r--')
hold on
plot(euliwRi1_est, 'r')
hold on
plot(euli2wRi2, 'g--')
hold on
plot(euliwRi2_est, 'g')
hold on
plot(euli3wRi3, 'b--')
hold on
plot(euliwRi3_est, 'b')
hold on
plot(euli4wRi4, 'k--')
hold on
plot(euliwRi4_est, 'k')
hold on
plot(euli5wRi5, 'y--')
hold on
plot(euliwRi5_est, 'y')
hold on
legend('IMU 1/1_x','IMU 1/1_y','IMU 1/1_z','IMU 1/W_x','IMU 1/W_y','IMU 1/W_z','IMU 2/2_x','IMU 2/2_y','IMU 2/2_z','IMU 2/W_x','IMU 2/W_y','IMU 2/W_z','IMU 3/3_x','IMU 3/3_y','IMU 3/3_z','IMU 3/W_x','IMU 3/W_y','IMU 3/W_z','IMU 4/4_x','IMU 4/4_y','IMU 4/4_z','IMU 4/W_x','IMU 4/W_y','IMU 4/W_z','IMU 5/5_x','IMU 5/5_y','IMU 5/5_z','IMU 5/W_x','IMU 5/W_y','IMU 5/W_z')
xlabel('Iteration')
ylabel('Euler Angles (degrees)')

function euler_deg =euleurDeg(R)
euler_deg = rad2deg(rotm2eul(R));
end


function rF = rotateFrame(wRi)
zero = [0,0,0];
x = [1,0,0];
y = [0,1,0];
z = [0,0,1];

xr = wRi * x';
yr = wRi * y';
zr = wRi * z';

rF = [xr'; yr'; zr'; zero];
end

function plotFrame(rF, shape)
plot3(rF(1,1), rF(1,2), rF(1,3), strcat('r', shape))
hold on
grid on
axis([-1 1 -1 1 -1 1])
xlabel('x')
ylabel('y')
zlabel('z')
plot3(rF(2,1), rF(2,2), rF(2,3), strcat('g', shape))
plot3(rF(3,1), rF(3,2), rF(3,3), strcat('b', shape))
plot3([rF(4,1); rF(1,1)], [rF(4,2); rF(1,2)], [rF(4,3); rF(1,3)], 'r')
plot3([rF(4,1); rF(2,1)], [rF(4,2); rF(2,2)], [rF(4,3); rF(2,3)], 'g')
plot3([rF(4,1); rF(3,1)], [rF(4,2); rF(3,2)], [rF(4,3); rF(3,3)], 'b')
end
