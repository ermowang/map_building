%�����ܣ�ȥ����Ŀ���դ���Ȩ�ĵõ�դ��ֵ
%���룺ȫ������ϵ�µĻ�������EnvirCoor����С�Ļ�����ͼ�ߴ�MapSize���״����Begin���״��յ�Over
%�����դ���ͼ��ÿһ��դ��ֵMap
%����ԭ��ÿ����һ���ϰ���ͼ�Ȩһ�Σ�������ϰ���Ϊ��Ŀ�꣬������

function MapStat=Mapping_Occu_Static(EnvirCoor,MapSize,Begin,Over,MovIndex)

MapStat=zeros(MapSize(2),MapSize(1)); 
for i=Begin:Over     
    if(size(EnvirCoor{i},2)==1)
        continue
    end
    for j=1:size(EnvirCoor{i},1)
        Mark1=MovIndex-[i,j];Mark2=any(Mark1, 2);Mark3=all(Mark2);%��ȫ0��Mark3Ϊ0��˵���˴��Ƕ�Ŀ�꣬����Ϊ1
        if(Mark3==0)
            continue
        end
        MapStat(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=MapStat(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
    end
end

