%程序功能：使用栅格加权的方法得到栅格地图的每一个栅格值
%输入：全局坐标系下的环境坐标EnvirCoor、最小的环境地图尺寸MapSize、雷达起点Begin、雷达终点Over
%输出：栅格地图的每一个栅格值Map
%程序原理：每看到一次障碍物就加权一次

function Map=Mapping_Occu(EnvirCoor,MapSize,Begin,Over)

Map=zeros(MapSize(2),MapSize(1)); 
for i=Begin:Over     
    if(size(EnvirCoor{i},2)==1)
        continue
    end
    for j=1:size(EnvirCoor{i},1)
       Map(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=Map(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
    end
end
