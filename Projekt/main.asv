%% main
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

pA = im2double(imread('colorMap.jpeg')); % antal nysanser: 168*300 st 
pB = imresize( pA , 0.05 );
% 
% figure(3)
% imshow(pA)
% figure(4)
% imshow(pB)

thePalette = pallette;

% Purl
defaultPurl = im2double(imread('defaultPurl.png'));
defaultPurl = imresize( defaultPurl , 0.01 );
defaultPurl(:,:,1) = defaultPurl(:,:,1) >= 0.5;
defaultPurl(:,:,2) = defaultPurl(:,:,2) >= 0.5;
defaultPurl(:,:,3) = defaultPurl(:,:,3) >= 0.5;
[purl_row, purl_col, purl_dim] = size(defaultPurl);

% Original bilder 
org_grund = imread('org_grund.png');
org_soldat = imread('OrangeSoldat.png');
org_peppers = imread('peppers_color.tif');
org_text_mette = imread('text_mette.jpg');
org_temp = imread('temp.png');




org = org_grund;

% ba gör bilden lite mer hanterlig
org = imresize( org , [200 200]);


[org_row, org_col, org_dim] = size(org);


%sizeFactor = 1- ((purl_row*purl_col)/(org_row*org_col))

sizeFactor = (1/purl_row) ;


rep = createReproduction(org, defaultPurl, thePalette, sizeFactor);

figure(101)
imshow(org)
figure(202)
imshow(rep)

[rep_row, rep_col, rep_dim] = size(rep);



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
f = org_row/rep_row;

RGB_rep_HVS_Lab = imresize( RGB_rep_HVS_Lab , f, 'bicubic');


% Jämför originalet och reproduktionen
% reproduktionens kalanaler först, sedan oriiginalet
[Mean_rep_matrix_HVS, Max_rep_matrix_HVS] = EuclidDis(RGB_rep_HVS_Lab(:,:,1), RGB_rep_HVS_Lab(:,:,2), RGB_rep_HVS_Lab(:,:,3), RGB_org_HVS_Lab(:,:,1), RGB_org_HVS_Lab(:,:,2), RGB_org_HVS_Lab(:,:,3));
Mean_rep_HVS = mean(Mean_rep_matrix_HVS)
Max_rep_HVS = max(Mean_rep_matrix_HVS)



%kvalitetsmatt = Max_rep_HVS




