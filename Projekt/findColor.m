function [palletteColor] = findColor(orgColor)
 % figure(21)
% imshow(orgColor);
orgColor_lab = rgb2lab(orgColor);
% figure(22)
% imshow(orgColor_lab);

pallette = rand(5,5,3); 
pallette_lab = pallette;
pallette_lab = rgb2lab(pallette_lab);
%pallette_lab(:,:,1) = rgb2lab(pallette(:,:,1));
%pallette_lab(:,:,2) = rgb2lab(pallette(:,:,2));
%pallette_lab(:,:,3) = rgb2lab(pallette(:,:,3));

 %figure(23)
 %imshow(pallette_lab);

 palletteColor = 0;
 
end