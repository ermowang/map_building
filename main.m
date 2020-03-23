%�����ܣ��õ�����֡�ܶȵ��״�դ��ͼ
%���룺�ֱ���Resol���״����Begin���״��յ�Over
%�������ͼMap,��Ŀ������MovingCoor
%����ԭ��դ��ͼԭ���״���ʻ���̿��˺ܶ�֡��ÿһ֡���˺ܶ��ۣ���ÿ��λ����������/��֡��
         
clc; 
clear all;
close all;

%��������
load data3.mat;
Radar=radar_left;  %left��front��right
RadarPosiMark=-1;  %�״�λ�õı�ǣ�-1Ϊ����״0Ϊǰ���״1Ϊ�Ҳ��״�
Resol=4;           %�ֱ���Ϊ10����1m��ʾΪ10��
Begin=1;
Over=size(gps.time,1);

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
plot(Radar_Coor(:,1),Radar_Coor(:,2),'g<')

