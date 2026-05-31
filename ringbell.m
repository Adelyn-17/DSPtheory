clear; clc; close all;

% 1. Composite images with sharp edges
N = 256;
img = zeros(N, N);
img(96:160, 96:160) = 1; 

% 2. FFT
F = fftshift(fft2(img));

% 3. ILPF
D0 = 25; % truncation frequency radius
[U, V] = meshgrid(-N/2 : N/2-1, -N/2 : N/2-1);
D = sqrt(U.^2 + V.^2);
H = double(D <= D0);

% 4.Frequency domain filtering: truncation of high frequencies
F_filtered = F .* H;

% 5. IFFT
img_ringing = real(ifft2(ifftshift(F_filtered)));

figure('Name', 'ringing effect caused by a one-size-fits-all frequency domain cut', 'Position', [100, 100, 1200, 400]);

% Original sharp image
subplot(1,3,1);
imshow(img);
title('initial figure');

% Obvious water ripples generated after filtering
subplot(1,3,2);
imshow(img_ringing, []); 
title(['after ILPF(Cut-off radius D_0=', num2str(D0), ')']);

% 3D surface plot
subplot(1,3,3);
mesh(img_ringing);
axis([60 196 60 196 -0.3 1.3]); 
title('3D surface plot of pixel brightness');
xlabel('X-axis pixels'); ylabel('Y-axis pixels'); zlabel('Brightness range');
colormap(parula);
