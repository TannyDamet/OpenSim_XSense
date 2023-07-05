import org.opensim.modeling.*

% Chemin vers le fichier de modèle OpenSim
modelPath = 'C:/Users/PC/Desktop/essaie.osim';

% Charger le modèle OpenSim
osimModel = Model(modelPath);

% Nom des segments du bras que vous souhaitez modifier
upperArmSegmentName = 'humerus_l';
lowerArmSegmentName = 'radius_l';

% Facteur d'échelle pour réduire la taille du bras (0.8 signifie 80% de la taille d'origine)
scaleFactor = 0.8;

% Obtenir les segments du bras à partir du modèle OpenSim
upperArmSegment = osimModel.getBodySet().get(lowerArmSegmentName);
lowerArmSegment = osimModel.getBodySet().get(upperArmSegmentName);

% Récupérer l'articulation du bras
shoulderJoint = upperArmSegment.getParentJoint();
elbowJoint = lowerArmSegment.getParentJoint();

% Récupérer les positions des articulations du bras
shoulderPosition = shoulderJoint.getLocationInParent();
elbowPosition = elbowJoint.getLocationInParent();

% Calculer les nouvelles positions des articulations après l'échelle
newShoulderPosition = shoulderPosition * scaleFactor;
newElbowPosition = elbowPosition * scaleFactor;

% Mettre à jour les positions des articulations du bras dans le modèle OpenSim
shoulderJoint.setLocationInParent(newShoulderPosition);
elbowJoint.setLocationInParent(newElbowPosition);

% Mettre à jour les masses des segments du bras
upperArmSegment.setMass(upperArmSegment.getMass() * scaleFactor);
lowerArmSegment.setMass(lowerArmSegment.getMass() * scaleFactor);

% Enregistrer le modèle OpenSim modifié
outputModelPath = 'C:/Users/PC/Desktop/modele_modifie.osim';
osimModel.print(outputModelPath);

disp('La taille du bras a été réduite avec succès.');
