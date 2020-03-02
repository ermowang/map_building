function  [map,index]=detect_occ(radar,mapsize,begin,over,p_occ,p_free,thres)
% function  [map,detect_map]=detect_occ(radar,mapsize,begin,over,p_occ,p_free)

%程序功能：得到占用栅格图的栅格值
%输入：雷达数据对应的图上栅格坐标，最小范围地图，开始时刻，结束时刻
%输出：占用栅格图的栅格值

%调节权重参数
lo_occ=log(p_occ/(1-p_occ));
lo_free=log(p_free/(1-p_free));


%确定最小地图
size_row=mapsize.x;
size_col=mapsize.y;
map=zeros(size_row+1,size_col+1); %不知道为什么+1，但是解决了bug
detect_map=cell(size(map)); 

%找到占用栅格和空闲栅格，更新栅格值
for i=begin:over 
    if(size(radar.data{i},2)==1)
        continue
    end
    for j=1:size(radar.data{i},1)
       [freex,freey] = bresenham(radar.gps(i).x,radar.gps(i).y,radar.data{i}(j,1),radar.data{i}(j,2));
       free = sub2ind(size(map),freex,freey);
       %更新栅格值
       map(radar.data{i}(j,1),radar.data{i}(j,2))=map(radar.data{i}(j,1),radar.data{i}(j,2))+lo_occ;
       map(free) = map(free)+lo_free;
       %动目标检测
       tp_occ=map(radar.data{i}(j,1),radar.data{i}(j,2));    
       detect_map{radar.data{i}(j,1),radar.data{i}(j,2)}=[detect_map{radar.data{i}(j,1),radar.data{i}(j,2)};[p_occ,exp(tp_occ)./(1+exp(tp_occ)),p_occ-exp(tp_occ)./(1+exp(tp_occ)),i]];
       if size(free,1)==0|size(free,2)==0
           continue
       end
       for k=1:size(free,1)
           tp_free=map(freex(k),freey(k));
           detect_map{freex(k),freey(k)}=[detect_map{freex(k),freey(k)};[p_free,exp(tp_free)./(1+exp(tp_free)),p_occ-exp(tp_occ)./(1+exp(tp_occ)),i]];
       end
    end
end
map=exp(map)./(1+exp(map));

%动目标位置标记
mark_map=zeros(size(detect_map));
for i=1:size(detect_map,1)
    for j=1:size(detect_map,2)
        if isempty(detect_map{i,j})==1|map(i,j)<=0.5  %%擅自改动
           mark_map(i,j)=0; 
    
        else
            mark=detect_map{i,j};
            mark_map(i,j)=max(mark(:,3));
        end
       
    end
end


index1=[0 0];
for i=1:size(mark_map,1)
    for j=1:size(mark_map,2)
        if mark_map(i,j)>thres
            index1=[index1;i,j];
        end
    end
end
index=index1(2:end,:);


