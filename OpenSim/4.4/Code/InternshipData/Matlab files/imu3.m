clc; clear all; close  all;

data1 = open("Xsens_1_20230707_111200_241.csv");
data2 = open("Xsens_2_20230707_111200_239.csv");
data3 = open("Xsens_3_20230707_111200_242.csv");
data4 = open("Xsens_4_20230707_111200_241.csv");
data5 = open("Xsens_5_20230707_111200_243.csv");

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

wRi1 = [-1 0 0; 0 0 1; 0 1 0]; % Repère imu constant au repère monde

wRi1w = i1wRi1*wRi1; % Repère imu 1 lu dans le repère monde
wRi2w = i2wRi2*wRi1; % Repère imu 2 lu dans le repère monde
wRi3w = i3wRi3*wRi1; % Repère imu 3 lu dans le repère monde
wRi4w = i4wRi4*wRi1; % Repère imu 4 lu dans le repère monde
wRi5w = i5wRi5*wRi1; % Repère imu 5 lu dans le repère monde

% utilisation du changement de repere
wRi1_est = inv(i1wRi1) * wRi1w;
wRi2_est = inv(i2wRi2) * wRi2w;
wRi3_est = inv(i3wRi3) * wRi3w;
wRi4_est = inv(i4wRi4) * wRi4w;
wRi5_est = inv(i5wRi5) * wRi5w;

display(wRi1_est);
display(wRi2_est);
display(wRi3_est);
display(wRi4_est);
display(wRi5_est);

i1wFi1=rotateFrame(i1wRi1);
wFi1=rotateFrame(wRi1_est);

i2wFi2=rotateFrame(i2wRi2);
wFi2=rotateFrame(wRi2_est);

i3wFi3=rotateFrame(i3wRi3);
wFi3=rotateFrame(wRi3_est);

i4wFi4=rotateFrame(i4wRi4);
wFi4=rotateFrame(wRi4_est);

i5wFi5=rotateFrame(i5wRi5);
wFi5=rotateFrame(wRi5_est);

figure(1)
plotFrame(i1wFi1,'o');
plotFrame(wFi1,'s');

figure(2)
plotFrame(i2wFi2,'o');
plotFrame(wFi2,'s');

figure(3)
plotFrame(i3wFi3,'o');
plotFrame(wFi3,'s');

figure(4)
plotFrame(i4wFi4,'o');
plotFrame(wFi4,'s');

figure(5)
plotFrame(i5wFi5,'o');
plotFrame(wFi5,'s');

function rF=rotateFrame(wRi)
x = [1,0,0];
y = [0,1,0];
z = [0,0,1];

xr = wRi*x';
yr = wRi*y';
zr = wRi*z';

rF = [xr';yr';zr'];
end

function plotFrame(rF,shape)

plot3(rF(1,1),rF(1,2),rF(1,3),strcat('r',shape))
hold on
grid on
axis([-1 1 -1 1 -1 1])
xlabel('x')
ylabel('y')
zlabel('z')
plot3(rF(2,1),rF(2,2),rF(2,3),strcat('g',shape))
plot3(rF(3,1),rF(3,2),rF(3,3),strcat('b',shape))

plot3([0;rF(1,1)],[0;rF(1,2)],[0;rF(1,3)],'r')
plot3([0;rF(2,1)],[0;rF(2,2)],[0;rF(2,3)],'g')
plot3([0;rF(3,1)],[0;rF(3,2)],[0;rF(3,3)],'b')

end