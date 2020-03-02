%程序功能：输出任意分辨率的占用栅格图
%输入参数：雷达数据myradar，分辨率resol，开始时刻begin，结束时刻over
%输出参数：占用栅格图

clc;
clear all;
close all;

%输入参数
load radar.mat;
resol=3;        %地图分辨率_分辨率为10，即1m代表10格
begin=1;        %调整地图起点
over=size(radar.time,2);  %调整地图终点size(radar.time,2)
p_occ = 0.8;  %占用概率
p_free = 0.2;  %空闲概率


%画本地地图
[radar_temp,mapsize]=coordinate(radar,resol,begin,over);
map=maping_occ(radar_temp,mapsize,begin,over,p_occ,p_free);
figure;
imagesc(map)
axis equal
colorbar

