clc; clear all; close all;

Xsens_data = [90];

% Récupération des données 

% data1 = open("Tanny_Calib + D2\Xsens_1.csv");

% init_shift = 1;

% quat0_1 = data1.data(init_shift,3:6);
% quats_1 = data1.data(init_shift:end,3:6);

quat0_1 = []
quat0_1 = []
%% etalonnage poure trouver wRixw

wRi0_x = [-1 0 0; 0 0 1; 0 1 0];

i1wRi1 = quat2rotm(quat0_1);
wRi1w = wRi0_x / i1wRi1;

% utilisation du changement de repere
wRi1_est = wRi1w * i1wRi1;


%% Orientations

% IMU 1

% orientation de l'imu dans son repere propre
i1wFi1 = rotateFrame(i1wRi1);
% orientation de l'imu dans le repere monde
wFi1 = rotateFrame(wRi1_est);

%% Affichages des repères pour les positions initiales

figure(1)

subplot(2, 1, 1)
plotFrame(i1wFi1,'o')
title("i1wFi1")
subplot(2, 1, 2)
plotFrame(wFi1, 's')
title("wFi1")


%% Initialisations

% init
euli1wRi1 = [];

euliwRi1_est = [];

taille = size(quats_1,1);
display(taille)

%% Boucle sur toutes les données

figure(2)

for i = 1:taille

    display('---------------------')
    display(i)
    display('---------------------')

    i1wRi1 = quat2rotm(quats_1(i,:));
   
    wRi1_est = wRi1w * i1wRi1;
    
    euli1wRi1 = [euli1wRi1; euleurDeg(i1wRi1)];

    euliwRi1_est = [euliwRi1_est; euleurDeg(wRi1_est)];

    % IMU 1

    % orientation de l'imu dans son repere propre
    i1wFi1 = rotateFrame(i1wRi1);
    % orientation de l'imu dans le repere monde
    wFi1 = rotateFrame(wRi1_est);

    % Mise à jour de data1
    data1.data(i, 3:6) = rotm2quat(wRi1_est);

    % Pour l'affichage

    if mod(i, 500) == 0
        subplot(2, 1, 1)
        plotFrame(i1wFi1, 'o')
        title(sprintf("i1wFi1 %02d", i))
        subplot(2, 1, 2)
        plotFrame(wFi1, 's')
        title(sprintf("wFi1 %02d", i))
    end

    %    pause(0.00001);

end

%% Evolution des angles d'euler

figure(3)
plot(euli1wRi1(:,1),'r--')
hold on
plot(euli1wRi1(:,2),'g--')
hold on
plot(euli1wRi1(:,3),'b--')
hold on
plot(euliwRi1_est(:,1),'r')
hold on
plot(euliwRi1_est(:,2),'g')
hold on
plot(euliwRi1_est(:,3),'b')
hold on
legend('IMU 1/1_x','IMU 1/1_y','IMU 1/1_z','IMU 1/W_x','IMU 1/W_y','IMU 1/W_z');
xlabel('Iteration')
ylabel('Euler Angles (degrees)')
