%函数功能：得到栅格图中动目标在全局坐标系中的坐标
%输入参数：动目标阈值Thres，雷达数据Data,起始位置Begin,终止位置Over,雷达位置标识RadarPosiMark,分辨率Resol,最小偏置CoorOffset
%输出参数：动目标在全局坐标系下的坐标MovCoor
%程序原理：利用径向速度重构雷达速度（取所有速度的平均值），如果有偏离平均值很大的点，就视为动目标

function MovCoor=MovObj_Detect(Thres,Data,Begin,Over,RadarPosiMark,Resol,CoorOffset)
%% 记录所有时刻重构的雷达速度，取平均值视为雷达速度
V=cell(size(Data.Radar));
V_Rec=0;       %记录全部的投影速度
for i=Begin:Over                  %每一个时间点
    if(size(Data.Radar{i},2)==1)   %没有点云就跳过
        V{i}=0;
        continue
    end
    yaw=Data.Yaw(i)-Data.Yaw(1);
    for j=1:size(Data.Radar{i},1)   %每一个点云内部
        V{i}(j,:)=V_Building(Data.Radar{i}(j,4),Data.Radar{i}(j,1),Data.Radar{i}(j,2),Data.Radar{i}(j,3),yaw,RadarPosiMark);
        V_Rec=[V_Rec;V{i}(j,:)];
    end
end
V_Rec(1,:)=[];
V_Ave=sum(sum(V_Rec))/numel(V_Rec);%计算静止应该出现的速度

%% 计算动目标的索引值
 MovIndex=[0 0];
for i=Begin:Over                  %每一个时间点
    if(size(Data.Radar{i},2)==1)   %没有点云就跳过
        continue
    end
    for j=1:size(Data.Radar{i},1)   %每一个点云内部
        if(V{i}(j,1)-V_Ave>Thres)
            MovIndex=[MovIndex;[i j]];
        end
    end
 end
 MovIndex(1,:)=[];


 %% 计算动目标在全局坐标系下的坐标
 MovCoor=zeros(size(MovIndex));
 for k=1:size(MovIndex,1)
     i=MovIndex(k,1);
     j=MovIndex(k,2);
     theta=Data.Yaw(i);
     RotMat=[cos(theta),sin(theta);-sin(theta),cos(theta)];
     MovCoor(k,:)=(RotMat*[Data.Radar{i}(j,1);Data.Radar{i}(j,2)] ...
         +[Data.Gps.x(i);Data.Gps.y(i)])';
 end
 MovCoor=ceil(Resol*MovCoor)+CoorOffset;

