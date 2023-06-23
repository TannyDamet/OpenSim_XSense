clear all; close all; clc;
import org.opensim.modeling.*

model = Model('Modele/Rajagopal2015_opensense_sup_l.osim');

state = model.initSystem();

while true
    % Obtenez les coordonnées du marqueur
    markerCoord = model.getMarkerSet().get('pelvis').getLocationInGround(state);
    
    % Obtenez les coordonnées x, y et z
    x = markerCoord.get(0);
    y = markerCoord.get(1);
    z = markerCoord.get(2);
    
    % Faites quelque chose avec les coordonnées (par exemple, les afficher)
    disp(['Coordonnées (x, y, z) : ', num2str(x), ', ', num2str(y), ', ', num2str(z)]);
    
    % Attendez un certain laps de temps avant de récupérer les coordonnées suivantes
    pause(0.1);
end
