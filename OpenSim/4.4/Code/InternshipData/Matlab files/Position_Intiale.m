function Position_Intiale(model,Chemin_Fichier)

import org.opensim.modeling.*;

myModel = Model(model);

bodyset = myModel.getBodySet();

state = myModel.initSystem();

num_bodies = myModel.getNumBodies();

position = zeros(num_bodies, 4);

for i = 0:num_bodies-1
    body = bodyset.get(i);
    pos = body.getPositionInGround(state);
    position(i+1, :) = [i, pos.get(0), pos.get(1), pos.get(2)];
end

% Créer une cellule pour stocker les noms des corps
nomsCorps = cell(num_bodies, 1);
for i = 0:num_bodies-1
    body = bodyset.get(i);
    nomsCorps{i+1} = char(body.getName()); % Convertir le nom du corps en chaîne de caractères
end


nomFichier = Chemin_Fichier;

writematrix(position, nomFichier);

% Ouvrir le fichier en écriture
fid = fopen(nomFichier, 'w');

% Écrire les en-têtes des colonnes
fprintf(fid, 'Nom du corps, Position X, Position Y, Position Z\n');

% Écrire les positions initiales avec les noms des corps
for i = 1:num_bodies
    fprintf(fid, '%s, %f, %f, %f\n', nomsCorps{i}, position(i, 2), position(i, 3), position(i, 4));
end

% Fermer le fichier
fclose(fid);

end
