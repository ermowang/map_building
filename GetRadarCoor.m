%�����ܣ��õ��״���ȫ������ϵ�е�λ�ñ仯
%���룺�״�����Data,�ֱ���Resol���״����Begin���״��յ�Over���������겹������С�����Ĳ���ֵCoorOffset
%������״���ȫ������ϵ�е�λ������

function [Radar_Coor]=GetRadarCoor(Data,Resol,Begin,Over,CoorOffset)

for i=Begin:Over
    Radar_Coor(:,1)= ceil(Resol*Data.Gps.x)+CoorOffset(1);
    Radar_Coor(:,2)= ceil(Resol*Data.Gps.y)+CoorOffset(2);
end