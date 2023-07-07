clc; clear all;

import org.opensim.modeling.*;

myModel = Model("Rajagopal2015_opensense.osim");

bodyset = myModel.getBodySet();

state = myModel.initSystem();

% Obtenez les indices des corps de l'épaule et du coude
indiceEpaule = bodyset.getIndex('humerus_l');
indiceEpaule_r = bodyset.getIndex('humerus_r');
indiceCoude_1 = bodyset.getIndex('radius_l');
indiceCoude_2 = bodyset.getIndex('ulna_l');
indicePoignet = bodyset.getIndex('hand_l');

% Obtenez les positions de l'épaule et du coude dans le référentiel du sol
posEpaule = bodyset.get(indiceEpaule).getPositionInGround(state);
posEpaule_r = bodyset.get(indiceEpaule_r).getPositionInGround(state);
posCoude_1 = bodyset.get(indiceCoude_1).getPositionInGround(state);
posCoude_2 = bodyset.get(indiceCoude_2).getPositionInGround(state);
posPoignet = bodyset.get(indicePoignet).getPositionInGround(state);

% Calculez la distance entre l'épaule et le coude
distance_Epaule_Coude_1 = norm([posEpaule.get(0) - posCoude_1.get(0), posEpaule.get(1) - posCoude_1.get(1), posEpaule.get(2) - posCoude_1.get(2)])
distance_Epaule_Coude_2 = norm([posEpaule.get(0) - posCoude_2.get(0), posEpaule.get(1) - posCoude_2.get(1), posEpaule.get(2) - posCoude_2.get(2)])
% Calculez la distance entre le coude et le poignet
distance_coude_1_poignet = norm([posCoude_1.get(0) - posPoignet.get(0), posCoude_1.get(1) - posPoignet.get(1), posCoude_1.get(2) - posPoignet.get(2)])
distance_coude_2_poignet = norm([posCoude_2.get(0) - posPoignet.get(0), posCoude_2.get(1) - posPoignet.get(1), posCoude_2.get(2) - posPoignet.get(2)])
% Calculez la distance entre le coude et le poignet
distance_Epaule_poignet = norm([posEpaule.get(0) - posPoignet.get(0), posEpaule.get(1) - posPoignet.get(1), posEpaule.get(2) - posPoignet.get(2)])
% Calculez la distance entre l'épaule gauche et l'épaule droite
distance_Epaule_l_Epaule_r = norm([posEpaule.get(0) - posEpaule_r.get(0), posEpaule.get(1) - posEpaule_r.get(1), posEpaule.get(2) - posEpaule_r.get(2)])
