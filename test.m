clc; 
clear all;
close all;


thres=0.7;

load detect_map.mat;

mark_map=zeros(size(detect_map));
for i=1:size(detect_map,1)
    for j=1:size(detect_map,2)
        if isempty(detect_map{i,j})==1
           mark_map(i,j)=0; 
        else
            mark=detect_map{i,j};
            mark_map(i,j)=max(mark(:,3));
        end
       
    end
end


index=[0 0];
for i=1:size(mark_map,1)
    for j=1:size(mark_map,2)
        if mark_map(i,j)>thres
            index=[index;i,j];
        end
    end
end























% ‰»Î≤Œ ˝

% map=ones(5,4);
% detect_map=cell(size(map));
% detect_map{2,3}=[detect_map{2,3};[0.7,0.8,5]];
% detect_map{2,3}=[detect_map{2,3};[0.8,0.8,5]];
%        for k=1:size(free,1)
%            detect_map{freex(k),freey(k)}=[detect_map{freex(k),freey(k)};[p_free,map(freex(k),freey(k)),i]];
%        end
% [x,y]=bresenham(1,1,1,1)
% sum=0;
% for i=1:100
%     if size(x,1)==0|size(x,2)==0
%         continue
%     end
%     sum=sum+i
% end
% sum
