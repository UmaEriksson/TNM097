function rep_image_HVS = applicate_HVS(rep_image)
% Vi vill ta in den reproducerade bilden
% här applicerar vi HVS filtret på varje kanal
% Innan vi retunerar bilden vill vi tröskla alla kanaler för att vara säker
% på att de inte innehåller negativa värden. 

% skapar ögats filter
f=MFTsp(15,0.0847,500);

% Appliceras ögats filter på varje kanal
r_HVS = conv2(rep_image(:,:,1), f, 'same');
g_HVS = conv2(rep_image(:,:,2), f, 'same');
b_HVS = conv2(rep_image(:,:,3), f, 'same');


r_HVS = (r_HVS>0) .* r_HVS;
g_HVS = (g_HVS>0) .* g_HVS;
b_HVS = (b_HVS>0) .* b_HVS;

rep_image_HVS = cat(3, r_HVS, g_HVS, b_HVS);

end