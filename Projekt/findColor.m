function [palletteColor] = findColor(pallette, orgColor)
 % figure(21)
% imshow(orgColor);
orgColor_lab = rgb2lab(orgColor);
% figure(22)
% imshow(orgColor_lab);

% pallette = rand(5,5,3); 
pallette_lab = pallette;
pallette_lab = rgb2lab(pallette_lab);
%pallette_lab(:,:,1) = rgb2lab(pallette(:,:,1));
%pallette_lab(:,:,2) = rgb2lab(pallette(:,:,2));
%pallette_lab(:,:,3) = rgb2lab(pallette(:,:,3));

[row, column, dim] = size(pallette_lab);

% test = pallette_lab(1,5,1)

min_dis = 10000;
index_row = 0;
index_col = 0;

for j = 1:row
  
    for i = 1:column
     
       
       [mean, max] = EuclidDis(pallette_lab(j,i, 1),pallette_lab(j,i, 2), pallette_lab(j,i, 3), orgColor_lab(:,1), orgColor_lab(:,2), orgColor_lab(:,3));
      
       if min_dis > max
           min_dis = max;
           index_row = j;
           index_col = i;
           
       end 
        
    end
    
end

final_Color = pallette_lab(index_row, index_col, :);

%  figure(23)
%  imshow(pallette);

pallette_final = lab2rgb(final_Color);

% orgColor
% 
% show_org_color = ones(100, 100, 3);
% show_org_color(:,:, 1)= show_org_color(:,:,1).*orgColor(1,1,1);
% show_org_color(:,:, 2)= show_org_color(:,:,2).*orgColor(1,1,2);
% show_org_color(:,:, 3)= show_org_color(:,:,3).*orgColor(1,1,3);
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
 
 palletteColor = pallette_final;
 
end