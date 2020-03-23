%程序功能：使用帧密度的方法得到栅格地图的每一个栅格值
%输入：全局坐标系下的环境坐标EnvirCoor、最小的环境地图尺寸MapSize、雷达起点Begin、雷达终点Over
%输出：栅格地图的每一个栅格值Map
%程序原理：将看到某栅格的总眼数/看到某栅格的总帧数

function Map=Mapping_Density(EnvirCoor,MapSize,Begin,Over)

Map=zeros(MapSize(2),MapSize(1)); 
FrameCount=zeros(MapSize(2),MapSize(1));   %记录帧数
RrameMark=zeros(MapSize(2),MapSize(1));    %记录每一帧是否记录过

for i=Begin:Over     
    if(size(EnvirCoor{i},2)==1)
        continue
    end
    RrameMark=zeros(MapSize(2),MapSize(1));
    for j=1:size(EnvirCoor{i},1)
       Map(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=Map(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
        if RrameMark(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))==0
            FrameCount(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=FrameCount(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
            RrameMark(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=1;
        end    
    end
end

Index=find(Map~=0);
Map(Index)=Map(Index)./FrameCount(Index);

end