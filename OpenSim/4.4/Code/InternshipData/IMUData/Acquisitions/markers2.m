clc; clear all;

import org.opensim.modeling.*;

myModel = Model("Rajagopal2015_opensense_sup.osim");

bodyset = myModel.getBodySet();

state = myModel.initSystem();

num_bodies = myModel.getNumBodies();

% Créez un modèle de marqueurs virtuels
markerSet = myModel.getMarkerSet();

% markerSet = MarkerSet();

% Obtenez les indices des corps de l'épaule et du coude
indiceEpaule = bodyset.getIndex('humerus_l');
indiceCoude = bodyset.getIndex('radius_l');
indicePoignet = bodyset.getIndex('hand_l');


% Obtenez les positions de l'épaule et du coude dans le référentiel du sol
posEpaule = bodyset.get(indiceEpaule - 1).getPositionInGround(state);
posCoude = bodyset.get(indiceCoude - 1).getPositionInGround(state);
posPoignet = bodyset.get(indicePoignet - 1).getPositionInGround(state);

% Ajoutez un marqueur pour le coude
markerCoude = Marker();
markerCoude.setName('Marqueur_Coude');
markerCoude.set_location(Vec3(posCoude.get(0), posCoude.get(1), posCoude.get(2)));
markerSet.cloneAndAppend(markerCoude);

% Ajoutez un marqueur pour le poignet
markerPoignet = Marker();
markerPoignet.setName('Marqueur_Poignet');
markerPoignet.set_location(Vec3(posPoignet.get(0), posPoignet.get(1), posPoignet.get(2)));
markerSet.cloneAndAppend(markerPoignet);



