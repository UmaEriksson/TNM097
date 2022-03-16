%% Main

clc;
clear;

% Generate palttes 

load('palette.mat'); % beräknad palett

colorMap = im2double(imread('colorMap.jpeg')); % antal nysanser: 168*300 st 
bigPalette = imresize( colorMap , [10,10]); % stor palette
smolPalette = imresize( bigPalette , 0.7); % liten palette

subPallete = imresize( colorMap , 0.075);


%% Pärlan

% Läser in pärlbilden
defaultPurl = im2double(imread('defaultPurl.png'));
defaultPurl = imresize( defaultPurl , 0.01 );
defaultPurl(:,:,1) = defaultPurl(:,:,1) >= 0.5;
defaultPurl(:,:,2) = defaultPurl(:,:,2) >= 0.5;
defaultPurl(:,:,3) = defaultPurl(:,:,3) >= 0.5;
[purl_row, purl_col, purl_dim] = size(defaultPurl)

% pärlans "vithalt"
test = defaultPurl(:,:,1);
vit = sum(sum(test == 1));
totPixel = purl_row*purl_col;
vitHalt = vit / totPixel


%% Läser in originalen

% Soldat
org_soldat = imread('OrangeSoldat.png');
org_text_mette = imread('text_mette.jpg');

% Porträtt
org_me = imread('temp.png');

% Lanskap
org_landskap = imread('landskap.png');

% Ljus bild 
org_light = imread('lightPic.png');

% Mörk bild
org_vastervik = imread('Vastervik.jpg');


%% Aktuella originalet

% BYT BILD HÄR!!!!!!!
org = org_vastervik; 
figure(1)
imshow(org)
title('Original');

%imwrite(org,'---.png');

% Segmentering av originalet
sizeFactor = 0.05 * (1/purl_row)
[org_row, org_col, org_dim] = size(org)
org = imresize( org , [org_row*sizeFactor org_col*sizeFactor], 'bicubic');

% org_ind = imresize( org_ind , [org_row*sizeFactor org_col*sizeFactor], 'bicubic');

% Indexerad origonal efter de 32 mest dominanta 
[X, map] = rgb2ind(org, 32,'nodither');
org_ind = ind2rgb(X, map); 
figure(2)
imshow(org_ind)
title('Indexerad');

%imwrite(org_ind,'---.png');


%% Reproduktion med LITEN palett

tic
delete(gcp('nocreate')); % ska göra processen lite snabbare?
parpool('local',2);
toc 

tic
rep_small = createReproduction(org, defaultPurl, smolPalette, sizeFactor);
runTime_small = toc 

figure(101)
imshow(rep_small)
title('Reproduktion med LITEN palett');

% imwrite(rep_small,'---.png');


%% Reproduktion med STOR palett

tic
delete(gcp('nocreate')); 
parpool('local',2);
toc

tic
rep_big = createReproduction(org, defaultPurl, bigPalette, sizeFactor);
runTime_big = toc 

figure(202)
imshow(rep_big)
title('Reproduktion med STOR palett');

% imwrite(rep_big,'---.png');


%% Reproduktion av optimerad original med STOR Palett

tic
delete(gcp('nocreate')); 
parpool('local',2);
toc

tic
rep_ind = createReproduction(org_ind, defaultPurl, bigPalette, sizeFactor);
runTime_ind = toc 

figure(303)
imshow(rep_ind)
title('Reproduktion av optimerad original med STOR Palett');

% imwrite(rep_ind,'---.png');


%%
figure(555)
montage({org, org_ind, rep_small, rep_big, rep_ind})


%% Kvalitetsmått - deltaE

clc;

% Soldat
% org = im2double(imread('OrangeSoldat.png'));
% rep_small = im2double(imread('/MATLAB Drive/Rep/Project/00_soldat/00_rep_small_white.png'));
% rep_big = im2double(imread('/MATLAB Drive/Rep/Project/00_soldat/00_rep_big.png'));
% rep_ind = im2double(imread('/MATLAB Drive/Rep/Project/00_soldat/00_rep_ind.png'));

% Me
org = im2double(imread('temp.png'));
rep_small = im2double(imread('/MATLAB Drive/Rep/Project/00_me/00_rep_me_small_white.png'));
rep_big = im2double(imread('/MATLAB Drive/Rep/Project/00_me/00_rep_me_big_white.png'));
rep_ind = im2double(imread('/MATLAB Drive/Rep/Project/00_me/00_rep_me_ind_white.png'));

% Landskap
% org = im2double(imread('landskap.png'));
% rep_small = im2double(imread('/MATLAB Drive/Rep/Project/00_land/00_rep_land_small_white.png'));
% rep_big = im2double(imread('/MATLAB Drive/Rep/Project/00_land/00_rep_land_big_white.png'));
% rep_ind = im2double(imread('/MATLAB Drive/Rep/Project/00_land/00_rep_land_ind_white.png'));

figure(666)
montage({org, rep_small, rep_big, rep_ind});
truesize

% skala om originalet till til reprodutionens storlek
[rep_row, rep_col, rep_dim] = size(rep_small);
org = imresize( org , [rep_row rep_col], 'bicubic');

%%
% undersökte vithalten i reproduktionsbilden
whithe_mask = rep_big(:,:,1) == 1 & rep_big(:,:,2) == 1 & rep_big(:,:,3) == 1 ;
vit = sum(sum(whithe_mask));
figure(680)
imshow(whithe_mask)
totPixel = rep_row * rep_col ;
vitHalt = vit / totPixel; % 16%


% Ändra vitan till en annan färg?
% originalets medelfärg
org_meanColor = imresize(org, [1 1]);
figure(681)
imshow(org_meanColor)

color_mask = whithe_mask .* org_meanColor;
figure(682)
imshow(color_mask)

mask_rep = rep_big - whithe_mask + color_mask;
figure(683)
%imshow(mask_rep(1:20, 1:20,:))
figure(684)
montage({rep_big(1:10, 1:10, :), mask_rep(1:10, 1:10, :)});
montage({rep_big, org, mask_rep});
truesize

[mean_colorMask, max_colorMask] = getDeltaE(org,mask_rep)


%%

[met_small_mean, met_small_max] = getDeltaE(org,rep_small);
[met_big_mean, met_big_max] = getDeltaE(org,rep_big);
[met_ind_mean, met_ind_max] = getDeltaE(org,rep_ind);

Data = [  met_small_mean      met_small_max      
          met_big_mean        met_big_max       
          met_ind_mean        met_ind_max       
          ];
Data2 = {'rep_smallP'; 'rep_bigP'; 'rep_bigP_ind'};
VarNames = {'Reproduction: Landskap 3%', 'deltaE_mean', 'deltaE_max'};
T = table(Data2(:,1),Data(:,1),Data(:,2), 'VariableNames',VarNames)

%% Kvalitetsmått - S-CIELab

% Low-level based metrics (takes into account the visibility of the distortions using low-level models of the HVS), such as S-CIELab

[r, c, d] = size(org);
org_xyz = rgb2xyz(im2double(org));

rep_small_xyz = rgb2xyz(imresize( rep_small , [r c], 'bicubic'));
rep_big_xyz = rgb2xyz(imresize( rep_big , [r c], 'bicubic'));
rep_ind_xyz = rgb2xyz(imresize( rep_ind , [r c], 'bicubic'));

% Ljuskällan
D65 = [95.05, 100, 108.9];

% räknar ut ppi
% min stora skärm är 1920 x 1080?
% 23,5-tum?
% för min stora skärm: ppi:92.48 ???
ppi = 120;
%ppi = 92.48;
d = 100/ 2.54;

sampPerDeg = ppi * d *(tan(pi/180));
% hur många bildpunkter man ser per synvinkel typ

%‘xyz’
%result = visualAngle(numpixels, viewdist, dpi, va)

result_small = scielab(sampPerDeg, org_xyz, rep_small_xyz, D65, 'xyz');
result_big = scielab(sampPerDeg, org_xyz, rep_big_xyz, D65, 'xyz');
result_ind = scielab(sampPerDeg, org_xyz, rep_ind_xyz, D65, 'xyz');

mean_small = mean(mean(result_small));
mean_big = mean(mean(result_big));
mean_ind = mean(mean(result_ind));

Data3 = [  mean_small           
          mean_big               
          mean_ind               
          ];
Data4 = {'rep_smallP'; 'rep_bigP'; 'rep_bigP_ind'};
%VarNames = {'Reproduction', 'deltaE_mean', 'deltaE_max', 'deltaE_min'};
VarNames = {'Reproduction', 'S-CIELab'};
T = table(Data4(:,1),Data3(:,1), 'VariableNames',VarNames)

%%

imwrite(org,'0_org.png');
imwrite(org_ind,'0_ind.png');
imwrite(rep_small,'0_rep_small_white.png');
imwrite(rep_big,'0_rep_big.png');
imwrite(rep_ind,'0_rep_ind.png');


%read image 
%tt= imshow(image) ;
%save your image other  location with any name save desktop or any folder also
% baseFileName = sprintf('img #%d.png', org);
% fullFileName = fullfile('/MATLAB Drive/Rep/Project/pictures/soldat', baseFileName);
% imwrite(org, fullFileName);


%%

%rep = imresize(rep, [550 550]);

% betyg 3: 
% - euclidian jämföra 
% plaette anpassad för bild
% https://ch.mathworks.com/help/images/reduce-the-number-of-colors-in-an-image.html
% betyg 4: spacial


%/// Kollar kvalitetsmåttet på reproduktionen ///////////////////////////////////////////////////////////////////////////////////////////

% testar med deltaE tillsammans med HVS filtret. (alltså ett filter som tar hänsyn till ögats förguppfattning)

% ögats filter
f=MFTsp(15,0.0847,500); % fråga försäkerhets skull att vi får använda detta.


% Applicera ögats filter på reproduktionen innan vi tar ett
% kvalitetsmått

% reproduktionen... 
RGB_rep_HVS = applicate_HVS(rep);
RGB_rep_HVS_Lab = rgb2lab(RGB_rep_HVS); % enhets oberoende färgrymd -> till CIELab

% originalet...
RGB_org_HVS = applicate_HVS(org);
RGB_org_HVS_Lab = rgb2lab(RGB_org_HVS); % enhets oberoende färgrymd -> till CIELab


% gör reproduktionen lika stor som originalet
f = org_row/rep_row

RGB_rep_HVS_Lab = imresize( RGB_rep_HVS_Lab , f, 'bicubic');

size(RGB_rep_HVS_Lab)
size(RGB_org_HVS_Lab)

% Jämför originalet och reproduktionen
% reproduktionens kalanaler först, sedan oriiginalet
%[Mean_rep_matrix_HVS, Max_rep_matrix_HVS] = EuclidDis(RGB_rep_HVS_Lab(:,:,1), RGB_rep