clc; close all; clear all;

% Chemins d'accès aux fichiers d'entrée et de sortie
IMU_1 = 'Bras_Othmane/sagital_1.csv';
IMU_1_sortie = 'Bras_Othmane/sagital_filtré_1.csv';

IMU_2 = 'Bras_Othmane/sagital_2.csv';
IMU_2_sortie = 'Bras_Othmane/sagital_filtré_2.csv';

% Paramètres du filtre
ordre = 2;
frequenceCoupure = 10; % Fréquence de coupure en Hz

% Importation des données d'entrée
donnees_1 = readmatrix(IMU_1); % Assurez-vous que le format du fichier est correct
donnees_2 = readmatrix(IMU_2); % Assurez-vous que le format du fichier est correct

% Extraction des signaux d'accélération linéaire des IMUs (à adapter selon vos données)
acc_IMU1 = donnees_1(:, 6:8); % Accélération linéaire IMU 1 (x, y, z)
acc_IMU2 = donnees_2(:, 6:8); % Accélération linéaire IMU 2 (x, y, z)

% Détermination de la fréquence d'échantillonnage
fs = 100; % Remplacez par la fréquence d'échantillonnage réelle de vos données

% Filtrage des signaux d'accélération linéaire
[~,b,a] = butter(ordre, frequenceCoupure/(fs/2)); % Calcul des coefficients du filtre
acc_IMU1_filtre = filtfilt(b, a, acc_IMU1); % Filtrage du signal acc_IMU1
acc_IMU2_filtre = filtfilt(b, a, acc_IMU2); % Filtrage du signal acc_IMU2

% Préparation des données filtrées pour l'exportation
donnees_filtrees_1 = acc_IMU1_filtre;
donnees_filtrees_2 = acc_IMU2_filtre; % Concaténation des signaux filtrés

% Exportation des données filtrées
writematrix(donnees_filtrees_1, IMU_1_sortie); % Assurez-vous que le format de sortie est compatible
writematrix(donnees_filtrees_2, IMU_2_sortie); % Assurez-vous que le format de sortie est compatible

% Affichage des résultats
figure;
t1 = (1:size(acc_IMU1, 1)) / fs; % Temps en secondes
subplot(2, 1, 1);
plot(t1, acc_IMU1, 'b', t1, acc_IMU1_filtre, 'r');
title('IMU 1 - Accélération linéaire');
legend('Données brutes', 'Données filtrées');
t2 = (1:size(acc_IMU2, 1)) / fs; % Temps en secondes
subplot(2, 1, 2);
plot(t2, acc_IMU2, 'b', t2, acc_IMU2_filtre, 'r');
title('IMU 2 - Accélération linéaire');
legend('Données brutes', 'Données filtrées');
