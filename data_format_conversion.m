%�������ܣ���ʦ�ָ��ĵ��Ĵ����ݵĸ�ʽת��Ϊ��һ�����ݵĸ�ʽ
%�Ķ�������1.����������ļ���
%          2.�����ڵ�ǰ�������״����ݵ�ѡ��
clc; 
clear all;
close all;

load 'data1.mat';%�����ɸĶ�

mark=gps.time;
radar.time=mark';
radar.data=radar_right';            %�����ɸĶ�
x=gps.xEast-gps.xEast(1);
y=gps.yNorth-gps.yNorth(1);
for i=1:size(radar.time,2)    
    radar.gps(i).x=x(i);
    radar.gps(i).y=y(i);
    radar.gps(i).yaw=yaw_save(i);
end
save('radar.mat', 'radar'); 