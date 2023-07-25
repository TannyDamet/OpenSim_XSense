function Orientation_Tracking_Function(Model,Directory,Data1,Data2,Data3,Data4,Data5,Vec1,Vec2,Vec3,Vec4,Vec5)

%% Clear the Workspace variables. 
clear all; close all; clc;
import org.opensim.modeling.*

%% Set variables to use
modelFileName = Model;               % The path to an input model


% orientationsFileName = 'MT_012005D6_009-001_orientations.sto';   % The path to orientation data for calibration 
% sensor_to_opensim_rotation = Vec3(-pi/2, 0, 0); % The rotation of IMU data to the OpenSim world frame 

orientationsFileNames = {Data1,Data2,Data3,Data4,Data5};   % The paths to orientation data for calibration 
sensor_to_opensim_rotations = [Vec1,Vec2,Vec3,Vec4,Vec5]; % The rotations of IMU data to the OpenSim world frame 

visualizeTracking = true;  % Boolean to Visualize the tracking simulation
startTime = 0;          % Start time (in seconds) of the tracking simulation. 
endTime = 30;              % End time (in seconds) of the tracking simulation.
resultsDirectory = Directory;

%% Instantiate an InverseKinematicsTool
imuIK = IMUInverseKinematicsTool();

%% Set the model path to be used for tracking
imuIK.set_model_file(modelFileName);
% imuIK.set_orientations_file(orientationsFileName);
% imuIK.set_sensor_to_opensim_rotations(sensor_to_opensim_rotation)

% Set orientations files and sensor rotations
for i = 1:length(orientationsFileNames)
    imuIK.set_orientations_file(orientationsFileNames{i});
    imuIK.set_sensor_to_opensim_rotations(sensor_to_opensim_rotations(i));
end

% Set time range in seconds
imuIK.set_time_range(0, startTime); 
imuIK.set_time_range(1, endTime);

% Set a directory for the results to be written to
imuIK.set_results_directory(resultsDirectory)
% Run IK
imuIK.run(visualizeTracking);


end