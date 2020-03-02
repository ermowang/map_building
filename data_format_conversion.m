%函数功能：将师兄给的第四次数据的格式转换为第一种数据的格式
%改动参数：1.载入的数据文件名
%          2.数据内的前、左、右雷达数据的选择
clc; 
clear all;
close all;

load 'data1.mat';%参数可改动

mark=gps.time;
radar.time=mark';
radar.data=radar_right';            %参数可改动
x=gps.xEast-gps.xEast(1);
y=gps.yNorth-gps.yNorth(1);
for i=1:size(radar.time,2)    
    radar.gps(i).x=x(i);
    radar.gps(i).y=y(i);
    radar.gps(i).yaw=yaw_save(i);
end
save('radar.mat', 'radar'); 