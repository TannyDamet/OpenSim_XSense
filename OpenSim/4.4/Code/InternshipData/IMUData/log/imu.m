clc; clear all; close  all;


data1 = open("Xsens_1_20230707_111200_241.csv");
quaternion = data1.data(4,3:6);

% etalonnage poure trouver wRi1w
i1wRi1 = quat2rotm(quaternion);
wRi1 = [-1 0 0; 0 0 1; 0 1 0];
wRi1w = wRi1*inv(i1wRi1);


% utilisation du changement de repere
wRi1_est = wRi1w * i1wRi1;
display(wRi1_est)

i1wFi1=rotateFrame(i1wRi1)
wFi1=rotateFrame(wRi1_est)

figure(1)
plotFrame(i1wFi1,'o')
plotFrame(wFi1,'s')


function rF=rotateFrame(wRi)
    x = [1,0,0];
    y = [0,1,0];
    z = [0,0,1];

    xr = wRi*x';
    yr = wRi*y';
    zr = wRi*z';

    rF = [xr';yr';zr']
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