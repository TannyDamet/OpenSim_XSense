import org.opensim.modeling.*

% Setup and run the IMUPlacer tool, with model visualization set to true
myIMUPlacer = IMUPlacer('myIMUPlacer_Setup_sup.xml');
myIMUPlacer.run(true); 
 
% Write the calibrated model to file
myIMUPlacer.getCalibratedModel().print('Rajagopal_2015_sup_calibrated.osim');