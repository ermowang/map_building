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


%�����ص�ͼ
[radar_temp,mapsize]=coordinate(radar,resol,begin,over);
map=maping_occ(radar_temp,mapsize,begin,over,p_occ,p_free);
figure;
imagesc(map)
axis equal
colorbar

