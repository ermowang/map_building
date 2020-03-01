function  map=maping_occ(radar,mapsize,begin,over)
%�����ܣ��õ�ռ��դ��ͼ��դ��ֵ
%���룺�״����ݶ�Ӧ��ͼ��դ�����꣬��С��Χ��ͼ����ʼʱ�̣�����ʱ��
%�����ռ��դ��ͼ��դ��ֵ

%����Ȩ�ز���
lo_occ = 0.9;
lo_free = 0.7; 
lo_max =2;
lo_min = -2;

%ȷ����С��ͼ
size_row=mapsize.x;
size_col=mapsize.y;
map=zeros(size_row,size_col); 
%�ҵ�ռ��դ��Ϳ���դ�񣬸���դ��ֵ
for i=begin:over 
    if(size(radar.data{i},2)==1)
        continue
    end
    for j=1:size(radar.data{i},1)
       [freex,freey] = bresenham(radar.gps(i).x,radar.gps(i).y,radar.data{i}(j,1),radar.data{i}(j,2));
       free = sub2ind(size(map),freex,freey);
       %����դ��ֵ
       map(radar.data{i}(j,1),radar.data{i}(j,2))=map(radar.data{i}(j,1),radar.data{i}(j,2))+lo_occ;
       map(free) = map(free)-lo_free;
    end
end
map(map>lo_max)= lo_max;
map(map<lo_min)= lo_min;


