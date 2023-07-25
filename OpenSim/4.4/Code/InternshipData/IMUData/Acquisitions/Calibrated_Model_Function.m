function model_calibrated = Calibrated_Model_Function(Model,Data1,Data2,Data3,Data4,Data5,Body1,Body2,Body3,Body4,Body5,Vec1,Vec2,Vec3,Vec4,Vec5)

%% Clear the Workspace variables. 
clear all; close all; clc;
import org.opensim.modeling.*

%% Set variables to use
modelfilename = Model;          % The path to an input model

% orientationsFileName = 'DATA\Xsens_5.sto';      % The path to orientation data for calibration 
% sensor_to_opensim_rotations = Vec3(0, 0, 0);    % The rotation of IMU data to the OpenSim world frame 

orientationsFileNames = {Data1,Data2,Data3,Data4,Data5};   % The paths to orientation data for calibration 

sensor_to_opensim_rotations = [Vec1,Vec2,Vec3,Vec4,Vec5]; % The rotations of IMU data to the OpenSim world frame 

baseIMUName = {Body1,Body2,Body3,Body4,Body5};                     % The base IMU is the IMU on the base body of the model that dictates the heading (forward) direction of the model.
baseIMUHeading = 'z';                           % The Coordinate Axis of the base IMU that points in the heading direction. 
visulizeCalibration = true;                     % Boolean to Visualize the Output model

%% Instantiate an IMUPlacer object
imuPlacer = IMUPlacer();

% Set properties for the IMUPlacer
imuPlacer.set_model_file(modelfilename);
% imuPlacer.set_orientation_file_for_calibration(orientationsFileName);
% imuPlacer.set_sensor_to_opensim_rotations(sensor_to_opensim_rotations);


% Set orientations files and sensor rotations
for i = 1:length(orientationsFileNames)
    imuPlacer.set_orientation_file_for_calibration(orientationsFileNames{i});
    imuPlacer.set_sensor_to_opensim_rotations(sensor_to_opensim_rotations(i));
    imuPlacer.set_base_imu_label(baseIMUName(i));
    imuPlacer.set_base_heading_axis(baseIMUHeading);
    imuPlacer.run(visulizeCalibration);
    model = imuPlacer.getCalibratedModel();
end

% imuPlacer.set_base_imu_label(baseIMUName);
% imuPlacer.set_base_heading_axis(baseIMUHeading);

% Run the IMUPlacer
% imuPlacer.run(visulizeCalibration);

% Get the model with the calibrated IMU's
% model = imuPlacer.getCalibratedModel();

%% Print the calibrated model to file.
% model.print(modelfilename);

model_calibrated = model;

model_calibrated.print( strrep(modelfilename, '.osim', '_calibrated_or.osim') );

end