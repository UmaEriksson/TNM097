% % main
clear;
clc;

% Palette
p = zeros(7,13,3);
[pRow, pCol,pDim] = size(p);

colorStep = 1;
nrOfHue = pRow;
hueStep = 1/nrOfHue;
currentHue = 1;
paleHue = 1 /(pRow/2);
paleStep = 0;

%skapa olika nyanser fÃ¶r fÃ¤rgerna ovan
for i = 1:pRow
   
    % Röd
    p(i,1,1) = 1*colorStep;
    
    % Orange
    p(i,2,1) = 1*colorStep;
    p(i,2,2) = 1*colorStep * 0.5;
    
    % Gul
    p(i,3,1) = 1*colorStep;
    p(i,3,2) = 1*colorStep;

    % Lime
    p(i,4,1) = 1*colorStep * 0.5;
    p(i,4,2) = 1*colorStep;

    % Grön
    p(i,5,2) = 1*colorStep;

    % Kall grön?
    p(i,6,2) = 1*colorStep;
    p(i,6,3) = 1*colorStep * 0.5;
    
    % Turkos
    p(i,7,2) = 1*colorStep;
    p(i,7,3) = 1*colorStep;
    
    % Ljus blå
    p(i,8,2) = 1*colorStep * 0.5;
    p(i,8,3) = 1*colorStep;

    % Blå
    p(i,9,3) = 1*colorStep;

    % lila
    p(i,10,1) = 1*colorStep * 0.5;
    p(i,10,3) = 1*colorStep;
    
    % Rosa
    p(i,11,1) = 1*colorStep;    
    p(i,11,3) = 1*colorStep;

    % Magenta
    p(i,12,1) = 1*colorStep;    
    p(i,12,3) = 1*colorStep * 0.5;

    % Grå/svart?
    p(i,13,1) = 1*colorStep;    
    p(i,13,2) = 1*colorStep;    
    p(i,13,3) = 1*colorStep;

        if mod(i,pRow/nrOfHue) == 0 
            colorStep = colorStep - hueStep;
        end
end


pallette = p;
% figure(1)
% imshow(pallette);

colorStep = 0;
paleStep = 1/pRow;

% ljusa toner
for i = 1:pRow
   
    % Röd
    p(i,1,1) = 1;
    p(i,1,2) = 1*colorStep;
    p(i,1,3) = 1*colorStep;
    
    % Orange
    p(i,2,1) = 1;
    p(i,2,2) = 1*0.5 + ((1-0.5)/pRow)*i - (1/pRow);
    p(i,2,3) = (1/pRow)*i - (1/pRow);
    
    % Gul
    p(i,3,1) = 1;
    p(i,3,2) = 1;
    p(i,3,3) = (1/pRow)*i - (1/pRow);

    % Lime
    p(i,4,1) = 1 * 0.5 + ((1-0.5)/pRow)*i - (1/pRow);
    p(i,4,2) = 1;
    p(i,4,3) = (1/pRow)*i - (1/pRow);

    % Grön
    p(i,5,1) = (1/pRow)*i - (1/pRow);
    p(i,5,2) = 1;
    p(i,5,3) = (1/pRow)*i - (1/pRow);

    % Kall grön?
    p(i,6,1) = (1/pRow)*i - (1/pRow);
    p(i,6,2) = 1;
    p(i,6,3) = 1 * 0.5 + ((1-0.5)/pRow)*i - (1/pRow);
     
    % Turkos
    p(i,7,1) = (1/pRow)*i - (1/pRow);
    p(i,7,2) = 1;
    p(i,7,3) = 1;
    
    % Ljus blå
    p(i,8,1) = (1/pRow)*i - (1/pRow);
    p(i,8,2) = 1 * 0.5 + ((1-0.5)/pRow)*i - (1/pRow);
    p(i,8,3) = 1;

    % Blå
    p(i,9,1) = (1/pRow)*i - (1/pRow);
    p(i,9,2) = (1/pRow)*i - (1/pRow);
    p(i,9,3) = 1;

    % lila
    p(i,10,1) = 1 * 0.5 + ((1-0.5)/pRow)*i - (1/pRow);
    p(i,10,2) = (1/pRow)*i - (1/pRow);
    p(i,10,3) = 1;
    
    % Rosa
    p(i,11,1) = 1; 
    p(i,11,2) = (1/pRow)*i - (1/pRow);
    p(i,11,3) = 1;

    % Magenta
    p(i,12,1) = 1; 
    p(i,12,2) = (1/pRow)*i - (1/pRow);
    p(i,12,3) = 1 * 0.5 + ((1-0.5)/pRow)*i - (1/pRow);

    % Grå/svart?
    p(i,13,1) = (1/pRow)*i - (1/pRow);    
    p(i,13,2) = (1/pRow)*i - (1/pRow);    
    p(i,13,3) = (1/pRow)*i - (1/pRow);

        if mod(i,pRow/nrOfHue) == 0 
            colorStep = colorStep + hueStep;
        end
end

pallette = cat(1, p, pallette);

figure(2)
imshow(pallette);

save('palette.mat','pallette');

%%

clc;
clear;

load('palette.mat');

colorMap = im2double(imread('colorMap.jpeg')); % antal nysanser: 168*300 st 
bigPalette = imresize( colorMap , [10,10]); % stor palette
smolPalette = imresize( bigPalette , 0.7); % liten palette

subPallete = imresize( colorMap , 0.075);

% figure(1)
% imshow(subPallete)
% 
% % figure(3)
% % imshow(colorMap)
% figure(4)
%  imshow(bigPalette)
%figure(5)
% imshow(smolPalette)

% hur stor bli skillnaden mellan färger, efter subjektivt anvgörande?


x = abs(diff(rgb2lab(subPallete)));
colorDiff = min(min(min (x))) % prcis när det börjar bli svårt att urskilja en nyans från en annan: diff = 8.6948

x = abs(diff(rgb2lab(smolPalette)));
colorDiff = min(min(min(x))) 


thePalette = bigPalette;

% Purl
defaultPurl = im2double(imread('defaultPurl.png'));
defaultPurl = imresize( defaultPurl , 0.01 );
defaultPurl(:,:,1) = defaultPurl(:,:,1) >= 0.5;
defaultPurl(:,:,2) = defaultPurl(:,:,2) >= 0.5;
defaultPurl(:,:,3) = defaultPurl(:,:,3) >= 0.5;
[purl_row, purl_col, purl_dim] = size(defaultPurl);

% % Original bilder 
org_gaiaTemp = imread('gaiaTemp.jpg');
 org_soldat = imread('OrangeSoldat.png');
% org_peppers = imread('peppers_color.tif');
org_text_mette = imread('text_mette.jpg');
org_original = imread('Original.jpg');
% org_temp = imread('temp.png');

% porträtt
org_me = imread('temp.png');
% figure(6)
% imshow(org_me)

% lanskap
org_landskap = imread('landskap.png');
% figure(7)
% imshow(org_landskap)

% ljus bild 
org_light = imread('lightPic.png');
% figure(8)
% imshow(org_light)

% mörk bild
org_vastervik = imread('Vastervik.jpg');
% figure(9)
% imshow(org_vastervik)

% BYT BILD HÄR!!!!!!!
org = org_me;
org = im2double(org);
[org_row, org_col, org_dim] = size(org);

org_f = (0.2*org_row)/org_row;

org = imresize( org , [org_row*org_f org_col*org_f], 'bicubic');
figure(10)
imshow(org)
title('Original');

% hur mycket vill vi nyanser vill vi plocka ut ur den indexerade bilden?
% antar att vi vill att den minsta skillnaden mellan två färger får minst
% vara colorDiff

%C = unique(org(:,:, 1));





temp = org;
temp(:,:,1) = temp(:,:,1) + temp(:,:,2) + temp(:,:,2);
temp2 = unique(temp(:,:,1));
[nrOfIndColors temp] = size(temp2);

nrOfIndColors



% 
% % [pal_row, pal_row, pal_dim] = size(bigPalette);
% [X, map] = rgb2ind(org, nrOfIndColors,'nodither');
% org_ind = ind2rgb(X, map);
% currentDiff = abs(min(min(diff(rgb2lab(org_ind)))))
% % [pal_row, pal_row, pal_dim] = size(bigPalette);
% 
% nrOfIndColors
% 
% while currentDiff < colorDiff
% 
%     [X, map] = rgb2ind(org, nrOfIndColors,'nodither');
%     org_ind = ind2rgb(X, map);
% 
%    % antal = size(unique(org_ind));
% 
%     x = abs(diff(rgb2lab(org_ind)));
%     currentDiff = min(min(min(x)))
% 
%     nrOfIndColors = nrOfIndColors-1;
% 
% end
% 
 

nrOfIndColors = round(nrOfIndColors * 0.001)
%%

%[X, map] = rgb2ind(org, nrOfIndColors,'nodither');

[X, map] = rgb2ind(org, 32,'nodither');
org_ind = ind2rgb(X, map);

% imwrite(org_ind,'0_ind.png');

%org_ind = imresize( org_ind , [org_row*org_f org_col*org_f]);
figure(5)
imshow(org_ind)
title('Indexerad');

sizeFactor = (1/purl_row) ;
% sizeFactor_col = (1/purl_col) 
% sizeFactor = [sizeFactor_row sizeFactor_col]

% create the reproduction

%org_nr = size(unique(org))

%ind_nr = size(unique(org_ind))



%%

delete(gcp('nocreate')); 
parpool('local',2);

imwrite(org,'00_org.png');
imwrite(org_ind,'00_ind.png');

tic
rep_small = createReproduction(org, defaultPurl, smolPalette, sizeFactor);
toc 

imwrite(rep_small,'00_rep_small_white.png');
%%
delete(gcp('nocreate')); 
parpool('local',2);

tic
rep_big = createReproduction(org, defaultPurl, bigPalette, sizeFactor);
toc

imwrite(rep_big,'00_rep_big_white.png');

%%
tic
rep_ind = createReproduction(org_ind, defaultPurl, bigPalette, sizeFactor);
toc

imwrite(rep_ind,'00_rep_ind_white.png');



figure(555)
%montage({org_soldat,org, org_ind, rep_small, rep_big, rep_ind})
%%
figure(101)
imshow(rep_small)
title('Reproduktion med LITEN palett');
figure(202)
imshow(rep_big)
title('Reproduktion med STOR palett');
figure(303)
imshow(rep_ind)
title('Reproduktion med OPTIMERAD palett/ originalbild');

%%
clc;
[rep_row, rep_col, rep_dim] = size(rep_small);
f = org_row/rep_row;

org = im2double(org); % obs! gör detta annars jämför vi inte double mot double!
[met_small_mean, met_small_max] = getDeltaE(org,rep_small);
[met_big_mean, met_big_max] = getDeltaE(org,rep_big);
[met_ind_mean, met_ind_max] = getDeltaE(org,rep_ind);

Data = [  met_small_mean      met_small_max     
          met_big_mean        met_big_max       
          met_ind_mean        met_ind_max       
          ];
Data2 = {'rep_smallP'; 'rep_bigP'; 'rep_bigP_ind'};
%VarNames = {'Reproduction', 'deltaE_mean', 'deltaE_max', 'deltaE_min'};
VarNames = {'Reproduction', 'deltaE_mean', 'deltaE_max'};
T = table(Data2(:,1),Data(:,1),Data(:,2), 'VariableNames',VarNames)

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