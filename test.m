clc;
clear all;
close all;

load moving.mat;
mark_map=zeros(size(detect_map));
length(unique(detect_map{11,24}))
% for i=1:size(detect_map,1)
%     for j=1:size(detect_map,2)
%         
%         if length(unique(detect_map{i,j}))==0
%             mark_map(i,j)=0.5;
%         end
%         if length(unique(detect_map{i,j}))==1
%             mark_map(i,j)=1;
%         end
%         if length(unique(detect_map{i,j}))==2
%            mark_map(i,j)=0;
%         end
%         
%     end
% end
% figure;
% imagesc(mark_map)
% axis equal
% colorbar