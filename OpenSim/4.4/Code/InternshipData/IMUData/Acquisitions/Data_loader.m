clear all;
close all;
clc;

%% Modèle 

model = "Rajagopal2015.osim";
model_scaled_scaled = "Rajagopal2015_scaled_scaled.osim";

%% Position Initiale

Position_Intiale(model,'positions_init.csv')
Position_Intiale(model_scaled_scaled,'positions_init_scaled_scaled2.csv')


%% Mesure

Mesure(model,'mesures.csv')

Mesure(model_scaled_scaled,'mesures_scaled_scaled2.csv')

%%