clc
clear all
close all
warning off
[filename,pathname]=uigetfile('*.*','Pick a MATLAB code file');
filename=strcat(pathname,filename);
a=imread(filename);
imshow(a);
b=rgb2gray(a);
figure;
imshow(b);
impixelinfo;
c=b>20;
figure;
imshow(c);
d=imfill(c,'holes');
figure;
imshow(d);
e=bwareaopen(d,1000);
figure;
imshow(e);
PreprocessedImage=uint8(double(a).*repmat(e,[1 1 3]));
figure;
imshow(PreprocessedImage);
PreprocessedImage=imadjust(PreprocessedImage,[0.3 0.7],[])+50;
figure;
imshow(PreprocessedImage);
uo=rgb2gray(PreprocessedImage);
figure;
imshow(uo);
mo=medfilt2(uo,[5 5]);
figure;
imshow(mo);
po=mo>250;
figure;
imshow(po);
[r c m]=size(po);
x1=r/2;
y1=c/3;
row=[x1 x1+200 x1+200 x1];
col=[y1 y1 y1+40 y1+40];
BW=roipoly(po,row,col);
figure;
imshow(BW);
k=po.*double(BW);
figure;
imshow(k);
M=bwareaopen(k,4);
[ya number]=bwlabel(M);
if(number>=1)
    disp('Stone is Detected');
else
    disp('No Stone is detected');
end