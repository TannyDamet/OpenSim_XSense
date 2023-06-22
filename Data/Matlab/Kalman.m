% Importation des données des IMUs
donnees_IMU1 = readmatrix('Bras_Othmane/sagital_1.csv'); % Assurez-vous que le format du fichier est correct
donnees_IMU2 = readmatrix('Bras_Othmane/sagital_2.csv'); % Assurez-vous que le format du fichier est correct

% Extraction des angles d'Euler et des accélérations des IMUs
angles_IMU1 = donnees_IMU1(:, 1:3); % Angles d'Euler IMU 1 (roulis, tangage, lacet)
acc_IMU1 = donnees_IMU1(:, 4:6); % Accélérations IMU 1 (x, y, z)

angles_IMU2 = donnees_IMU2(:, 1:3); % Angles d'Euler IMU 2 (roulis, tangage, lacet)
acc_IMU2 = donnees_IMU2(:, 4:6); % Accélérations IMU 2 (x, y, z)

% Paramètres du filtre de Kalman étendu (EKF)
Q = eye(6); % Matrice de covariance du bruit de processus
R = eye(6); % Matrice de covariance du bruit de mesure
x_initial = zeros(6, 1); % Estimation initiale de l'état [angle_roulis, angle_tangage, angle_lacet, acc_x, acc_y, acc_z]
P_initial = eye(6); % Matrice de covariance initiale de l'état

% Filtrage des données des IMUs avec le filtre de Kalman étendu (EKF)
kf = trackingEKF(@transitionFcn, @measurementFcn, x_initial, P_initial);
kf.ProcessNoise = Q;
kf.MeasurementNoise = R;

% Préparation des variables pour les données filtrées
angles_IMU1_filtre = zeros(size(angles_IMU1));
acc_IMU1_filtre = zeros(size(acc_IMU1));

angles_IMU2_filtre = zeros(size(angles_IMU2));
acc_IMU2_filtre = zeros(size(acc_IMU2));

% Filtrage des données pour chaque instant de temps
for i = 1:size(angles_IMU1, 1)
    [angles_IMU1_filtre(i, :), acc_IMU1_filtre(i, :)] = correct(kf, angles_IMU1(i, :)', acc_IMU1(i, :)');
    [angles_IMU2_filtre(i, :), acc_IMU2_filtre(i, :)] = correct(kf, angles_IMU2(i, :)', acc_IMU2(i, :)');
end

% Exportation des données filtrées
filtered_data_IMU1 = [angles_IMU1_filtre, acc_IMU1_filtre];
filtered_data_IMU2 = [angles_IMU2_filtre, acc_IMU2_filtre];
writematrix(filtered_data_IMU1, 'IMU1_filtered_data.csv');
writematrix(filtered_data_IMU2, 'IMU2_filtered_data.csv');

% Affichage des résultats
t = 1:size(angles_IMU1, 1);
figure;
subplot(2, 1, 1);
plot(t, angles_IMU1(:, 1), 'b', t, angles_IMU1_filtre(:, 1), 'g');
title('IMU 1 - Angle de roulis');
legend('Données brutes', 'Données filtrées');
subplot(2, 1, 2);
plot(t, acc_IMU1(:, 1), 'b', t, acc_IMU1_filtre(:, 1), 'g');
title('IMU 1 - Accélération x');
legend('Données brutes', 'Données filtrées');

figure;
subplot(2, 1, 1);
plot(t, angles_IMU2(:, 1), 'b', t, angles_IMU2_filtre(:, 1), 'g');
title('IMU 2 - Angle de roulis');
legend('Données brutes', 'Données filtrées');
subplot(2, 1, 2);
plot(t, acc_IMU2(:, 1), 'b', t, acc_IMU2_filtre(:, 1), 'g');
title('IMU 2 - Accélération x');
legend('Données brutes', 'Données filtrées');

% Fonction de transition pour le filtre de Kalman étendu (EKF)
function x_pred = transitionFcn(x)
    % À adapter selon votre modèle dynamique
    % Exemple : prédiction de l'état sans modification
    x_pred = x;
end

% Fonction de mesure pour le filtre de Kalman étendu (EKF)
function y_pred = measurementFcn(x)
    % À adapter selon votre modèle de mesure
    % Exemple : retourne directement l'état
    y_pred = x;
end
