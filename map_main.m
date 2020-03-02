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
thres=0.7;

%画本地地图
[radar_temp,mapsize]=coordinate(radar,resol,begin,over);
[map,index]=detect_occ(radar_temp,mapsize,begin,over,p_occ,p_free,thres);
% [map,detect_map]=detect_occ(radar_temp,mapsize,begin,over,p_occ,p_free);

index1=index(:,2);
index2=index(:,1);
figure;
imagesc(map);
colorbar
axis equal
title('占用栅格图')

figure;
imagesc(map);hold on
colorbar
plot(index1,index2,'rx')
axis equal
title('动目标检测：红色为动目标')

% figure;
% index1=index(:,2);
% index2=index(:,1);
% plot(index1,index2,'rx')
