clear all; close all; clc;
import org.opensim.modeling.*

model = Model('Modele/Rajagopal2015_opensense_sup_l.osim');

state = model.initSystem();

% coordSet = model.getCoordinateSet();
% hipCoord = coordSet.get('hip_flexion_l');
% hipValue = hipCoord.getValue(state);

% Trouver l'articulation du coude
elbowJoint = model.getJointSet().get('elbow_l');

% % Obtenir les coordonnées du coude
% elbowCoordinates = elbowJoint.get_coordinates(0);
% elbowPosition = elbowCoordinates.getValue(state);
% % Afficher la position du coude
% disp(['Position du coude (x, y, z): ' num2str(elbowPosition(1)) ', ' num2str(elbowPosition(2)) ', ' num2str(elbowPosition(3))]);

%______________________________________________________________________________________________________

% Obtenir le corps attaché à l'articulation du coude
elbowBody = elbowJoint.getChildFrame();

% Obtenir la position du coude dans le repère global
elbowPosition = elbowBody.getLocationInGround(state);

% Afficher la position du coude
disp(['Position du coude (x, y, z): ' num2str(elbowPosition.get(0)) ', ' num2str(elbowPosition.get(1)) ', ' num2str(elbowPosition.get(2))]);

