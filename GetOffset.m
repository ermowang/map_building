%�������ܣ��õ�һ��n��2�����鹹�ɵ�ͼ����С�ߴ�Ͱ�����ȫ����Ϊ��������Сƫ��
%���룺һ��n��2����x
%��������ɵ�ͼ����С�ߴ�size��������ȫ����Ϊ��������Сƫ��offset
function [Size,Offset]=GetOffset(x)
minval(1,1)=min(x(:,1));
minval(1,2)=min(x(:,2));
maxval(1,1)=max(x(:,1));
maxval(1,2)=max(x(:,2));
Offset(1,1)=1-minval(1,1);
Offset(1,2)=1-minval(1,2);
Size(1,1)=(maxval(1,1)-minval(1,1))+1;
Size(1,2)=(maxval(1,2)-minval(1,2))+1;