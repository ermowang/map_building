%�����ܣ����״�̽��Ļ�������任��GPS��ȫ��������
%���룺�״�����Data,�ֱ���Resol���״����Begin���״��յ�Over
%�����ȫ������ϵ�µĻ�������EnvirCoor����С�Ļ�����ͼ�ߴ�MapSize���������겹������С�����Ĳ���ֵCoorOffset
%����ԭ��ʹ������任�����״�̽��Ļ�������任��GPS��ȫ�������У����õ���С�Ļ�����ͼ�ߴ�

function [EnvirCoor,MapSize,CoorOffset]=GetEnvirCoor(Data,Resol,Begin,Over)
%% ���㻷���任��GPSȫ������ϵ�е�����
k=1;
EnvirCoor=cell(size(Data.Radar));
for i=Begin:Over                  %ÿһ��ʱ���
    if(size(Data.Radar{i},2)==1)   %û�е��ƾ�����
        EnvirCoor{i}=0;
        continue
    end
    for j=1:size(Data.Radar{i},1)   %ÿһ�������ڲ�
       %�����Ŀ��ʵ������      
       theta=Data.Yaw(i);  
       RotMat=[cos(theta),sin(theta);-sin(theta),cos(theta)];
       EnvirCoor{i}(:,j)=RotMat*[Data.Radar{i}(j,1);Data.Radar{i}(j,2)] ...
           +[Data.Gps.x(i);Data.Gps.y(i)];
       EnvirCoor{i}(:,j)=ceil(Resol*EnvirCoor{i}(:,j));
       %�ѻ�������㼯����
       EnvirCoorRec(k,:)=EnvirCoor{i}(:,j);
       k=k+1;
    end
    EnvirCoor{i}=EnvirCoor{i}';
end


%% ������ȫ����Ϊ����
[MapSize,CoorOffset]=GetOffset(EnvirCoorRec);
for i=Begin:Over                  %ÿһ��ʱ���
    if(size(Data.Radar{i},2)==1)   %û�е��ƾ�����
        continue
    end
    for j=1:size(Data.Radar{i},1)   %ÿһ�������ڲ�       
        EnvirCoor{i}(j,:)=EnvirCoor{i}(j,:)+CoorOffset;    
    end    
end
