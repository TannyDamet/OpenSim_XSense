clear all; close all; clc;
import org.opensim.modeling.*

model = Model('Modele/Rajagopal2015_opensense_sup_l.osim');

corps = getBodySet(model);
