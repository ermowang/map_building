%�����ܣ�ʹ��֡�ܶȵķ����õ�դ���ͼ��ÿһ��դ��ֵ
%���룺ȫ������ϵ�µĻ�������EnvirCoor����С�Ļ�����ͼ�ߴ�MapSize���״����Begin���״��յ�Over
%�����դ���ͼ��ÿһ��դ��ֵMap
%����ԭ��������ĳդ���������/����ĳդ�����֡��

function Map=Mapping_Density(EnvirCoor,MapSize,Begin,Over)

Map=zeros(MapSize(2),MapSize(1)); 
FrameCount=zeros(MapSize(2),MapSize(1));   %��¼֡��
RrameMark=zeros(MapSize(2),MapSize(1));    %��¼ÿһ֡�Ƿ��¼��

for i=Begin:Over     
    if(size(EnvirCoor{i},2)==1)
        continue
    end
    RrameMark=zeros(MapSize(2),MapSize(1));
    for j=1:size(EnvirCoor{i},1)
       Map(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=Map(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
        if RrameMark(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))==0
            FrameCount(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=FrameCount(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))+1;
            RrameMark(EnvirCoor{i}(j,2),EnvirCoor{i}(j,1))=1;
        end    
    end
end

Index=find(Map~=0);
Map(Index)=Map(Index)./FrameCount(Index);

end