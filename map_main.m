%程序功能：输出任意分辨率的占用栅格图和动目标检测
%输入参数：雷达数据myradar，分辨率resol，开始时刻begin，结束时刻over
%输出参数：占用栅格图和动目标检测图
%动目标检测原理：对某个栅格，只有每个时刻观测都认为它是占据的，或者都是空闲的，我才认为它是静止的；否则我认为是运动的

clc;
clear all;
close all;

%调整输入参数
load radar.mat;
resol=3;        %地图分辨率_分辨率为10，即1m代表10格
begin=1;        %调整地图起点
over=size(radar.time,2);  %调整地图终点
%画本地地图要在maping_occ中输入权重参数
%动目标检测要在maping_detect中输入权重参数

%画本地地图
[radar_temp,mapsize]=coordinate(radar,resol,begin,over);
map=maping_occ(radar_temp,mapsize,begin,over);   %调整权重参数
figure;
imagesc(map)
axis equal
colorbar
title('基于逆概模型的占用栅格图：黄色为有障碍物，蓝色为无障碍物，青色为雷达未扫描到')

%作图：动目标检测
[map,detect_map,mark_map]=maping_detect(radar_temp,mapsize,begin,over);
figure;
imagesc(mark_map)
axis equal
colorbar
title('动目标检测:黄色为动目标，蓝色为静止状态，青色为雷达未扫描到')
