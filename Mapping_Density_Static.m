%�����ܣ�ȥ����Ŀ���ʹ��֡�ܶȵķ����õ�դ���ͼ��ÿһ��դ��ֵ
%���룺ȫ������ϵ�µĻ�������EnvirCoor����С�Ļ�����ͼ�ߴ�MapSize���״����Begin���״��յ�Over
%�����դ���ͼ��ÿһ��դ��ֵMap
%����ԭ��������ĳդ���������/����ĳդ�����֡��,������ϰ���Ϊ��Ŀ�꣬������,������������֡��

function MapStat=Mapping_Density_Static(EnvirCoor,MapSize,Begin,Over,MovIndex)

MapStat=zeros(MapSize(2),MapSize(1)); 
FrameCount=zeros(MapSize(2),MapSize(1));   %��¼֡��
RrameMark=zeros(MapSize(2),MapSize(1));    %��¼ÿһ֡�Ƿ��¼��

for i=Begin:Over     
    if(size(EnvirCoor{i},2)==1)
        continue
    end
    RrameMark=zeros(MapSize(2),MapSize(1));
    for j=1:size(EnvirCoor{i},1)
        Mark1=MovIndex-[i,j];Mark2=any(Mark1, 2);Mark3=all(Mark2);%��ȫ0��Mark3Ϊ0��˵���˴��Ƕ�Ŀ�꣬����Ϊ1
        if(Mark3==0)
            continue
        end
       MapStat(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=MapStat(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
        if RrameMark(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))==0
            FrameCount(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=FrameCount(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
            RrameMark(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=1;
        end    
    end
end

Index=find(MapStat~=0);
MapStat(Index)=MapStat(Index)./FrameCount(Index);

end