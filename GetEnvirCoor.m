%程序功能：将雷达探测的环境坐标变换到GPS的全局坐标中
%输入：雷达数据Data,分辨率Resol，雷达起点Begin，雷达终点Over
%输出：全局坐标系下的环境坐标EnvirCoor、最小的环境地图尺寸MapSize，环境坐标补偿到最小正数的补偿值CoorOffset
%程序原理：使用坐标变换矩阵将雷达探测的环境坐标变换到GPS的全局坐标中，并得到最小的环境地图尺寸

function [EnvirCoor,MapSize,CoorOffset]=GetEnvirCoor(Data,Resol,Begin,Over)
%% 计算环境变换到GPS全局坐标系中的坐标
k=1;
EnvirCoor=cell(size(Data.Radar));
for i=Begin:Over                  %每一个时间点
    if(size(Data.Radar{i},2)==1)   %没有点云就跳过
        EnvirCoor{i}=0;
        continue
    end
    for j=1:size(Data.Radar{i},1)   %每一个点云内部
       %计算各目标实际坐标      
       theta=Data.Yaw(i);  
       RotMat=[cos(theta),sin(theta);-sin(theta),cos(theta)];
       EnvirCoor{i}(:,j)=RotMat*[Data.Radar{i}(j,1);Data.Radar{i}(j,2)] ...
           +[Data.Gps.x(i);Data.Gps.y(i)];
       EnvirCoor{i}(:,j)=ceil(Resol*EnvirCoor{i}(:,j));
       %把环境坐标汇集起来
       EnvirCoorRec(k,:)=EnvirCoor{i}(:,j);
       k=k+1;
    end
    EnvirCoor{i}=EnvirCoor{i}';
end


%% 把坐标全部变为正数
[MapSize,CoorOffset]=GetOffset(EnvirCoorRec);
for i=Begin:Over                  %每一个时间点
    if(size(Data.Radar{i},2)==1)   %没有点云就跳过
        continue
    end
    for j=1:size(Data.Radar{i},1)   %每一个点云内部       
        EnvirCoor{i}(j,:)=EnvirCoor{i}(j,:)+CoorOffset;    
    end    
end
