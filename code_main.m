clc
clear all
close all
warning off
[filename, path] = uigetfile('*.*', 'Select the image file');
file_name  = strcat(path, filename);
image=imread(file_name);
imshow(image);
greyscaled_image=rgb2gray(image);
% imshow(greyscaled_image)
% impixelinfo;
binarized_image=greyscaled_image>20;
% figure;
% imshow(binarized_image);
filled_binarized_image=imfill(binarized_image, 'holes');
% figure;
% imshow(filled_binarized_image);
area_opened_binarized_image=bwareaopen(filled_binarized_image, 1000);
% figure;
% imshow(area_opened_binarized_image);
preprocessed_image=double(image).*repmat(area_opened_binarized_image, [1 1 3]);
preprocessed_image=uint8(preprocessed_image);
figure;
imshow(preprocessed_image); 