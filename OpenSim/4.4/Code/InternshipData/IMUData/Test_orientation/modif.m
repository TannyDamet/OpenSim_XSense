clc;
clear all;
close all;

data1 = open("DATA\Xsens_1_20230707_111200_241.csv");
data2 = open("DATA\Xsens_2_20230707_111200_239.csv");
data3 = open("DATA\Xsens_3_20230707_111200_242.csv");
data4 = open("DATA\Xsens_4_20230707_111200_241.csv");
data5 = open("DATA\Xsens_5_20230707_111200_243.csv");

init_shift = 1;

quat0_1 = data1.data(init_shift,3:6);
quats_1 = data1.data(init_shift:end,3:6);
quat0_2 = data2.data(init_shift,3:6);
quats_2 = data2.data(init_shift:end,3:6);
quat0_3 = data3.data(init_shift,3:6);
quats_3 = data3.data(init_shift:end,3:6);
quat0_4 = data4.data(init_shift,3:6);
quats_4 = data4.data(init_shift:end,3:6);
quat0_5 = data5.data(init_shift, 3:6);
quats_5 = data5.data(init_shift:end, 3:6);


header_1 = data1.textdata;

colheader_1 = data1.colheaders;

writematrix([data1.colheaders; data1.textdata; num2cell(data1.data)], "DATA\Xsens_1_modified.csv");
writematrix([data2.colheaders; data2.textdata; num2cell(data2.data)], "DATA\Xsens_2_modified.csv");
writematrix([data3.colheaders; data3.textdata; num2cell(data3.data)], "DATA\Xsens_3_modified.csv");
writematrix([data4.colheaders; data4.textdata; num2cell(data4.data)], "DATA\Xsens_4_modified.csv");
writematrix([data5.colheaders; data5.textdata; num2cell(data5.data)], "DATA\Xsens_5_modified.csv");