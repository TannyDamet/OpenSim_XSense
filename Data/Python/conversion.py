# -*- coding: utf-8 -*-
"""
Created on Tue Jun 20 11:22:59 2023

@author: PC
"""

!pip install pyc3dserver

import c3dserver as c3d
import numpy as np

# Spécifiez les informations sur le fichier CSV
cheminBrasDroit = 'C:/Users/PC/Documents/GitHub/OpenSim_XSense/Data/DATA_Imus/brasDroit.csv'
cheminBrasGauche = 'C:/Users/PC/Documents/GitHub/OpenSim_XSense/Data/DATA_Imus/brasGauche.csv'
cheminPoignetDroit = 'C:/Users/PC/Documents/GitHub/OpenSim_XSense/Data/DATA_Imus/poignetDroit.csv'
cheminThoracique = 'C:/Users/PC/Documents/GitHub/OpenSim_XSense/Data/DATA_Imus/Thoracique.csv'

framerate = 100  # Fréquence d'échantillonnage de vos données de mouvement

# Lisez les données CSV
dataBrasDroit = np.genfromtxt(cheminBrasDroit, delimiter=',', skip_header=1)
dataBrasGauche = np.genfromtxt(cheminBrasGauche, delimiter=',', skip_header=1)
dataPoignetDroit = np.genfromtxt(cheminPoignetDroit, delimiter=',', skip_header=1)
dataThoracique = np.genfromtxt(cheminThoracique, delimiter=',', skip_header=1)

# Créez un nouvel objet C3D
c3dBrasDroit = c3d.C3DWriter()
c3dBrasGauche = c3d.C3DWriter()
c3dPoignetDroit = c3d.C3DWriter()
c3dThoracique = c3d.C3DWriter()

# Ajoutez les marqueurs au fichier C3D
for i in range(1, dataBrasDroit.shape[1], 3):
    marker_name_BrasDroit = f'M{int((i-1)/3)+1}'  # Nom du marqueur
    marker_data_BrasDroit = dataBrasDroit[:, i:i+3].T  # Données de mouvement (x, y, z)
    c3dBrasDroit.add_analog_frame(marker_data_BrasDroit, marker_name_BrasDroit)

for i in range(1, dataBrasGauche.shape[1], 3):
    marker_name_BrasGauche= f'M{int((i-1)/3)+1}'  # Nom du marqueur
    marker_data_BrasGauche= dataBrasGauche[:, i:i+3].T  # Données de mouvement (x, y, z)
    c3dBrasGauche.add_analog_frame(marker_data_BrasGauche, marker_name_BrasGauche)

for i in range(1, dataPoignetDroit.shape[1], 3):
    marker_name_PoigetDroit = f'M{int((i-1)/3)+1}'  # Nom du marqueur
    marker_data_PoignetDroit = dataPoignetDroit[:, i:i+3].T  # Données de mouvement (x, y, z)
    c3dPoignetDroit.add_analog_frame(marker_data_PoignetDroit, marker_name_PoignetDroit)

for i in range(1, dataThoracique.shape[1], 3):
    marker_name_Thoracique = f'M{int((i-1)/3)+1}'  # Nom du marqueur
    marker_data_Thoracique = dataThoracique[:, i:i+3].T  # Données de mouvement (x, y, z)
    c3dThoracique.add_analog_frame(marker_data_Thoracique, marker_name_Thoracique)

# Spécifiez les informations sur les données (fréquence d'échantillonnage, nombre de frames)
c3dBrasDroit.set_point_rate(framerate)
c3dBrasDroit.set_num_frames(data.shape[0])

c3dBrasGauche.set_point_rate(framerate)
c3dBrasGauche.set_num_frames(data.shape[0])

c3dPoignetDroit.set_point_rate(framerate)
c3dPoignetDroit.set_num_frames(data.shape[0])

c3dThoracique.set_point_rate(framerate)
c3dThoracique.set_num_frames(data.shape[0])

# Écrivez le fichier C3D
output_c3dBrasDroit = 'C:/Users/PC/Documents/GitHub/OpenSim_XSense/Data/DATA_Imus/C3D/brasDroit.c3d'
c3dBrasDroit.write(output_c3dBrasDroit)

output_c3dBrasGauche = 'C:/Users/PC/Documents/GitHub/OpenSim_XSense/Data/DATA_Imus/C3D/brasGauche.c3d'
c3dBrasGauche.write(output_c3dBrasGauche)

output_c3dPoignetDroit = 'C:/Users/PC/Documents/GitHub/OpenSim_XSense/Data/DATA_Imus/C3D/poignetDroit.c3d'
c3dPoignetDroit.write(output_c3dPoignetDroit)

output_c3dThoracique = 'C:/Users/PC/Documents/GitHub/OpenSim_XSense/Data/DATA_Imus/C3D/Thoracique.c3d'
c3dThoracique.write(output_c3dThoracique)


