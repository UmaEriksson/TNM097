

%% skapa pallette
% size of bead matrix
n = 30 
% bead matrix 
beads = zeros(n,3,3);

colorStep = 1;
nrOfHue = 10;
hueStep = 1/nrOfHue;
currentHue = 1;

% skapa pallette
p = zeros(30,30,3);

% skapa färger 
p(:,1:10,1) = 1;
p(:,11:20,2) = 1;
p(:,21:30,3) = 1;

%skapa olika nyanser för färgerna ovan
for i = 1:size(p)
    p(i,1:10,1) = 1*colorStep;
    p(i,11:20,2) = 1*colorStep;
    p(i,21:30,3) = 1*colorStep;

    if mod(i,size(p)/nrOfHue) == 0 
        colorStep = colorStep - hueStep;
    end

end

% figure(1)
% imshow(p);

%% skapa temp reproduktions bild med defult pärlor

defaultPurl = im2double(imread('defaultPurl.png'));
defaultPurl = imresize( defaultPurl , 0.05 );
defaultPurl(:,:,1) = defaultPurl(:,:,1) >= 0.5;
defaultPurl(:,:,2) = defaultPurl(:,:,2) >= 0.5;
defaultPurl(:,:,3) = defaultPurl(:,:,3) >= 0.5;

colorStep = 1;
nrOfHue = 10;
hueStep = 1/nrOfHue;
currentHue = 1;

p = zeros(30,30,3);
% skapa färger 
p(:,1:10,1) = 1;
p(:,11:20,2) = 1;
p(:,21:30,3) = 1;

%skapa olika nyanser för färgerna ovan
for i = 1:size(p)
    % R�d
    p(i,1:5,1) = 1*colorStep;
    
    % gul?
    p(i,6:10,1) = 1*colorStep;
    p(i,6:10,2) = 1*colorStep;

    % gr�n
    p(i,11:15,2) = 1*colorStep;
    
    % turkos
    p(i,15:20,2) = 1*colorStep;
    p(i,15:20,3) = 1*colorStep;
    
    % bl�
    p(i,21:25,3) = 1*colorStep;
    
    % rosa
    p(i,26:30,1) = 1*colorStep;
    p(i,26:30,3) = 1*colorStep;


    if mod(i,size(p)/nrOfHue) == 0 
        colorStep = colorStep - hueStep;
    end

end


 figure(2)
imshow(p);

% testar att ändra färgern till rött
% [row column dim] = size(defaultPurl);
% for i = 1:row
%     for j= 1:column
%         if defaultPurl(i,j,1) == 0
%             defaultPurl(i,j,1) = 0.5;
%             defaultPurl(i,j,2) = 0.5;
%             defaultPurl(i,j,3) = 0;
%         end 
%     end 
% end

% figure(3)
% imshow(defaultPurl);
% 
% test = cat(2, defaultPurl,defaultPurl);
% 
% figure(4)
% imshow(test);
% 
% test2 = cat(2, test, test);
% 
% figure(5)
% imshow(test2);
% 
% test3 = cat(1, test2, test2);
% test3 = cat(1, test3, test3);
% figure(6)
% imshow(test3);



% testar att skapa en ny pärla 
newPurl = setColor(defaultPurl, 0, 1, 1);
% figure(7)
% imshow(newPurl)



% läsa in lite orignal bilder
org_pretty = im2double(imread('org_pretty.png'));
org_duo = im2double(imread('org_duo.png'));
org_gray = imread('org_gray.png');
org_grund = imread('org_grund.png');
org_invert = imread('org_invert.png');
original = imread('Original.jpg');


% figure(8)
% imshow(org_duo)
% figure(9)
% imshow(org_gray)
% figure(10)
% imshow(org_grund)
% figure(11)
% imshow(org_invert)
% figure(12)
% imshow(original)

sample_pretty = imresize( org_pretty , [2,2]);
%figure(13)
%imshow(sample_pretty)

%sample_pretty(1,1,1)
%first = sample_pretty(1,2,:)

% rad 1
newPurl1 = setColor(defaultPurl, sample_pretty(1,1,1),sample_pretty(1,1,2),sample_pretty(1,1,3));
newPurl2 = setColor(defaultPurl, sample_pretty(1,2,1),sample_pretty(1,2,2),sample_pretty(1,2,3));
imRow1 = cat(2, newPurl1, newPurl2);

% rad 2
newPurl3 = setColor(defaultPurl, sample_pretty(2,1,1),sample_pretty(2,1,2),sample_pretty(2,1,3));
newPurl4 = setColor(defaultPurl, sample_pretty(2,2,1),sample_pretty(2,2,2),sample_pretty(2,2,3));
imRow2 = cat(2, newPurl3, newPurl4);

rep = cat(1, imRow1, imRow2);

%figure(14)
%imshow(rep)

sample_pretty_test2 = imresize( org_pretty , 0.01);
% [row, col, dim] = size(sample_pretty_test2);
% repTest = [];
% for j = 1:row
%     
%     newRow = [];
%     
%     for i = 1:col
%     newPurl = setColor(defaultPurl, sample_pretty_test2(j,i,1),sample_pretty_test2(j,i,2),sample_pretty_test2(j,i,3));
%     newRow = cat(2, newRow, newPurl);
%     end
% 
%    repTest = cat(1, repTest, newRow);
% 
% end 
% figure(15)
% imshow(repTest)


%rep_pretty = createReproduction(org_pretty, defaultPurl);
%figure(15)
%imshow(rep_pretty)
tempColor = zeros(1,3);
tempColor = setColor(tempColor, 1, 0, 0);
%figure(30)
%imshow(tempColor)
% palletteColor = findColor(p, tempColor)



rep_pretty = createReproduction(original, defaultPurl, p)

figure(60)
imshow(original)
figure(70)
imshow(rep_pretty)

% hur stor ska reproduktionen vara?
% Säg att reproduktionen inte får vara dubbelt så stor än originalet?
% eller nej, pärlorna ska ha samma storlek?

%%









% %counter
% m = 1;
% 
% %hur många steg
% s = 1/n;
% 
% for n_r = 0:s:1
%     
% beads(m, :, 1) = n_r;
% 
% m = m +1;
%  
% end
% 
% m = 1;
% for n_g = 0:s:1
%     
% beads(m, :, 2) = n_g;
% 
% m = m +1;
%  
% end
% 
% m = 1
% for n_b = 0:s:1
%     
% beads(m, :, 3) = n_b;
% 
% m = m +1;
%  
% end
% 
% figure(1)
% imshow(beads)




% skapa en pärla
N=100;
D=ones(N,N);
i0=10;
j0=20;
R=6;
% filter indise circle
[x,y]=meshgrid(1:N);
D((x-i0).^2+(y-j0).^2<R^2)=0;
%figure(2)
%imshow(D)
