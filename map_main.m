%�����ܣ��������ֱ��ʵ�ռ��դ��ͼ�Ͷ�Ŀ����
%����������״�����myradar���ֱ���resol����ʼʱ��begin������ʱ��over
%���������ռ��դ��ͼ�Ͷ�Ŀ����ͼ
%��Ŀ����ԭ����ĳ��դ��ֻ��ÿ��ʱ�̹۲ⶼ��Ϊ����ռ�ݵģ����߶��ǿ��еģ��Ҳ���Ϊ���Ǿ�ֹ�ģ���������Ϊ���˶���

clc;
clear all;
close all;

%�����������
load radar.mat;
resol=3;        %��ͼ�ֱ���_�ֱ���Ϊ10����1m����10��
begin=1;        %������ͼ���
over=size(radar.time,2);  %������ͼ�յ�
%�����ص�ͼҪ��maping_occ������Ȩ�ز���
%��Ŀ����Ҫ��maping_detect������Ȩ�ز���

%�����ص�ͼ
[radar_temp,mapsize]=coordinate(radar,resol,begin,over);
map=maping_occ(radar_temp,mapsize,begin,over);   %����Ȩ�ز���
figure;
imagesc(map)
axis equal
colorbar
title('�������ģ�͵�ռ��դ��ͼ����ɫΪ���ϰ����ɫΪ���ϰ����ɫΪ�״�δɨ�赽')

%��ͼ����Ŀ����
[map,detect_map,mark_map]=maping_detect(radar_temp,mapsize,begin,over);
figure;
imagesc(mark_map)
axis equal
colorbar
title('��Ŀ����:��ɫΪ��Ŀ�꣬��ɫΪ��ֹ״̬����ɫΪ�״�δɨ�赽')
