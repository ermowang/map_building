%程序功能：在雷达栅格图中检测动目标，并标记出来
%输入：分辨率Resol，雷达起点Begin，雷达终点Over
%输出：地图Map,动目标坐标MovingCoor
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
Over=size(gps.time,1);
Thres=50;       %动目标阈值有待调整

%% 数据整理
Data=GetData(gps,Radar,yaw_save,RadarPosiMark);

%% 得到栅格地图map
[EnvirCoor,MapSize,CoorOffset]=GetEnvirCoor(Data,Resol,Begin,Over); %计算雷达环境的图上坐标
Radar_Coor=GetRadarCoor(Data,Resol,Begin,Over,CoorOffset);%计算雷达位置的图上坐标
Map=Mapping_Density(EnvirCoor,MapSize,Begin,Over);%栅格图建图
%画栅格地图
figure;
imagesc(Map);hold on
axis equal
plot(Radar_Coor(:,1),Radar_Coor(:,2),'g<');hold on

%% 动目标检测
MovCoor=MovObj_Detect(Thres,Data,Begin,Over,RadarPosiMark,Resol,CoorOffset);
%标记动目标
plot(MovCoor(:,1),MovCoor(:,2),'rx','LineWidth',2.0)
         
 

