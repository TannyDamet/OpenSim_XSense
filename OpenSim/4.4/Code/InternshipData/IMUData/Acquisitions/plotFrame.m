function plotFrame(rF, shape)
plot3(rF(1,1), rF(1,2), rF(1,3), strcat('r', shape))
hold on
grid on
axis([-1 1 -1 1 -1 1])
xlabel('x')
ylabel('y')
zlabel('z')
plot3(rF(2,1), rF(2,2), rF(2,3), strcat('g', shape))
plot3(rF(3,1), rF(3,2), rF(3,3), strcat('b', shape))
plot3([rF(4,1); rF(1,1)], [rF(4,2); rF(1,2)], [rF(4,3); rF(1,3)], 'r')
plot3([rF(4,1); rF(2,1)], [rF(4,2); rF(2,2)], [rF(4,3); rF(2,3)], 'g')
plot3([rF(4,1); rF(3,1)], [rF(4,2); rF(3,2)], [rF(4,3); rF(3,3)], 'b')
end