%�����ܣ����״�դ��ͼ�м�⶯Ŀ�꣬����ǳ���
%���룺�ֱ���Resol���״����Begin���״��յ�Over
%�������ͼMap,��Ŀ������MovingCoor
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
Over=size(gps.time,1);
Thres=50;       %��Ŀ����ֵ�д�����

%% ��������
Data=GetData(gps,Radar,yaw_save,RadarPosiMark);

%% �õ�դ���ͼmap
[EnvirCoor,MapSize,CoorOffset]=GetEnvirCoor(Data,Resol,Begin,Over); %�����״ﻷ����ͼ������
Radar_Coor=GetRadarCoor(Data,Resol,Begin,Over,CoorOffset);%�����״�λ�õ�ͼ������
Map=Mapping_Density(EnvirCoor,MapSize,Begin,Over);%դ��ͼ��ͼ
%��դ���ͼ
figure;
imagesc(Map);hold on
axis equal
plot(Radar_Coor(:,1),Radar_Coor(:,2),'g<');hold on

%% ��Ŀ����
MovCoor=MovObj_Detect(Thres,Data,Begin,Over,RadarPosiMark,Resol,CoorOffset);
%��Ƕ�Ŀ��
plot(MovCoor(:,1),MovCoor(:,2),'rx','LineWidth',2.0)
         
 

