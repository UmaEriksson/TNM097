clc;
clear all;

load xyz.mat;
load Inkjet.mat;
load DLP.mat;
load Dell.mat;
load colorhalftones.mat;

P_gray = im2double(imread('peppers_gray.tif'));
P_color = im2double(imread('peppers_color.tif'));

%% 1
% plot_chrom(XYZdell, 'blue');
% plot_chrom(XYZinkjet, 'red');

%Vilken som är bäst beror på exakt vad man vill åstakomma. Vill man ha mer
%gul är inkjet, om man vill ha röd kan dell vara bättre. 

%% 2.1

% P_gray_H(P_gray > 0.9) = 0.9;
% P_gray_H(P_gray < 0.1) = 0.1;

% P_gray_H = P_gray;
% 
% if (P_gray > 0.9)
%     P_gray_H = 0.9;
%     
% elseif (P_gray < 0.1)
%     P_gray_H = 0.1
% end
% 
% noise = P_gray - P_gray_H;
% 
% mysnr(P_gray, noise);

%% 2.1.1

P = imresize(imresize(P_gray,0.25,'nearest'),4,'nearest');
P2 = imresize(imresize(P_gray,0.25,'bilinear'),4,'bilinear');
P3 = imresize(imresize(P_gray,0.25,'bicubic'),4,'bicubic');

% figure(1)
% imshow(P_gray);
% 
% figure(2)
% imshow(P);
% 
% figure(3)
% imshow(P2);
% 
% figure(4)
% imshow(P3);


%nearest - sucks, bilinear - ok but blurry, bicubic - ok but also kindah
%blurry. ingen är perfekt men vi accepterar bicubic

P_SNR_n = mysnr(P_gray, P_gray-P);
P_SNR_bl = mysnr(P_gray, P_gray-P2);
P_SNR_bc = mysnr(P_gray, P_gray-P3);

% What is a good SNR value, 19 bättre än 17. Högre värde - ser bättre ut
% engligt oss. 

%% 2.1.2

P_gray_t = P_gray;

P_gray_t = P_gray_t >= 0.5;

P_gray_h = dither(P_gray);

% figure(5)
% imshow(P_gray_t);
% 
% figure(6)
% imshow(P_gray_h);

SNR_t = mysnr(P_gray, P_gray - P_gray_t);
SNR_h = mysnr(P_gray, P_gray - P_gray_h);


% threshold suger lite, halftoning är lite bättre, liknar bilden mer. 
%Terrible snr what is this fråga om snr varf är h sämre??????

%% 2.2


%imLab = rgb2lab(P_color);

% r_half = 




