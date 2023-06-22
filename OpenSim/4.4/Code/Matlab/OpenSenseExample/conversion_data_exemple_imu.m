% Import the OpenSim libraries
import org.opensim.modeling.*;
 
% Create an xsensDataReader and supply the settings file that maps IMUs to your model
xsensSettings = XsensDataReaderSettings('myIMUMappings.xml'); %
xsensReader = XsensDataReader(xsensSettings);
 
% Read the quaternion data and write it to a STO file for in OpenSense workflow
tables = xsensReader.read('IMUData/');
quaternionTable = xsensReader.getOrientationsTable(tables);
STOFileAdapterQuaternion.write(quaternionTable,  [char(xsensSettings.get_trial_prefix()) '_orientations.sto']);