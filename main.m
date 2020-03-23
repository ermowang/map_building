%程序功能：在雷达栅格图中检测动目标，并标记出来,并得到去除动目标之后的栅格图
%输入：分辨率Resol，雷达起点Begin，雷达终点Over
%输出：地图Map,动目标坐标MovingCoor,动目标索引MovIndex
%程序原理：栅格图原理：雷达行驶过程看了很多帧，每一帧看了很多眼；在每个位置用总眼数/总帧数
         %动目标检测原理：使用雷达检测到的目标多普勒速度在三维空间内重建出雷达行驶速度，异常值即视为动目标
         
clc; 
clear all;
close all;

%参数调整
load data3.mat;
Radar=radar_front;  %left、front、right
RadarPosiMark=0;  %雷达位置的标记，-1为左侧雷达，0为前侧雷达，1为右侧雷达
Resol=4;           %分辨率为10，即1m表示为10格
Begin=1;
Over=size(gps.time,1);  %size(gps.time,1)
Thres=0.5;       %动目标阈值有待调整
%下面可选择调整的有：建图方式，去除动目标的建图方式，建图数值是否用db

%% 数据整理
Data=GetData(gps,Radar,yaw_save,RadarPosiMark);

%% 得到栅格地图map
[EnvirCoor,MapSize,CoorOffset]=GetEnvirCoor(Data,Resol,Begin,Over); %计算雷达环境的图上坐标
Radar_Coor=GetRadarCoor(Data,Resol,Begin,Over,CoorOffset);%计算雷达位置的图上坐标
% Map=Mapping_Density(EnvirCoor,MapSize,Begin,Over);%栅格图建图,使用帧密度方式
Map=Mapping_Occu(EnvirCoor,MapSize,Begin,Over);%栅格图建图,使用加权方式
%画栅格地图
figure;
% imagesc(Map);hold on
imagesc(db(Map));hold on
axis equal
plot(Radar_Coor(:,1),Radar_Coor(:,2),'g>');hold on

%% 动目标检测
[MovCoor,MovIndex]=MovObj_Detect(Thres,Data,Begin,Over,RadarPosiMark,Resol,CoorOffset);
%标记动目标
plot(MovCoor(:,1),MovCoor(:,2),'rx','LineWidth',2.0)
         
legend('雷达路线 ','动目标 ');
% title('前侧雷达，相向而行，阈值25');
title('动目标检测');

%% 去除动目标的建图
% MapStat=Mapping_Density_Static(EnvirCoor,MapSize,Begin,Over,MovIndex);
MapStat=Mapping_Occu_Static(EnvirCoor,MapSize,Begin,Over,MovIndex);

figure
subplot(2,1,1)
imagesc(db(Map))
axis equal
title('原始栅格图');
subplot(2,1,2)
imagesc(db(MapStat));hold on
axis equal
title('静态栅格图');
