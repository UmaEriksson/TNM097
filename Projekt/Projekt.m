

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

figure(1)
imshow(p);

%% skapa temp reproduktions bild med defult pärlor

defaultPurl = im2double(imread('defaultPurl.png'));
defaultPurl = imresize( defaultPurl , 0.05 );
defaultPurl(:,:,1) = defaultPurl(:,:,1) >= 0.5;
defaultPurl(:,:,2) = defaultPurl(:,:,2) >= 0.5;
defaultPurl(:,:,3) = defaultPurl(:,:,3) >= 0.5;

figure(2)
imshow(defaultPurl);

% testar att ändra färgern till rött
[row column dim] = size(defaultPurl);
for i = 1:row
    for j= 1:column
        if defaultPurl(i,j,1) == 0
            defaultPurl(i,j,1) = 0.5;
            defaultPurl(i,j,2) = 0.5;
            defaultPurl(i,j,3) = 0;
        end 
    end 
end

figure(3)
imshow(defaultPurl);

test = cat(2, defaultPurl,defaultPurl);

figure(4)
imshow(test);

test2 = cat(2, test, test);

figure(5)
imshow(test2);

test3 = cat(1, test2, test2);
test3 = cat(1, test3, test3);
figure(6)
imshow(test3);






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

% R = rand(100,100,3);
% 
% figure(1)
% imshow(R);


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
