clear all; close all; clc;
import org.opensim.modeling.*

model = Model('Modele/Rajagopal2015_opensense_sup_l.osim');

state = model.initSystem();

% Obtenir le set de coordonnées
coordSet = model.getCoordinateSet();

% Obtenir la coordonnée du poignet par son nom
nom_de_la_coordonnee_du_poignet = 'arm_flex_l';
wristCoord = coordSet.get(nom_de_la_coordonnee_du_poignet);

% Boucle pour récupérer les coordonnées en temps réel
while true
    % Mettre à jour les valeurs cinématiques en fonction des données en temps réel
    % Ici, vous devriez mettre à jour les valeurs de la coordonnée du poignet
    % en utilisant les données en temps réel provenant de votre système de suivi
    
    % Obtenir les valeurs de la coordonnée du poignet
    coordValue = wristCoord.getValue(state);
    
    % Extraire les coordonnées x, y et z
    x = coordValue.get(0);
    y = coordValue.get(1);
    z = coordValue.get(2);
    
    % Afficher les coordonnées x, y et z du poignet
    disp(['Coordonnées du poignet - x: ', num2str(x), ', y: ', num2str(y), ', z: ', num2str(z)]);
end
