%clc; clear all; 
close  all;

% data1 = open("Xsens_1.csv");
% data2 = open("Xsens_2.csv");
% data3 = open("Xsens_3.csv");
% data4 = open("Xsens_4.csv");
% data5 = open("Xsens_5.csv");
%data1 = open("Xsens_1_20230707_111200_241.csv");
%data2 = open("Xsens_2_20230707_111200_239.csv");
%data3 = open("Xsens_3_20230707_111200_242.csv");
%data4 = open("Xsens_4_20230707_111200_241.csv");
%data5 = open("Xsens_5_20230707_111200_243.csv");


quaternion1 = data1.data(4,3:6);
quaternion2 = data2.data(4,3:6);
quaternion3 = data3.data(4,3:6);
quaternion4 = data4.data(4,3:6);
quaternion5 = data5.data(4,3:6);

% etalonnage pour trouver wRi1w

i1wRi1 = quat2rotm(quaternion1); % lu sur l'imu 1
i2wRi2 = quat2rotm(quaternion2); % lu sur l'imu 2
i3wRi3 = quat2rotm(quaternion3); % lu sur l'imu 3
i4wRi4 = quat2rotm(quaternion4); % lu sur l'imu 4
i5wRi5 = quat2rotm(quaternion5); % lu sur l'imu 5

wRi0 = [0 1 0; 0 0 1; 1 0 0]; % Repère imu constant au repère monde

wRi1w = wRi0*inv(i1wRi1); % Repère imu 1 lu dans le repère monde
wRi2w = wRi0*inv(i2wRi2); % Repère imu 2 lu dans le repère monde
wRi3w = wRi0*inv(i3wRi3); % Repère imu 3 lu dans le repère monde
wRi4w = wRi0*inv(i4wRi4); % Repère imu 4 lu dans le repère monde
wRi5w = wRi0*inv(i5wRi5); % Repère imu 5 lu dans le repère monde

% utilisation du changement de repere
wRi1_est = wRi1w * i1wRi1;
wRi2_est = wRi2w * i2wRi2;
wRi3_est = wRi3w * i3wRi3;
wRi4_est = wRi4w * i4wRi4;
wRi5_est = wRi5w * i5wRi5;

display(wRi1_est);
display(wRi2_est);
display(wRi3_est);
display(wRi4_est);
display(wRi5_est);

% Rotate frames
i1wFi1=rotateFrame(i1wRi1);
wFi1=rotateFrame(wRi1_est);
eul1 = rotm2eul(i1wRi1);

shift=[1.5,0,0];
shift=ones(4,3).*shift;
display(shift)

i2wFi2=rotateFrame(i2wRi2);
wFi2=rotateFrame(wRi2_est);
display(wFi2)
wFi2=wFi2+shift;
display(wFi2)
eul2 = rotm2eul(i2wRi2);

i3wFi3=rotateFrame(i3wRi3);
wFi3=rotateFrame(wRi3_est)+2*shift;
eul3 = rotm2eul(i3wRi3);

i4wFi4=rotateFrame(i4wRi4);
wFi4=rotateFrame(wRi4_est)+3*shift;
eul4 = rotm2eul(i4wRi4);

i5wFi5=rotateFrame(i5wRi5);
wFi5=rotateFrame(wRi5_est)+4*shift;
eul5 = rotm2eul(i5wRi5);

euler_rad = [eul1; eul2; eul3; eul4; eul5];
euler_deg = rad2deg(euler_rad);
% Figures
figure(1)
%plotFrame(i1wFi1,'o');
 plotFrame(wFi1,'s');
 hold on
% 
% %figure(2)
% plotFrame(i2wFi2,'o');
 plotFrame(wFi2,'*');
% 
% %figure(3)
% plotFrame(i3wFi3,'o');
% plotFrame(wFi3,'s');
% 
% %figure(4)
% plotFrame(i4wFi4,'o');
% plotFrame(wFi4,'s');
% 
% %figure(5)
% plotFrame(i5wFi5,'o');
% plotFrame(wFi5,'s');

% Functions 

function rF=rotateFrame(wRi)
zero = [0,0,0];
x = [1,0,0];
y = [0,1,0];
z = [0,0,1];

xr = wRi*x';
yr = wRi*y';
zr = wRi*z';

rF = [xr';yr';zr'; zero];
end

function plotFrame(rF,shape)

plot3(rF(1,1),rF(1,2),rF(1,3),strcat('r',shape))
% hold on
% grid on
% axis([-1 1 -1 1 -1 1])
% xlabel('x')
% ylabel('y')
% zlabel('z')
plot3(rF(2,1),rF(2,2),rF(2,3),strcat('g',shape))
plot3(rF(3,1),rF(3,2),rF(3,3),strcat('b',shape))

plot3([rF(4,1);rF(1,1)],[rF(4,2);rF(1,2)],[rF(4,3);rF(1,3)],'r')
plot3([rF(4,1);rF(2,1)],[rF(4,2);rF(2,2)],[rF(4,3);rF(2,3)],'g')
plot3([rF(4,1);rF(3,1)],[rF(4,2);rF(3,2)],[rF(4,3);rF(3,3)],'b')

end