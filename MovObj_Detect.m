%�������ܣ��õ�դ��ͼ�ж�Ŀ����ȫ������ϵ�е�����
%�����������Ŀ����ֵThres���״�����Data,��ʼλ��Begin,��ֹλ��Over,�״�λ�ñ�ʶRadarPosiMark,�ֱ���Resol,��Сƫ��CoorOffset
%�����������Ŀ����ȫ������ϵ�µ�����MovCoor
%����ԭ�����þ����ٶ��ع��״��ٶȣ�ȡ�����ٶȵ�ƽ��ֵ���������ƫ��ƽ��ֵ�ܴ�ĵ㣬����Ϊ��Ŀ��

function MovCoor=MovObj_Detect(Thres,Data,Begin,Over,RadarPosiMark,Resol,CoorOffset)
%% ��¼����ʱ���ع����״��ٶȣ�ȡƽ��ֵ��Ϊ�״��ٶ�
V=cell(size(Data.Radar));
V_Rec=0;       %��¼ȫ����ͶӰ�ٶ�
for i=Begin:Over                  %ÿһ��ʱ���
    if(size(Data.Radar{i},2)==1)   %û�е��ƾ�����
        V{i}=0;
        continue
    end
    yaw=Data.Yaw(i)-Data.Yaw(1);
    for j=1:size(Data.Radar{i},1)   %ÿһ�������ڲ�
        V{i}(j,:)=V_Building(Data.Radar{i}(j,4),Data.Radar{i}(j,1),Data.Radar{i}(j,2),Data.Radar{i}(j,3),yaw,RadarPosiMark);
        V_Rec=[V_Rec;V{i}(j,:)];
    end
end
V_Rec(1,:)=[];
V_Ave=sum(sum(V_Rec))/numel(V_Rec);%���㾲ֹӦ�ó��ֵ��ٶ�

%% ���㶯Ŀ�������ֵ
 MovIndex=[0 0];
for i=Begin:Over                  %ÿһ��ʱ���
    if(size(Data.Radar{i},2)==1)   %û�е��ƾ�����
        continue
    end
    for j=1:size(Data.Radar{i},1)   %ÿһ�������ڲ�
        if(V{i}(j,1)-V_Ave>Thres)
            MovIndex=[MovIndex;[i j]];
        end
    end
 end
 MovIndex(1,:)=[];


 %% ���㶯Ŀ����ȫ������ϵ�µ�����
 MovCoor=zeros(size(MovIndex));
 for k=1:size(MovIndex,1)
     i=MovIndex(k,1);
     j=MovIndex(k,2);
     theta=Data.Yaw(i);
     RotMat=[cos(theta),sin(theta);-sin(theta),cos(theta)];
     MovCoor(k,:)=(RotMat*[Data.Radar{i}(j,1);Data.Radar{i}(j,2)] ...
         +[Data.Gps.x(i);Data.Gps.y(i)])';
 end
 MovCoor=ceil(Resol*MovCoor)+CoorOffset;

