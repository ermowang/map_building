%程序功能：去除动目标的栅格加权的得到栅格值
%输入：全局坐标系下的环境坐标EnvirCoor、最小的环境地图尺寸MapSize、雷达起点Begin、雷达终点Over
%输出：栅格地图的每一个栅格值Map
%程序原理：每看到一次障碍物就加权一次，如果该障碍物为动目标，则跳过

function MapStat=Mapping_Occu_Static(EnvirCoor,MapSize,Begin,Over,MovIndex)

MapStat=zeros(MapSize(2),MapSize(1)); 
for i=Begin:Over     
    if(size(EnvirCoor{i},2)==1)
        continue
    end
    for j=1:size(EnvirCoor{i},1)
        Mark1=MovIndex-[i,j];Mark2=any(Mark1, 2);Mark3=all(Mark2);%有全0行Mark3为0，说明此处是动目标，否则为1
        if(Mark3==0)
            continue
        end
        MapStat(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=MapStat(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
    end
end

