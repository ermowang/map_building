%�����ܣ�ʹ��դ���Ȩ�ķ����õ�դ���ͼ��ÿһ��դ��ֵ
%���룺ȫ������ϵ�µĻ�������EnvirCoor����С�Ļ�����ͼ�ߴ�MapSize���״����Begin���״��յ�Over
%�����դ���ͼ��ÿһ��դ��ֵMap
%����ԭ��ÿ����һ���ϰ���ͼ�Ȩһ��

function Map=Mapping_Occu(EnvirCoor,MapSize,Begin,Over)

Map=zeros(MapSize(2),MapSize(1)); 
for i=Begin:Over     
    if(size(EnvirCoor{i},2)==1)
        continue
    end
    for j=1:size(EnvirCoor{i},1)
       Map(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=Map(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
    end
end
