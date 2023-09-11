clc; clear all;

import org.opensim.modeling.*;

myModel = Model("Rajagopal2015_opensense_sup.osim");

bodyset = myModel.getBodySet();

state = myModel.initSystem();

num_bodies = myModel.getNumBodies();

% Créez un modèle de marqueurs virtuels
% markerSet = myModel.getMarkerSet();

markerSet = MarkerSet();

for i = 0:num_bodies-1
    body = bodyset.get(i);
    bodyName = char(body.getName());
    
    % Obtenez la position du corps dans le référentiel du sol
    pos = body.getPositionInGround(state);
    
    % Créez un marqueur pour le corps
    marker = Marker();
    marker.setName(['Marqueur_' bodyName]);
    marker.set_location(Vec3(pos.get(0), pos.get(1), pos.get(2)));
    
    % Ajoutez le marqueur à l'ensemble de marqueurs
    markerSet.cloneAndAppend(marker);
    
    % Enregistrez les informations du corps et du marqueur dans la cellule
    corpsMarqueurs{i+1, 1} = bodyName;
    corpsMarqueurs{i+1, 2} = marker;
    corpsMarqueurs{i+1, 3} = false; % Par défaut, les marqueurs ne sont pas fixes
end

% Ajoutez les corps et les marqueurs au modèle
for i = 1:num_bodies
    bodyName = corpsMarqueurs{i, 1};
    body = bodyset.get(bodyName);
    marker = corpsMarqueurs{i, 2};
    isFixed = corpsMarqueurs{i, 3};
    
    % Ajoutez le marqueur au corps
    body.upd_MarkerSet(22).adoptAndAppend(marker);
    
    % Définissez la fixation du marqueur
    marker.set_fixed(isFixed);
end


% myModel.getGround().updMarkerSet().append(markerSet);

% Enregistrez les marqueurs dans un fichier XML
markerSet.print("marqueurs.xml");
















% % Obtenez les indices des corps de l'épaule et du coude
% indiceEpaule = bodyset.getIndex('humerus_l');
% indiceCoude = bodyset.getIndex('radius_l');
% indicePoignet = bodyset.getIndex('hand_l');
% 
% % Obtenez les positions de l'épaule et du coude dans le référentiel du sol
% posEpaule = bodyset.get(indiceEpaule - 1).getPositionInGround(state);
% posCoude = bodyset.get(indiceCoude - 1).getPositionInGround(state);
% posPoignet = bodyset.get(indicePoignet - 1).getPositionInGround(state);
% 
% % Ajoutez un marqueur pour le coude
% markerCoude = Marker();
% markerCoude.setName('Marqueur_Coude');
% markerCoude.set_location(Vec3(posCoude.get(0), posCoude.get(1), posCoude.get(2)));
% markerSet.cloneAndAppend(markerCoude);
% 
% % Ajoutez un marqueur pour le poignet
% markerPoignet = Marker();
% markerPoignet.setName('Marqueur_Poignet');
% markerPoignet.set_location(Vec3(posPoignet.get(0), posPoignet.get(1), posPoignet.get(2)));
% markerSet.cloneAndAppend(markerPoignet);

% Ajoutez le jeu de marqueurs au modèle
% myModel.append_MarkerSet(markerSet);
% myModel.getGround().updMarkerSet().append(markerSet);

% % Affichez le modèle avec les marqueurs
% model.updVisualizer().showGround(true);
% model.updVisualizer().setBackgroundColor([1, 1, 1]);
% model.updVisualizer().drawFrameNow(state);
