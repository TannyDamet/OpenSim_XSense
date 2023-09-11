
% clc;
% clear all;
close all;

%% 

% Récupération des données 

data2 = open("DATA\orientatation_2_3\Xsens_2.csv");
data3 = open("DATA\orientatation_2_3\Xsens_3.csv");

textdata2 = data2.textdata;
textdata3 = data3.textdata;


init_shift = 1;

quat0_2 = data2.data(init_shift,3:6);
quats_2 = data2.data(init_shift:end,3:6);
quat0_3 = data3.data(init_shift,3:6);
quats_3 = data3.data(init_shift:end,3:6);

%% etalonnage poure trouver wRixw

wRi0_x = [-1 0 0; 0 0 1; 0 1 0];

i2wRi2 = quat2rotm(quat0_2);
wRi2w = wRi0_x / i2wRi2;

i3wRi3 = quat2rotm(quat0_3);
wRi3w = wRi0_x / i3wRi3;

% utilisation du changement de repere
wRi2_est = wRi2w * i2wRi2;
wRi3_est = wRi3w * i3wRi3;


%% Orientations

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

%% Affichages des repères pour les positions initiales

figure(1)

subplot(2, 2, 1)
plotFrame(i2wFi2,'o')
title("i2wFi2")
subplot(2, 2, 3)
plotFrame(wFi2,'s')
title("wFi2")

subplot(2, 2, 2)
plotFrame(i3wFi3, 'o')
title("i3wFi3")
subplot(2, 2, 4)
plotFrame(wFi3, 's')
title("wFi3")

% check size
taille = min([size(quats_2,1), size(quats_3,1)]);
display(taille)

%% Initialisations

% init
euli2wRi2 = [];
euli3wRi3 = [];

euliwRi2_est = [];
euliwRi3_est = [];


%% Boucle sur toutes les données

figure(2)

for i = 1:taille

    display('---------------------')
    display(i)
    display('---------------------')

    i2wRi2 = quat2rotm(quats_2(i,:));
    i3wRi3 = quat2rotm(quats_3(i,:));

    wRi2_est = wRi2w * i2wRi2;
    wRi3_est = wRi3w * i3wRi3;
    
    euli2wRi2 = [euli2wRi2; euleurDeg(i2wRi2)];
    euli3wRi3 = [euli3wRi3; euleurDeg(i3wRi3)];

    euliwRi2_est = [euliwRi2_est; euleurDeg(wRi2_est)];
    euliwRi3_est = [euliwRi3_est; euleurDeg(wRi3_est)];


     % Récupérer les anciennes accélérations de chaque capteur
    old_acc2 = data2.data(i, 7:9)';
    old_acc3 = data3.data(i, 7:9)';

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

    % Mise à jour de data2
    data2.data(i, 3:6) = rotm2quat(wRi2_est);

    % Mise à jour de data3
    data3.data(i, 3:6) = rotm2quat(wRi3_est);

    % Recalculer les accélérations dans les nouveaux repères
    new_acc2 = wRi2_est * old_acc2;
    new_acc3 = wRi3_est * old_acc3;

    
    % Mettre à jour les valeurs des accélérations dans les matrices de données
    data2.data(i, 7:9) = new_acc2';
    data3.data(i, 7:9) = new_acc3';


    % Pour l'affichage

    if mod(i, 100) == 0

        subplot(2, 2, 1)
        plotFrame(i2wFi2, 'o')
        title(sprintf("i2wFi2 %02d", i))
        subplot(2, 2, 3)
        plotFrame(wFi2, 's')
        title(sprintf("wFi2 %02d", i))

        subplot(2, 2, 2)
        plotFrame(i3wFi3, 'o')
        title(sprintf("i3wFi3 %02d", i))
        subplot(2, 2, 4)
        plotFrame(wFi3, 's')
        title(sprintf("wFi3 %02d", i))

    end

    %    pause(0.00001);
    
    % Mise à jour de data2
    data2.data = data2.data(1:taille, :);

    % Mise à jour de data3
    data3.data = data3.data(1:taille, :);

end

%% Sauvegarder les données modifiées dans de nouveaux fichiers CSV

data2_modified = [textdata2; num2cell(data2.data)];
data3_modified = [textdata3; num2cell(data3.data)];

writecell(data2_modified, "DATA\orientatation_2_3\Xsens_2_modified.csv");
writecell(data3_modified, "DATA\orientatation_2_3\Xsens_3_modified.csv");

%% Evolution des angles d'euler

figure(3)
plot(euli2wRi2, 'g--')
hold on
plot(euliwRi2_est, 'g')
hold on
plot(euli3wRi3, 'b--')
hold on
plot(euliwRi3_est, 'b')
hold on
legend('IMU 2/2_x','IMU 2/2_y','IMU 2/2_z','IMU 2/W_x','IMU 2/W_y','IMU 2/W_z','IMU 3/3_x','IMU 3/3_y','IMU 3/3_z','IMU 3/W_x','IMU 3/W_y','IMU 3/W_z')
xlabel('Iteration')
ylabel('Euler Angles (degrees)')


%% Fonctions 

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
