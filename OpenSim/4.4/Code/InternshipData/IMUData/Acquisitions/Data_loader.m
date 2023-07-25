clear all;
close all;
clc;

%% Modèle 

model = "Rajagopal2015.osim";

%% Position Initiale

Chemin_Fichier = "positions_init.csv";

Position_Intiale(model,Chemin_Fichier)

%% Mesure

Mesure(model)
