function Tableau_de_mesure = Mesure(model,cheminFichier)

import org.opensim.modeling.*;

myModel = Model(model);

bodyset = myModel.getBodySet();

state = myModel.initSystem();

% Noms spécifiés dans l'ordre souhaité
noms_specifies = {'Epaule_Coude (Radius)', 'Epaule_Coude (Cubitus)', 'Coude_Poignet (Radius)', 'Coude_Poignet (Cubitus)', 'Epaule_Poignet', 'Epaule_gauche_droite', 'Hanche_Genou', 'Genou_Cheville', 'Hanche_Cheville','Hanche_gauche_droite'};

% Créez une structure pour stocker les noms et les valeurs des distances
mesures = struct('Nom', {}, 'Distance', {});

% Obtenez les indices des corps de l'épaule et du coude
indiceEpaule_l = bodyset.getIndex('humerus_l');
indiceEpaule_r = bodyset.getIndex('humerus_r');
indiceCoude_1_l = bodyset.getIndex('radius_l');
indiceCoude_2_l = bodyset.getIndex('ulna_l');
indicePoignet_l = bodyset.getIndex('hand_l');

indiceHanche_l = bodyset.getIndex('femur_l');
indiceHanche_r = bodyset.getIndex('femur_r');
indiceGenou_l = bodyset.getIndex('tibia_l');
indiceCheville_l = bodyset.getIndex('calcn_l');

% Obtenez les positions de l'épaule et du coude dans le référentiel du sol
posEpaule_l = bodyset.get(indiceEpaule_l).getPositionInGround(state);
posEpaule_r = bodyset.get(indiceEpaule_r).getPositionInGround(state);
posCoude_1_l = bodyset.get(indiceCoude_1_l).getPositionInGround(state);
posCoude_2_l = bodyset.get(indiceCoude_2_l).getPositionInGround(state);
posPoignet_l = bodyset.get(indicePoignet_l).getPositionInGround(state);

posHanche_l = bodyset.get(indiceHanche_l).getPositionInGround(state);
posHanche_r = bodyset.get(indiceHanche_r).getPositionInGround(state);
posGenou_l = bodyset.get(indiceGenou_l).getPositionInGround(state);
posCheville_l = bodyset.get(indiceCheville_l).getPositionInGround(state);

% Calculez la distance entre l'épaule et le coude
distance_Epaule_Coude_1_l = norm([posEpaule_l.get(0) - posCoude_1_l.get(0), posEpaule_l.get(1) - posCoude_1_l.get(1), posEpaule_l.get(2) - posCoude_1_l.get(2)]);
distance_Epaule_Coude_2_l = norm([posEpaule_l.get(0) - posCoude_2_l.get(0), posEpaule_l.get(1) - posCoude_2_l.get(1), posEpaule_l.get(2) - posCoude_2_l.get(2)]);

% Calculez la distance entre le coude et le poignet
distance_coude_1_poignet_l = norm([posCoude_1_l.get(0) - posPoignet_l.get(0), posCoude_1_l.get(1) - posPoignet_l.get(1), posCoude_1_l.get(2) - posPoignet_l.get(2)]);
distance_coude_2_poignet_l = norm([posCoude_2_l.get(0) - posPoignet_l.get(0), posCoude_2_l.get(1) - posPoignet_l.get(1), posCoude_2_l.get(2) - posPoignet_l.get(2)]);

% Calculez la distance entre le coude et le poignet
distance_Epaule_poignet_l = norm([posEpaule_l.get(0) - posPoignet_l.get(0), posEpaule_l.get(1) - posPoignet_l.get(1), posEpaule_l.get(2) - posPoignet_l.get(2)]);

% Calculez la distance entre l'épaule gauche et l'épaule droite
distance_Epaule_l_Epaule_r = norm([posEpaule_l.get(0) - posEpaule_r.get(0), posEpaule_l.get(1) - posEpaule_r.get(1), posEpaule_l.get(2) - posEpaule_r.get(2)]);

distance_Hanche_Genou_l = norm([posHanche_l.get(0) - posGenou_l.get(0), posHanche_l.get(1) - posGenou_l.get(1), posHanche_l.get(2) - posGenou_l.get(2)]);
distance_Genou_Cheville_l = norm([posGenou_l.get(0) - posCheville_l.get(0), posGenou_l.get(1) - posCheville_l.get(1), posGenou_l.get(2) - posCheville_l.get(2)]);
distance_Hanche_Cheville_l = norm([posHanche_l.get(0) - posCheville_l.get(0), posHanche_l.get(1) - posCheville_l.get(1), posHanche_l.get(2) - posCheville_l.get(2)]);
distance_Hanche_l_Hanche_r = norm([posHanche_l.get(0) - posHanche_r.get(0), posHanche_l.get(1) - posHanche_r.get(1), posHanche_l.get(2) - posHanche_r.get(2)]);


distances_calculees = [distance_Epaule_Coude_1_l;distance_Epaule_Coude_2_l;distance_coude_1_poignet_l;distance_coude_2_poignet_l;distance_Epaule_poignet_l;distance_Epaule_l_Epaule_r;distance_Hanche_Genou_l;distance_Genou_Cheville_l;distance_Hanche_Cheville_l;distance_Hanche_l_Hanche_r];

k = 1;

for i = 1:length(distances_calculees)
    
    nom_specifie = noms_specifies{k};

    distances = struct('Nom', nom_specifie, 'Distance', []);

    distances.Distance = distances_calculees(i);
    
    mesures = [mesures, distances];

    k = k+1;
end

% Créez un tableau à partir de la structure mesures
Tableau_de_mesure = struct2table(mesures);

% Sauvegardez le tableau dans un fichier CSV

writetable(Tableau_de_mesure, cheminFichier);

end

