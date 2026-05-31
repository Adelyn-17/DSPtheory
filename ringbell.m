%Ringing Effect
clear; clc; close all;

%1. Generate a composite image with absolutely sharp edges
N = 256;
img = zeros(N, N);
img(96:160, 96:160) = 1; % 65x65 white in centre 

% 2. translate to frequency domain
F = fftshift(fft2(img));

% 3. ILPF
D0 = 25; 
[U, V] = meshgrid(-N/2 : N/2-1, -N/2 : N/2-1);
D = sqrt(U.^2 + V.^2);
H = double(D <= D0); 

% 4. cut high frequency
F_filtered = F .* H;

% 5.IFFT
img_ringing = real(ifft2(ifftshift(F_filtered)));

figure('Name', 'ringing effect caused by a one-size-fits-all frequency domain cut', 'Position', [100, 100, 1200, 400]);

% initial sharp graph
subplot(1,3,1);
imshow(img);
title('initial figure');

% after filiter
subplot(1,3,2);
imshow(img_ringing, []); 
title(['after ILPF(Cut-off radius D_0=', num2str(D0), ')']);

% spatial domain
subplot(1,3,3);
mesh(img_ringing);
axis([60 196 60 196 -0.3 1.3]); 
title('3D surface plot of pixel brightness');
xlabel('X-axis pixels'); ylabel('Y-axis pixels'); zlabel('Brightness range');
colormap(parula);
