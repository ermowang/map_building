clc; 
clear all;
close all;

%�������

map=ones(5,4);
              [x y]=bresenham(1,1, 7,8);
              free = sub2ind(size(map),x,y);