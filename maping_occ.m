function  map=maping_occ(radar,mapsize,begin,over,p_occ,p_free)
%�����ܣ��õ�ռ��դ��ͼ��դ��ֵ
%���룺�״����ݶ�Ӧ��ͼ��դ�����꣬��С��Χ��ͼ����ʼʱ�̣�����ʱ��
%�����ռ��դ��ͼ��դ��ֵ

%����Ȩ�ز���
lo_occ=log(p_occ/(1-p_occ));
lo_free=log(p_free/(1-p_free));


%ȷ����С��ͼ
size_row=mapsize.x;
size_col=mapsize.y;
map=zeros(size_row+1,size_col+1); %��֪��Ϊʲô+1�����ǽ����bug
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
       map(free) = map(free)+lo_free;
    end
end
map=exp(map)./(1+exp(map));


