%Magnify twice
img = im2double(imread('cameraman.tif'));
[H, W] = size(img);
scale = 2; 

% 1. FFT
F = fftshift(fft2(img));

% 2. Calculate the new dimensions
newH = H * scale;
newW = W * scale;
F_new = zeros(newH, newW);

% 3.Frequency domain zero padding
r_start = floor((newH - H) / 2) + 1;
c_start = floor((newW - W) / 2) + 1;
F_new(r_start : r_start + H - 1, c_start : c_start + W - 1) = F;
% 4.Energy compensation
F_new = F_new * (scale^2);

% 5.IFFT
img_up = real(ifft2(ifftshift(F_new)));

% Results
figure('Name', 'FFT Upsampling');
subplot(1,2,1); imshow(img); title(['initial ', num2str(H), 'x', num2str(W)]);
subplot(1,2,2); imshow(img_up); title(['after upsampling ', num2str(newH), 'x', num2str(newW)]);
