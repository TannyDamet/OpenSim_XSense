clc; clear all; close  all;

data1 = open("DATA\Xsens_1_20230707_111200_241.csv");
quat0_1 = data1.data(4,3:6);
quats_1 = data1.data(4:end,3:6);

data2 = open("DATA\Xsens_2_20230707_111200_239.csv");
quat0_2 = data2.data(4,3:6);
quats_2 = data2.data(4:end,3:6);

% etalonnage poure trouver wRixw
wRi0_x = [-1 0 0; 0 0 1; 0 1 0];
i1wRi1 = quat2rotm(quat0_1);
wRi1w = wRi0_x /i1wRi1;

i2wRi2 = quat2rotm(quat0_2);
wRi2w = wRi0_x /i2wRi2;

% utilisation du changement de repere
wRi1_est = wRi1w * i1wRi1;
display(wRi1_est)

wRi2_est = wRi2w * i2wRi2;
display(wRi2_est)

% affichage
% orientation de l'imu dans son repere propre
i1wFi1 =rotateFrame(i1wRi1)
% orientation de l'imu dans le repere monde
wFi1   =rotateFrame(wRi1_est)

% seconde imu
% orientation de l'imu dans son repere propre
i2wFi2 =rotateFrame(i2wRi2)
% orientation de l'imu dans le repere monde
wFi2   =rotateFrame(wRi2_est)
shift=[1.5,0,0];
shift=ones(4,3).*shift;
%wFi2   = wFi2 + shift;

figure(1)
subplot(2,2,1)
plotFrame(i1wFi1,'o')
title("i1wFi1")
subplot(2,2,2)
plotFrame(wFi1,'s')
title("wFi1")
subplot(2,2,3)
plotFrame(i2wFi2,'o')
title("i2wFi2")
subplot(2,2,4)
plotFrame(wFi2,'s')
title("wFi2")




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
hold on
grid on
axis([-1 1 -1 1 -1 1])
xlabel('x')
ylabel('y')
zlabel('z')
plot3(rF(2,1),rF(2,2),rF(2,3),strcat('g',shape))
plot3(rF(3,1),rF(3,2),rF(3,3),strcat('b',shape))
plot3([rF(4,1);rF(1,1)],[rF(4,2);rF(1,2)],[rF(4,3);rF(1,3)],'r')
plot3([rF(4,1);rF(2,1)],[rF(4,2);rF(2,2)],[rF(4,3);rF(2,3)],'g')
plot3([rF(4,1);rF(3,1)],[rF(4,2);rF(3,2)],[rF(4,3);rF(3,3)],'b')

end