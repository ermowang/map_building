%�������ܣ���ԭʼ����ת��Ϊ����Ҫ�����ݸ�ʽ
%���������Gps,Radar,Yaw
%������������ϸ�ʽ������Data
%����ԭ����ʽת�����ɣ�Gps�����Ե�һ������Ϊԭ�㣬Yaw�Ǹ����״�λ���Ե�һ��Yaw��Ϊ��׼���в���


function Data=GetData(Gps,Radar,Yaw,RadarPosiMark)

Data.Time=Gps.time;
Data.Radar=Radar;

Data.Gps.x=Gps.xEast-Gps.xEast(1);
Data.Gps.y=Gps.yNorth-Gps.yNorth(1);

if RadarPosiMark==-1
    Data.Yaw=deg2rad(Yaw-Yaw(1));    %���
elseif RadarPosiMark==0
    Data.Yaw=deg2rad(Yaw-Yaw(1)+90);    %ǰ��
elseif RadarPosiMark==1
    Data.Yaw=deg2rad(Yaw-Yaw(1)+180);    %�ұ�
end
