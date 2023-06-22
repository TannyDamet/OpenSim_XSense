import org.opensim.modeling.*

% Setup and run the IMU IK tool with visualization set to true.
imuIK = IMUInverseKinematicsTool('myIMUIK_Setup_sup.xml');
imuIK.run(true);