%����ʦ�ּ����ع��ٶȵĴ���

function vout=get_motion_speed(x,y,z,v)
yaw=atan(x./y);
d=sqrt(x.^2+y.^2);
pitch=atan(z./d);
vout=v./(abs(yaw))./cos(abs(pitch));
end