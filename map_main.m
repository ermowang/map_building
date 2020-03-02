%�����ܣ��������ֱ��ʵ�ռ��դ��ͼ
%����������״�����myradar���ֱ���resol����ʼʱ��begin������ʱ��over
%���������ռ��դ��ͼ

clc;
clear all;
close all;

%�������
load radar.mat;
resol=3;        %��ͼ�ֱ���_�ֱ���Ϊ10����1m����10��
begin=1;        %������ͼ���
over=size(radar.time,2);  %������ͼ�յ�size(radar.time,2)
p_occ = 0.8;  %ռ�ø���
p_free = 0.2;  %���и���
thres=0.7;

%�����ص�ͼ
[radar_temp,mapsize]=coordinate(radar,resol,begin,over);
[map,index]=detect_occ(radar_temp,mapsize,begin,over,p_occ,p_free,thres);
% [map,detect_map]=detect_occ(radar_temp,mapsize,begin,over,p_occ,p_free);

index1=index(:,2);
index2=index(:,1);
figure;
imagesc(map);
colorbar
axis equal
title('ռ��դ��ͼ')

figure;
imagesc(map);hold on
colorbar
plot(index1,index2,'rx')
axis equal
title('��Ŀ���⣺��ɫΪ��Ŀ��')

% figure;
% index1=index(:,2);
% index2=index(:,1);
% plot(index1,index2,'rx')
