clc; clear all;
% Import the OpenSim libraries
import org.opensim.modeling.*;

% Create an xsensDataReader and supply the settings file that maps IMUs to your model
xsensSettings = XsensDataReaderSettings('myIMUMappings_4_5.xml'); %
xsensReader = XsensDataReader(xsensSettings);

% Read the quaternion data and write it to a STO file for in OpenSense workflow
tables = xsensReader.read('IMU_Data/Prise_1/Sup/');

% Get the orientations table from the loaded data
quaternionTable = xsensReader.getOrientationsTable(tables);

STOFileAdapterQuaternion.write(quaternionTable,  [char(xsensSettings.get_trial_prefix()) '_orientations.sto']);