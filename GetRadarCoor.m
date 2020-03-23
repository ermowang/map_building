%程序功能：得到雷达在全局坐标系中的位置变化
%输入：雷达数据Data,分辨率Resol，雷达起点Begin，雷达终点Over，环境坐标补偿到最小正数的补偿值CoorOffset
%输出：雷达在全局坐标系中的位置坐标

function [Radar_Coor]=GetRadarCoor(Data,Resol,Begin,Over,CoorOffset)

for i=Begin:Over
    Radar_Coor(:,1)= ceil(Resol*Data.Gps.x)+CoorOffset(1);
    Radar_Coor(:,2)= ceil(Resol*Data.Gps.y)+CoorOffset(2);
end