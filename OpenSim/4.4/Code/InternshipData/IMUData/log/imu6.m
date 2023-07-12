clc;
clear all;
close all;

% data1 = readmatrix("Xsens_1_20230707_111200_241.csv");
% data2 = readmatrix("Xsens_2_20230707_111200_239.csv");
% data3 = readmatrix("Xsens_3_20230707_111200_242.csv");
% data4 = readmatrix("Xsens_4_20230707_111200_241.csv");
% data5 = readmatrix("Xsens_5_20230707_111200_243.csv");

data1 = readmatrix("Xsens_1.csv");
data2 = readmatrix("Xsens_2.csv");
data3 = readmatrix("Xsens_3.csv");
data4 = readmatrix("Xsens_4.csv");
data5 = readmatrix("Xsens_5.csv");

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

wRi1_est = wRi1w * i1wRi1;
wRi2_est = wRi2w * i2wRi2;
wRi3_est = wRi3w * i3wRi3;
wRi4_est = wRi4w * i4wRi4;
wRi5_est = wRi5w * i5wRi5;

i1wFi1 = rotateFrame(i1wRi1);
wFi1 = rotateFrame(wRi1_est);

i2wFi2 = rotateFrame(i2wRi2);
wFi2 = rotateFrame(wRi2_est);

i3wFi3 = rotateFrame(i3wRi3);
wFi3 = rotateFrame(wRi3_est);

i4wFi4 = rotateFrame(i4wRi4);
wFi4 = rotateFrame(wRi4_est);

i5wFi5 = rotateFrame(i5wRi5);
wFi5 = rotateFrame(wRi5_est);

figure(1)
subplot(2,2,1)
plotFrame(i1wFi1,'o')
title("i1wFi1")
subplot(2,2,2)
plotFrame(wFi1,'s')
title("wFi1")
subplot(2,2,3)
plotFrame(i2wFi2,'o')
title("i2wFi2")
subplot(2,2,4)
plotFrame(wFi2,'s')
title("wFi2")

taille = min([size(quats_1,1), size(quats_2,1), size(quats_3,1), size(quats_4,1), size(quats_5,1)]);
display(taille)

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
for i = 1:1:taille

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

    % imu 1
    i1wFi1 = rotateFrame(i1wRi1);
    wFi1 = rotateFrame(wRi1_est);

    % imu 2
    i2wFi2 = rotateFrame(i2wRi2);
    wFi2 = rotateFrame(wRi2_est);

    % imu 3
    i3wFi3 = rotateFrame(i3wRi3);
    wFi3 = rotateFrame(wRi3_est);

    % imu 4
    i4wFi4 = rotateFrame(i4wRi4);
    wFi4 = rotateFrame(wRi4_est);

    % imu 5
    i5wFi5 = rotateFrame(i5wRi5);
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


    euli1wRi1 = [euli1wRi1; eul2rpy(i1wRi1, 'zyx')];
    euli2wRi2 = [euli2wRi2; eul2rpy(i2wRi2, 'zyx')];
    euli3wRi3 = [euli3wRi3; eul2rpy(i3wRi3, 'zyx')];
    euli4wRi4 = [euli4wRi4; eul2rpy(i4wRi4, 'zyx')];
    euli5wRi5 = [euli5wRi5; eul2rpy(i5wRi5, 'zyx')];

    euliwRi1_est = [euliwRi1_est; eul2rpy(wRi1_est, 'zyx')];
    euliwRi2_est = [euliwRi2_est; eul2rpy(wRi2_est, 'zyx')];
    euliwRi3_est = [euliwRi3_est; eul2rpy(wRi3_est, 'zyx')];
    euliwRi4_est = [euliwRi4_est; eul2rpy(wRi4_est, 'zyx')];
    euliwRi5_est = [euliwRi5_est; eul2rpy(wRi5_est, 'zyx')];

    
%     % Pour l'affichage
% 
%     disp('---------------------')
%     disp(i)
%     disp('---------------------')
% 
%     if mod(i, 1) == 0
%         subplot(2, 5, 1)
%         plotFrame(i1wFi1, 'o')
%         title(sprintf("i1wFi1 %02d", i))
%         subplot(2, 5, 6)
%         plotFrame(wFi1, 's')
%         title(sprintf("wFi1 %02d", i))
% 
%         subplot(2, 5, 2)
%         plotFrame(i2wFi2, 'o')
%         title(sprintf("i2wFi2 %02d", i))
%         subplot(2, 5, 7)
%         plotFrame(wFi2, 's')
%         title(sprintf("wFi2 %02d", i))
% 
%         subplot(2, 5, 3)
%         plotFrame(i3wFi3, 'o')
%         title(sprintf("i3wFi3 %02d", i))
%         subplot(2, 5, 8)
%         plotFrame(wFi3, 's')
%         title(sprintf("wFi3 %02d", i))
% 
%         subplot(2, 5, 4)
%         plotFrame(i4wFi4, 'o')
%         title(sprintf("i4wFi4 %02d", i))
%         subplot(2, 5, 9)
%         plotFrame(wFi4, 's')
%         title(sprintf("wFi4 %02d", i))
% 
%         subplot(2, 5, 5)
%         plotFrame(i5wFi5, 'o')
%         title(sprintf("i5wFi5 %02d", i))
%         subplot(2, 5, 10)
%         plotFrame(wFi5, 's')
%         title(sprintf("wFi5 %02d", i))
%     end
%     pause(0.00001);
end

% Sauvegarder les données modifiées dans de nouveaux fichiers CSV
writematrix(data1, "Xsens_1_modified.csv");
writematrix(data2, "Xsens_2_modified.csv");
writematrix(data3, "Xsens_3_modified.csv");
writematrix(data4, "Xsens_4_modified.csv");
writematrix(data5, "Xsens_5_modified.csv");

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
legend('IMU 1/1', 'IMU 1/W.', 'IMU 2/2', 'IMU 2/W.', 'IMU 3/3', 'IMU 3/W.', 'IMU 4/4', 'IMU 4/W.', 'IMU 5/5', 'IMU 5/W.')
xlabel('Iteration')
ylabel('Euler Angles (degrees)')

function rpy = eul2rpy(R, seq)
rpy = rotm2eul(R, seq);
rpy = rad2deg(rpy);
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
