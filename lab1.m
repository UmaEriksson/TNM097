clc;
clear;

load('Ad.mat'); % camera 1 
load('Ad2.mat'); % camera 2
load('chips20.mat');
load('illum.mat');
load('xyz.mat');
load('M_XYZ2RGB');
%load('Polynomial_poly.m'),

%values and plot for cam1
x1 = Ad(:, 1, :);
y1 = Ad(:, 2, :);
z1= Ad(:, 3, :);

% figure(1);
% 
% plot(x1, 'red');
% 
% hold on;
% 
% plot(y1, 'green');
% 
% hold on;
% 
% plot(z1, 'blue');

%values and plot for cam 2
x2 = Ad2(:, 1, :);
y2 = Ad2(:, 2, :);
z2= Ad2(:, 3, :);

% figure(2);
% 
% plot(x2, 'red');
% 
%  hold on;
% 
%  plot(y2, 'green');
% 
%  hold on;
% 
%  plot(z2, 'blue');


 d = Ad' *(chips20(:, :).* CIED65)';
  RGB_raw_D65 = d;
 
%    showRGB(d')
 
d2 = Ad2' *(chips20(:, :).* CIED65)';

%   showRGB(d2')


%% 2

n1 = Ad' *(ones(1, 61))' ;

n2 = Ad2' *(ones(1, 61))';

% RGB_cal_D65 = Ad' *(chips20(:,:).*CIED65)' ;

RGB_cal_D65 = RGB_raw_D65 ./ n1;

RGB_cal_D65_2 = d2 ./ n2;
% 
% showRGB(RGB_cal_D65')
% 
% showRGB(RGB_cal_D65_2')

%plot(waverange, CIED65);

% hold on; 

% plot(waverange, CIEA);


n3 = Ad' *(CIED65)' ;

n4 = Ad' *(CIEA)';


RGB_raw_A = Ad' *(chips20(:, :).* CIEA)';

% RGB_raw_A_2 = Ad2' *(chips20(:, :).* CIEA)';

RGB_cal_A = RGB_raw_A ./ n4;

cald65 = RGB_raw_D65  ./ n3;
% RGB_cal_A_2 = RGB_raw_A_2 ./ n2;

% showRGB(RGB_raw_A')

% showRGB(cald65')
%  showRGB(RGB_raw_A_2')
% 
%  showRGB(RGB_cal_A')
%  
%  showRGB(cald65')
% 
% showRGB(RGB_cal_A_2')


%% Del 3

% 3.1
k = (xyz(:, 2)' * CIED65');
k = 100/k;
% vi har en ref k. Nu ska vi jämföra den med tre olika uträkningar

XYZ_D65_REF = xyz' *(chips20(:, :).* CIED65)';
 
XYZ_D65_REF = (XYZ_D65_REF .* k)';
 
% 3.2

M_XYZ2RGB_inverse = inv(M_XYZ2RGB);

%res_XYZ = RGB_cal_D65' * M_XYZ2RGB_inverse; % XYZ-värderna
res_XYZ = (M_XYZ2RGB_inverse * RGB_cal_D65)'; % XYZ-värderna estimerat

[resL, resA, resB] = xyz2lab(res_XYZ(:,1), res_XYZ(:,2), res_XYZ(:,3));
[refL, refA, refB] = xyz2lab(XYZ_D65_REF(:,1), XYZ_D65_REF(:,2), XYZ_D65_REF(:,3));

[mean, max] = EuclidDis(resL, resA, resB, refL, refA, refB);

% 3.3
% figure(1)
% plot(waverange, Ad);
% 
% figure(2)
% plot(waverange, xyz);
% What does it mean???

% 3.4

D = RGB_cal_D65;
D = D';
C = XYZ_D65_REF;

A = pinv(D)*C;

res_XYZ_2 = D*A;
[resL2, resA2, resB2] = xyz2lab(res_XYZ_2(:,1), res_XYZ_2(:,2), res_XYZ_2(:,3));

[mean2, max2] = EuclidDis(resL2, resA2, resB2, refL, refA, refB);

% 3.5

A = Optimize_poly(RGB_cal_D65, XYZ_D65_REF');
res3 = Polynomial_regression(RGB_cal_D65,A);
res3 = res3';

[resL3, resA3, resB3] = xyz2lab(res3(:,1), res3(:,2), res3(:,3));
[mean3, max3] = EuclidDis(resL3, resA3, resB3, refL, refA, refB);


