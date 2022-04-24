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
% figure;
% imshow(preprocessed_image);

% Reduce Brightness to the Image (gaussian)
preprocessd_image_with_brightness=uint8(preprocessed_image+50);
figure;
imshow(preprocessd_image_with_brightness);

preprocessed_image=imadjust(preprocessd_image_with_brightness,[0.3, 0.7], [])+50;
% figure;
% imshow(preprocessed_image);
greyscaled_preprocessed_image=rgb2gray(preprocessed_image);
% figure;
% imshow(greyscaled_preprocessed_image);
median_filtered_greyscaled_preprocessed_image=medfilt2(greyscaled_preprocessed_image, [5 5]);
% figure;
% imshow(median_filtered_greyscaled_preprocessed_image);
binarized_median_filtered_greyscaled_preprocessed_image=median_filtered_greyscaled_preprocessed_image>250;
% figure;
% imshow(binarized_median_filtered_greyscaled_preprocessed_image);
[rows, cols, m]=size(binarized_median_filtered_greyscaled_preprocessed_image);
x1=rows/2;
y1=cols/3;
row=[x1 x1+200 x1+200 x1];
col=[y1 y1 y1+40 y1+40];
mask=roipoly(binarized_median_filtered_greyscaled_preprocessed_image, row, col);
masked_binarized_median_filtered_greyscaled_preprocessed_image=binarized_median_filtered_greyscaled_preprocessed_image.*double(mask);
% figure;
% imshow(masked_binarized_median_filtered_greyscaled_preprocessed_image);
final_image=bwareaopen(masked_binarized_median_filtered_greyscaled_preprocessed_image, 4);
figure;
imshow(final_image);
[ya, number]=bwlabel(final_image);
if(number>=1)
    disp('kidney stone is detected');
else
    disp('no kidney stone is detected');
end