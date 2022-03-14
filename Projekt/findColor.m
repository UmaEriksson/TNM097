function [final_Color] = findColor(pallette, orgColor, purl)
% vis_org = ones(3, 3, 3);
% vis_org(:,:,1) =  orgColor(:,1);
% vis_org(:,:,2) =  orgColor(:,2);
% vis_org(:,:,3) =  orgColor(:,3);
% figure(21)
% imshow(vis_org);
orgColor_lab = rgb2lab(orgColor);
% figure(22)
% imshow(orgColor_lab);

pallette_lab = pallette;
pallette_lab = rgb2lab(pallette_lab);

[row, column, dim] = size(pallette_lab);

% test = pallette_lab(1,5,1)
final_Color = [];

%purl_with_white = setColor(purl, pallette(1,1,1), pallette(1,1,2), pallette(1,1,3));

min_dis = 1000000;
index_row = 0;
index_col = 0;

for j = 1:row
  
    for i = 1:column
     
       % jämför med medelvärde för pärlan med den aktuella färgen i 

       purl_with_white = setColor(purl, pallette(j,i,1), pallette(j,i,2), pallette(j,i,3));
       
%  figure(20)
%            imshow(purl_with_white);

       theColor = imresize(purl_with_white, [1 1]);
      
       
       theColor_lab = rgb2lab(theColor);
         
       [mean, max] = EuclidDis(theColor_lab(:,:, 1),theColor_lab(:,:, 2), theColor_lab(:,:, 3), orgColor_lab(:,1), orgColor_lab(:,2), orgColor_lab(:,3));
       
       %[mean, max] = EuclidDis(pallette_lab(j,i, 1),pallette_lab(j,i, 2), pallette_lab(j,i, 3), orgColor_lab(:,1), orgColor_lab(:,2), orgColor_lab(:,3));
      
       if min_dis > max
           min_dis = max;
           index_row = j;
           index_col = i;
%            final_Color = purl_with_white;
%            figure(24)
%            imshow(theColor);

       end 
        
    end
    
end

final_Color = pallette(index_row, index_col, :);

%  figure(23)
%  imshow(pallette);

pallette_final = lab2rgb(final_Color);

%diffen = abs(rgb2lab(final_Color) - rgb2lab(orgColor))

% orgColor
% 
% show_org_color = ones(100, 100, 3);
% show_org_color(:,:, 1)= show_org_color(:,:,1).*orgColor(:,1);
% show_org_color(:,:, 2)= show_org_color(:,:,2).*orgColor(:,2);
% show_org_color(:,:, 3)= show_org_color(:,:,3).*orgColor(:,3);
% 
% show_pal_color = ones(100, 100, 3);
% show_pal_color(:,:, 1)= show_pal_color(:,:,1).*pallette_final(:,:,1);
% show_pal_color(:,:, 2)= show_pal_color(:,:,2).*pallette_final(:,:,2);
% show_pal_color(:,:, 3)= show_pal_color(:,:,3).*pallette_final(:,:,3);
% 
%  figure(27)
% imshow(show_org_color);
% 
% figure(37)
% imshow(show_pal_color);
%  
 palletteColor = pallette_final;
 
end