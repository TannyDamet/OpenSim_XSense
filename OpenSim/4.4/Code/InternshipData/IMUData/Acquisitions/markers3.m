clc;
clear all;

import org.opensim.modeling.*;

myModel = Model("Rajagopal2015.osim");

bodyset = myModel.getBodySet();

state = myModel.initSystem();

num_bodies = myModel.getNumBodies();

% Créez un modèle de marqueurs virtuels
markerSet = myModel.getMarkerSet();

for i = 0:num_bodies-1
    body = bodyset.get(i);
    bodyName = char(body.getName());
    
    % Créez un nom de marqueur en utilisant le nom du corps
    markerName = ['Marqueur_', bodyName];
    
    % Obtenez la position du corps dans le référentiel du sol
    posBody = body.getPositionInGround(state);
    
    % Ajoutez un marqueur pour le corps
    marker = Marker();
    marker.setName(markerName);
    marker.set_location(Vec3(posBody.get(0), posBody.get(1), posBody.get(2)));
    markerSet.cloneAndAppend(marker);
end

% Le markerSet modifié est automatiquement mis à jour dans le modèle
