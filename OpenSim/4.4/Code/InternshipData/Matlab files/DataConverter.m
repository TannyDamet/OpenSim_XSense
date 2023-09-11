function [Orientation_data,LinearAcceleration_data,MagneticNorth_data,AngularVelocity_data] = DataConverter(IMUData,myIMUMappings)

%% Clear any variables in the workspace
clear all; close all; clc; 

%% Import OpenSim libraries
import org.opensim.modeling.*

%% Build an Xsens Settings Object. 
% Instantiate the Reader Settings Class
xsensSettings = XsensDataReaderSettings(myIMUMappings);
% Instantiate an XsensDataReader
xsens = XsensDataReader(xsensSettings);
% Get a table reference for the data
tables = xsens.read(IMUData);
% get the trial name from the settingsrial = char(xsensSettings.get_trial_prefix());

%% Get Orientation Data as quaternions
quatTable = xsens.getOrientationsTable(tables);
% Write to file
Orientation_data = STOFileAdapterQuaternion.write(quatTable,  [trial '_orientations.sto']);

%% Get Acceleration Data
accelTable = xsens.getLinearAccelerationsTable(tables);
% Write to file
LinearAcceleration_data = STOFileAdapterVec3.write(accelTable, [trial '_linearAccelerations.sto']);

%% Get Magnetic (North) Heading Data
magTable = xsens.getMagneticHeadingTable(tables);
% Write to file
MagneticNorth_data = STOFileAdapterVec3.write(magTable, [trial '_magneticNorthHeadings.sto']);

%% Get Angular Velocity Data
angVelTable = xsens.getAngularVelocityTable(tables);
% Write to file
AngularVelocity_data = STOFileAdapterVec3.write(angVelTable, [trial '_angularVelocities.sto']);

end