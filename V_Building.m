%�������ܣ��ع��״��ٶ�
%��������������ٶ�Vr,�״���ά����x,y,z,�״﷽��΢���Ƕ�yaw,�״�λ�ñ�ʶRadarPosiMark
%����������ع����״��ٶ�V
%����ԭ���״��ٶ�ͶӰ��ƽ��ľ���һ�Σ���ͶӰ���߶ȵľ���һ�εõ�̽��ľ����ٶȣ������㼴�õ��״��ٶ�
function V=V_Building(Vr,x,y,z,yaw,RadarPosiMark)

if RadarPosiMark==-1   %���
    Ang_xy=pi/2+atan2(y,x);
elseif RadarPosiMark==0  %ǰ��
    Ang_xy=atan2(y,x);
elseif RadarPosiMark==1  %�Ҳ�
    Ang_xy=-pi/2+atan2(y,x);
end
Ang_xy_True=Ang_xy+yaw;    %���ǵ�yaw΢��֮��Ķ�ά����Ƕ�
Ang_xyz=asin(z/norm([x,y,z],2));  %�߶��ϵľ���Ƕ�
        
V=-Vr./cos(Ang_xyz)./sin(Ang_xy_True);      
