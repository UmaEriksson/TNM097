function [Mean, Max] = EuclidDis(resL, resA, resB, refL, refA, refB)

% resL
% resA
% resB
% refL
% refA
% refB

DL = (resL-refL); 

% L = resL - refL;
% DL= sqrt(L * L');

DA = (resA-refA); 

DB = (resB-refB); 

Delta_E = sqrt(DL.^2 + DA.^2 + DB.^2);

Mean = mean(Delta_E);
Max = max(Delta_E);
%Min = min(Delta_E);





end