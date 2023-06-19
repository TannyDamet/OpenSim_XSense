clc; close all; clear all;

% Importation des données à partir d'un fichier CSV
data_1 = readmatrix('Bras_Othmane/sagital_1.csv');
%data_2 = readmatrix('Bras_Othmane/sagital_2.csv');

% Extraction des colonnes de données
temps = data_1(:, 1);
signal_1 = data_1(:, 2);
%signal_2 = data_2(:, 2);

% Filtrage du signal à l'aide d'un filtre passe-bas
frequenceCoupure = 10; % Définir la fréquence de coupure appropriée
frequenceEchantillonnage = 100; % Définir la fréquence d'échantillonnage appropriée
[b, a] = butter(2, frequenceCoupure / (frequenceEchantillonnage / 2), 'low');
signalFiltre_1 = filtfilt(b, a, signal_1);
%signalFiltre_2 = filtfilt(b, a, signal_2);

% Affichage des données d'origine et filtrées
figure;
subplot(2, 1, 1);
plot(temps, signal_1);
%plot(temps, signal_2);

title('Signal d''origine');
xlabel('Temps');
ylabel('Amplitude');
subplot(2, 1, 2);
plot(temps, signalFiltre_1);
%plot(temps, signalFiltre_2);
title('Signal filtré');
xlabel('Temps');
ylabel('Amplitude');
