%程序功能：去除动目标的使用帧密度的方法得到栅格地图的每一个栅格值
%输入：全局坐标系下的环境坐标EnvirCoor、最小的环境地图尺寸MapSize、雷达起点Begin、雷达终点Over
%输出：栅格地图的每一个栅格值Map
%程序原理：将看到某栅格的总眼数/看到某栅格的总帧数,如果该障碍物为动目标，则跳过,不计算眼数和帧数

function MapStat=Mapping_Density_Static(EnvirCoor,MapSize,Begin,Over,MovIndex)

MapStat=zeros(MapSize(2),MapSize(1)); 
FrameCount=zeros(MapSize(2),MapSize(1));   %记录帧数
RrameMark=zeros(MapSize(2),MapSize(1));    %记录每一帧是否记录过

for i=Begin:Over     
    if(size(EnvirCoor{i},2)==1)
        continue
    end
    RrameMark=zeros(MapSize(2),MapSize(1));
    for j=1:size(EnvirCoor{i},1)
        Mark1=MovIndex-[i,j];Mark2=any(Mark1, 2);Mark3=all(Mark2);%有全0行Mark3为0，说明此处是动目标，否则为1
        if(Mark3==0)
            continue
        end
       MapStat(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=MapStat(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
        if RrameMark(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))==0
            FrameCount(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=FrameCount(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
            RrameMark(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=1;
        end    
    end
end

Index=find(MapStat~=0);
MapStat(Index)=MapStat(Index)./FrameCount(Index);

end