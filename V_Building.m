%函数功能：重构雷达速度
%输入参数：径向速度Vr,雷达三维坐标x,y,z,雷达方向微调角度yaw,雷达位置标识RadarPosiMark
%输出参数：重构的雷达速度V
%程序原理：雷达速度投影到平面的径向一次，再投影到高度的径向一次得到探测的径向速度，逆运算即得到雷达速度
function V=V_Building(Vr,x,y,z,yaw,RadarPosiMark)

if RadarPosiMark==-1   %左侧
    Ang_xy=pi/2+atan2(y,x);
elseif RadarPosiMark==0  %前侧
    Ang_xy=atan2(y,x);
elseif RadarPosiMark==1  %右侧
    Ang_xy=-pi/2+atan2(y,x);
end
Ang_xy_True=Ang_xy+yaw;    %考虑到yaw微调之后的二维径向角度
Ang_xyz=asin(z/norm([x,y,z],2));  %高度上的径向角度
        
V=-Vr./cos(Ang_xyz)./sin(Ang_xy_True);      
