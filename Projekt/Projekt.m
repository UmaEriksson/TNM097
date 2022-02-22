
% size of bead matrix
n = 30 
% bead matrix 
beads = zeros(n,3,3);

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

N=100;
D=ones(N,N);
i0=10;
j0=20;
R=6;
% filter indise circle
[x,y]=meshgrid(1:N);
D((x-i0).^2+(y-j0).^2<R^2)=0;

imshow(D)
