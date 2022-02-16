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
% Terrible snr what is this fråga om snr varf är h sämre??????
% snr tar ingen hänsyn till bilden i sig. Ser bilden bara som en vektor.

%% 2.2

figure(6)
imshow(P_color);

%imLab = rgb2lab(P_color);

% Half toning
r_half = im2double(P_color(:,:,1)>= 0.5);
g_half = im2double(P_color(:,:,2)>= 0.5);
b_half = im2double(P_color(:,:,3)>= 0.5);

% Halvtonad bild i RGB
RGB_half = (cat(3, r_half, g_half, b_half));
figure(7)
imshow(RGB_half);

% Halvtonad bild i CIELab
[L_Half, a_Half, b_Half]=xyz2lab(RGB_half(:,:,1),RGB_half(:,:,2),RGB_half(:,:,3));

% error diffusion 
% % OBS varhe kanal som innan!
r_error = im2double(dither(P_color(:,:,1)));
g_error = im2double(dither(P_color(:,:,2)));
b_error = im2double(dither(P_color(:,:,3))); % nu har vi error diffusion för en rgb bild

% error diffusion i RGB
RGB_Error = (cat(3, r_error, g_error, b_error));
figure(8)
imshow(RGB_Error);

% Error diffusion bild i CIElab 
[L_Error, a_Error, b_Error]=xyz2lab(r_error, g_error, b_error);

% alla bilder til lab för jämförelse!

% Originalet i CIELab 
[L_org, a_org, b_org]=xyz2lab(P_color(:,:,1), P_color(:,:,2), P_color(:,:,3));

% beräkna deltaE Tänk på att nu är det en nu en blid och icke vektor!
% ......

% Jämför originalet med half och error
[Mean_Half_matrix, Max_Half_matrix] = EuclidDis(L_Half, a_Half, b_Half, L_org, a_org, b_org);
Mean_Half = mean(Mean_Half_matrix);
Max_Half = max(Max_Half_matrix); % ish 68

[Mean_Error_matrix, Max_Error_matrix] = EuclidDis(L_Error, a_Error, b_Error, L_org, a_org, b_org);
Mean_Error = mean(Mean_Error_matrix);
Max_Error = max(Max_Error_matrix); % ish 41

% Vi tycker att error diffusion är den bättre reproduktionen. Men om vi går
% på det euklidiska avståndet mellan bilderna så är trösklingen bättre.
% hophop

%% 3
% original
P_gray;

R_t = snr_filter(P_gray, (P_gray-P_gray_t)); % tröskel

R_e = snr_filter(P_gray, (P_gray-P_gray_h)); % error

R_t;
R_e;

f=MFTsp(15,0.0847,500);


% Tillskillnad från 2.1.2 så får vi nu mer överrensstämmande snr-värden,
% (error är brättre än tröskel), med vad vi själva tycker. Det är ju
% såklart för att man i den här uppgiften tar hänsyn till människoögat. 

% nu applicerat vi gögats filter på reproduktionerna innan vi tar ett
% kvalitetsmått

RGB_half_HVS = applicate_HVS(RGB_half);
RGB_error_HVS = applicate_HVS(RGB_Error);

RGB_half_HVS_Lab = rgb2lab(RGB_half_HVS);
RGB_error_HVS_Lab = rgb2lab(RGB_error_HVS);
P_color_Lab = rgb2lab(P_color);

% Jämför trösklade bilden
[Mean_Half_matrix_HVS, Max_Half_matrix_HVS] = EuclidDis(RGB_half_HVS_Lab(:,:,1), RGB_half_HVS_Lab(:,:,2), RGB_half_HVS_Lab(:,:,3), P_color_Lab(:,:,1), P_color_Lab(:,:,2), P_color_Lab(:,:,3));
Mean_Half_HVS = mean(Mean_Half_matrix_HVS)
Max_Half_HVS = max(Max_Half_matrix_HVS)


% Jämför error diffusion bilden
[Mean_Error_matrix_HVS, Max_Error_matrix_HVS] = EuclidDis(RGB_error_HVS_Lab(:,:,1), RGB_error_HVS_Lab(:,:,2), RGB_error_HVS_Lab(:,:,3), P_color_Lab(:,:,1), P_color_Lab(:,:,2), P_color_Lab(:,:,3));
Mean_Error_HVS = mean(Mean_Error_matrix_HVS)
Max_Error_HVS = max(Max_Error_matrix_HVS)


%% 4.1


P_near = imresize(imresize(P_color,0.25,'nearest'),4,'nearest'); % sämsta reproduktion
P_bil = imresize(imresize(P_color,0.25,'bilinear'),4,'bilinear');
P_bic = imresize(imresize(P_color,0.25,'bicubic'),4,'bicubic'); % bästa reproduktion

figure(10)
imshow(P_color);
figure(11)
imshow(P_near);
figure(12)
imshow(P_bil);
figure(13)
imshow(P_bic);

P_color_xyz = rgb2xyz(P_color);
P_near_xyz = rgb2xyz(P_near);
P_bil_xyz = rgb2xyz(P_bil);
P_bic_xyz = rgb2xyz(P_bic);

% Ljuskällan
D65 = [95.05, 100, 108.9];

% räknar ut ppi
% min stora skärm är 1920 x 1080?
% 23,5-tum?
ppi = 120 * (337^0.5);
d = 70 / 2.54;

sampPerDeg = ppi * d *(tan(pi/180));

%‘xyz’
%result = visualAngle(numpixels, viewdist, dpi, va)

result_near = scielab(sampPerDeg, P_color_xyz, P_near_xyz, D65, 'xyz');
result_bil = scielab(sampPerDeg, P_color_xyz, P_bil_xyz, D65, 'xyz');
result_bic = scielab(sampPerDeg, P_color_xyz, P_bic_xyz, D65, 'xyz');

mean_near = mean(mean(result_near))
mean_bil = mean(mean(result_bil))
mean_bic = mean(mean(result_bic))

% Vi tycker inte att dessa värden stämmer överrens med vår optiska
% uppfattning.
% Enligt full refecene så är ordningen 1. near, 2. bilinear, 3. bicubic

%% 4.2 

load colorhalftones.mat;

figure(14)
imshow(c1);
figure(15)
imshow(c2);
figure(16)
imshow(c3);
figure(17)
imshow(c4);
figure(18)
imshow(c5);


c1_xyz = rgb2xyz(c1);
c2_xyz = rgb2xyz(c2);


result_c1 = scielab(sampPerDeg, c1_xyz);
result_c2 = scielab(sampPerDeg, c2_xyz);


c1_std2 = std2(result_c1(:,:,1) + result_c1(:,:,2) + result_c1(:,:,3))
c2_std2 = std2(result_c2(:,:,1) + result_c2(:,:,2) + result_c2(:,:,3))






















