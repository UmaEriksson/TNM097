function [newPurl] = setColor(newPurl, r, g, b)
% Vi tar det förgivet att pärlan som kommer in är en defult pärla. Alltså
% en pärla som är svartfärgad. 

[row, column, dim] = size(newPurl);

for i = 1:row
    for j= 1:column
        if newPurl(i,j,1) == 0 % pärlan är från början alltid svart

            newPurl(i,j,1) = r;
            newPurl(i,j,2) = g;
            newPurl(i,j,3) = b;

        end 
    end 
end


end