function  [map,detect_map,mark_map]=maping_detect(radar,mapsize,begin,over)
%程序功能：动目标检测：对某个栅格，只有每个时刻观测都认为它是占据的，或者都是空闲的，我才认为它是静止的；否则我认为是运动的
%输入：雷达数据对应的图上栅格坐标，最小范围地图，开始时刻，结束时刻
%输出：占用栅格图的栅格值（bresenham算法包含起点和终点）、detect_map收集的对每个栅格所有时刻的当前占据状态、mark_map动目标检测栅格图标记

%调节权重参数
lo_occ = 0.9;
lo_free = 0.7; 
lo_max =2;
lo_min = -2;


%确定最小地图
size_row=mapsize.x;
size_col=mapsize.y;
map=zeros(size_row,size_col);
detect_map=cell(size_row,size_col); 

%找到占用栅格和空闲栅格，更新栅格值
for i=begin:over 
    if(size(radar.data{i},2)==1)
        continue
    end
    for j=1:size(radar.data{i},1)
       [freex,freey] = bresenham1(radar.gps(i).x,radar.gps(i).y,radar.data{i}(j,1),radar.data{i}(j,2));
       free = sub2ind(size(map),freex,freey);
       %更新栅格值
       map(radar.data{i}(j,1),radar.data{i}(j,2))=map(radar.data{i}(j,1),radar.data{i}(j,2))+lo_occ;
       map(free) = map(free)-lo_free;
       map(map>lo_max)= lo_max;
       map(map<lo_min)= lo_min;
       %动目标检测：收集对每个栅格所有时刻的当前占据状态
       detect_map{radar.data{i}(j,1),radar.data{i}(j,2)}=[detect_map{radar.data{i}(j,1),radar.data{i}(j,2)};lo_occ];
       for k=1:size(free,1)
           detect_map{freex(k),freey(k)}=[detect_map{freex(k),freey(k)};-lo_free];
       end
    end

end
%动目标检测：对某个栅格，只有每个时刻观测都认为它是占据的，或者都是空闲的，我才认为它是静止的；否则我认为是运动的
mark_map=zeros(size(detect_map));

for i=1:size(detect_map,1)
    for j=1:size(detect_map,2)       
        if length(unique(detect_map{i,j}))==0  %雷达未检测到
            mark_map(i,j)=0.5;
        end
        if length(unique(detect_map{i,j}))==1   %检测为运动的
            mark_map(i,j)=1;
        end
        if length(unique(detect_map{i,j}))==2   %检测为静止的
           mark_map(i,j)=0;
        end
        
    end
end



