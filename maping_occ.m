function  map=maping_occ(radar,mapsize,begin,over,p_occ,p_free)
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
    end
end
map=exp(map)./(1+exp(map));


