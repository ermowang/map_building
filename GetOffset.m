%函数功能：得到一个n行2列数组构成地图的最小尺寸和把数组全补偿为正数的最小偏置
%输入：一个n行2列数x
%输出：构成地图的最小尺寸size，把数组全补偿为正数的最小偏置offset
function [Size,Offset]=GetOffset(x)
minval(1,1)=min(x(:,1));
minval(1,2)=min(x(:,2));
maxval(1,1)=max(x(:,1));
maxval(1,2)=max(x(:,2));
Offset(1,1)=1-minval(1,1);
Offset(1,2)=1-minval(1,2);
Size(1,1)=(maxval(1,1)-minval(1,1))+1;
Size(1,2)=(maxval(1,2)-minval(1,2))+1;