function [Mean_rep_HVS, Max_rep_HVS] = getDeltaE(org,rep)

[rep_row, rep_col, rep_dim] = size(rep);
[org_row, org_col, org_dim] = size(org);


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
%f = org_row/rep_row

%RGB_rep_HVS_Lab = imresize( RGB_rep_HVS_Lab , f, 'bicubic');

RGB_rep_HVS_Lab = imresize( RGB_rep_HVS_Lab , [org_row org_col], 'bicubic');


size(RGB_rep_HVS_Lab);
size(RGB_org_HVS_Lab);

% Jämför originalet och reproduktionen
% reproduktionens kalanaler först, sedan oriiginalet
[Mean_rep_matrix_HVS, Max_rep_matrix_HVS] = EuclidDis(RGB_rep_HVS_Lab(:,:,1), RGB_rep_HVS_Lab(:,:,2), RGB_rep_HVS_Lab(:,:,3), RGB_org_HVS_Lab(:,:,1), RGB_org_HVS_Lab(:,:,2), RGB_org_HVS_Lab(:,:,3));
Mean_rep_HVS = mean(Mean_rep_matrix_HVS);
Max_rep_HVS = max(Max_rep_matrix_HVS);
%Min_rep_HVS = min(Min_rep_matrix_HVS);


%end
