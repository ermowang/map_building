function  [map,detect_map,mark_map]=maping_detect(radar,mapsize,begin,over)
%�����ܣ���Ŀ���⣺��ĳ��դ��ֻ��ÿ��ʱ�̹۲ⶼ��Ϊ����ռ�ݵģ����߶��ǿ��еģ��Ҳ���Ϊ���Ǿ�ֹ�ģ���������Ϊ���˶���
%���룺�״����ݶ�Ӧ��ͼ��դ�����꣬��С��Χ��ͼ����ʼʱ�̣�����ʱ��
%�����ռ��դ��ͼ��դ��ֵ��bresenham�㷨���������յ㣩��detect_map�ռ��Ķ�ÿ��դ������ʱ�̵ĵ�ǰռ��״̬��mark_map��Ŀ����դ��ͼ���

%����Ȩ�ز���
lo_occ = 0.9;
lo_free = 0.7; 
lo_max =2;
lo_min = -2;


%ȷ����С��ͼ
size_row=mapsize.x;
size_col=mapsize.y;
map=zeros(size_row,size_col);
detect_map=cell(size_row,size_col); 

%�ҵ�ռ��դ��Ϳ���դ�񣬸���դ��ֵ
for i=begin:over 
    if(size(radar.data{i},2)==1)
        continue
    end
    for j=1:size(radar.data{i},1)
       [freex,freey] = bresenham1(radar.gps(i).x,radar.gps(i).y,radar.data{i}(j,1),radar.data{i}(j,2));
       free = sub2ind(size(map),freex,freey);
       %����դ��ֵ
       map(radar.data{i}(j,1),radar.data{i}(j,2))=map(radar.data{i}(j,1),radar.data{i}(j,2))+lo_occ;
       map(free) = map(free)-lo_free;
       map(map>lo_max)= lo_max;
       map(map<lo_min)= lo_min;
       %��Ŀ���⣺�ռ���ÿ��դ������ʱ�̵ĵ�ǰռ��״̬
       detect_map{radar.data{i}(j,1),radar.data{i}(j,2)}=[detect_map{radar.data{i}(j,1),radar.data{i}(j,2)};lo_occ];
       for k=1:size(free,1)
           detect_map{freex(k),freey(k)}=[detect_map{freex(k),freey(k)};-lo_free];
       end
    end

end
%��Ŀ���⣺��ĳ��դ��ֻ��ÿ��ʱ�̹۲ⶼ��Ϊ����ռ�ݵģ����߶��ǿ��еģ��Ҳ���Ϊ���Ǿ�ֹ�ģ���������Ϊ���˶���
mark_map=zeros(size(detect_map));

for i=1:size(detect_map,1)
    for j=1:size(detect_map,2)       
        if length(unique(detect_map{i,j}))==0  %�״�δ��⵽
            mark_map(i,j)=0.5;
        end
        if length(unique(detect_map{i,j}))==1   %���Ϊ�˶���
            mark_map(i,j)=1;
        end
        if length(unique(detect_map{i,j}))==2   %���Ϊ��ֹ��
           mark_map(i,j)=0;
        end
        
    end
end



