import org.opensim.modeling.*

% Setup and run the IMU IK tool with visualization set to true.
imuIK = IMUInverseKinematicsTool('myIMUIK_Setup.xml');
imuIK.run(true);