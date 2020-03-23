%函数功能：将原始数据转换为我需要的数据格式
%输入参数：Gps,Radar,Yaw
%输出参数：符合格式的数据Data
%程序原理：格式转换即可，Gps坐标以第一个坐标为原点，Yaw角根据雷达位置以第一个Yaw角为标准进行补偿


function Data=GetData(Gps,Radar,Yaw,RadarPosiMark)

Data.Time=Gps.time;
Data.Radar=Radar;

Data.Gps.x=Gps.xEast-Gps.xEast(1);
Data.Gps.y=Gps.yNorth-Gps.yNorth(1);

if RadarPosiMark==-1
    Data.Yaw=deg2rad(Yaw-Yaw(1));    %左边
elseif RadarPosiMark==0
    Data.Yaw=deg2rad(Yaw-Yaw(1)+90);    %前边
elseif RadarPosiMark==1
    Data.Yaw=deg2rad(Yaw-Yaw(1)+180);    %右边
end
