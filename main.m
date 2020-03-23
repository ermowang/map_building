%�����ܣ����״�դ��ͼ�м�⶯Ŀ�꣬����ǳ���,���õ�ȥ����Ŀ��֮���դ��ͼ
%���룺�ֱ���Resol���״����Begin���״��յ�Over
%�������ͼMap,��Ŀ������MovingCoor,��Ŀ������MovIndex
%����ԭ��դ��ͼԭ���״���ʻ���̿��˺ܶ�֡��ÿһ֡���˺ܶ��ۣ���ÿ��λ����������/��֡��
         %��Ŀ����ԭ��ʹ���״��⵽��Ŀ��������ٶ�����ά�ռ����ؽ����״���ʻ�ٶȣ��쳣ֵ����Ϊ��Ŀ��
         
clc; 
clear all;
close all;

%��������
load data3.mat;
Radar=radar_front;  %left��front��right
RadarPosiMark=0;  %�״�λ�õı�ǣ�-1Ϊ����״0Ϊǰ���״1Ϊ�Ҳ��״�
Resol=4;           %�ֱ���Ϊ10����1m��ʾΪ10��
Begin=1;
Over=size(gps.time,1);  %size(gps.time,1)
Thres=0.5;       %��Ŀ����ֵ�д�����
%�����ѡ��������У���ͼ��ʽ��ȥ����Ŀ��Ľ�ͼ��ʽ����ͼ��ֵ�Ƿ���db

%% ��������
Data=GetData(gps,Radar,yaw_save,RadarPosiMark);

%% �õ�դ���ͼmap
[EnvirCoor,MapSize,CoorOffset]=GetEnvirCoor(Data,Resol,Begin,Over); %�����״ﻷ����ͼ������
Radar_Coor=GetRadarCoor(Data,Resol,Begin,Over,CoorOffset);%�����״�λ�õ�ͼ������
% Map=Mapping_Density(EnvirCoor,MapSize,Begin,Over);%դ��ͼ��ͼ,ʹ��֡�ܶȷ�ʽ
Map=Mapping_Occu(EnvirCoor,MapSize,Begin,Over);%դ��ͼ��ͼ,ʹ�ü�Ȩ��ʽ
%��դ���ͼ
figure;
% imagesc(Map);hold on
imagesc(db(Map));hold on
axis equal
plot(Radar_Coor(:,1),Radar_Coor(:,2),'g>');hold on

%% ��Ŀ����
[MovCoor,MovIndex]=MovObj_Detect(Thres,Data,Begin,Over,RadarPosiMark,Resol,CoorOffset);
%��Ƕ�Ŀ��
plot(MovCoor(:,1),MovCoor(:,2),'rx','LineWidth',2.0)
         
legend('�״�·�� ','��Ŀ�� ');
% title('ǰ���״������У���ֵ25');
title('��Ŀ����');

%% ȥ����Ŀ��Ľ�ͼ
% MapStat=Mapping_Density_Static(EnvirCoor,MapSize,Begin,Over,MovIndex);
MapStat=Mapping_Occu_Static(EnvirCoor,MapSize,Begin,Over,MovIndex);

figure
subplot(2,1,1)
imagesc(db(Map))
axis equal
title('ԭʼդ��ͼ');
subplot(2,1,2)
imagesc(db(MapStat));hold on
axis equal
title('��̬դ��ͼ');
