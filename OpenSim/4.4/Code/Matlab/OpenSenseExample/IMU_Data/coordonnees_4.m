clear all; close all; clc;
import org.opensim.modeling.*

model = Model('Modele/Rajagopal2015_opensense_sup_l.osim');

% Créer un solveur de cinématique inverse
ikSolver = org.opensim.modeling.InverseKinematicsSolver(model);

% Définir les paramètres de cinématique inverse
ikTool = ikSolver.getIKTool();
ikTool.setStartTime(0);
ikTool.setEndTime(1); % Durée de la simulation en secondes

% Ajouter le marker pour le poignet (par exemple)
markerName = 'wrist_marker'; % Nom du marker pour le poignet
marker = org.opensim.modeling.Marker();
marker.setName(markerName);
ikTool.getMarkers().adoptAndAppend(marker);

% Définir le fichier de sortie pour enregistrer les résultats
outputFile = 'chemin_vers_le_fichier_de_sortie.trc';
ikTool.setMarkerDataFileName(outputFile);

% Exécuter la cinématique inverse
ikSolver.assemble(osimModel);

% Récupérer les coordonnées x, y et z du poignet dans le fichier de sortie
data = org.opensim.modeling.Storage(outputFile);
time = org.opensim.modeling.ArrayDouble();
x = org.opensim.modeling.ArrayDouble();
y = org.opensim.modeling.ArrayDouble();
z = org.opensim.modeling.ArrayDouble();
data.getTimeColumn(time);
data.getDataColumn([markerName '_x'], x);
data.getDataColumn([markerName '_y'], y);
data.getDataColumn([markerName '_z'], z);

% Afficher les coordonnées du poignet à chaque instant
numFrames = time.getSize();
for i = 0:numFrames-1
    fprintf('Temps : %.2fs, Coordonnées du poignet : x = %.2f, y = %.2f, z = %.2f\n', ...
        time.get(i), x.get(i), y.get(i), z.get(i));
end
