function [rep] = createReproduction(org, purl)

% ju mindre org resizseas till. desto större blir pärlorna
org_reSize = imresize( org , 0.12);

[row, col, dim] = size(org_reSize);
rep = [];
for j = 1:row
    
    newRow = [];
    
    for i = 1:col

        % Obs! hitta färg från pallette här innan!
        

        % här vill vi ha hittat den slutliga färgen som pärlan ska ha 
    newPurl = setColor(purl, org_reSize(j,i,1),org_reSize(j,i,2),org_reSize(j,i,3)); 
    newRow = cat(2, newRow, newPurl);
    end

   rep = cat(1, rep, newRow);

end 

end