%缩小为 0.5 倍
img = im2double(imread('cameraman.tif'));
[H, W] = size(img);
scale = 0.5;

% 1.  FFT 
F = fftshift(fft2(img));

% 2. 
newH = round(H * scale);
newW = round(W * scale);

% 3. truncate
r_start = floor((H - newH) / 2) + 1;
c_start = floor((W - newW) / 2) + 1;
F_new = F(r_start : r_start + newH - 1, c_start : c_start + newW - 1);

% 4. give back energy
F_new = F_new * (scale^2);

% 5. ITTT
img_down = real(ifft2(ifftshift(F_new)));

% result
figure('Name', 'FFT Downsampling');
subplot(1,2,1); imshow(img); title(['initial ', num2str(H), 'x', num2str(W)]);
subplot(1,2,2); imshow(img_down); title(['after downsampling ', num2str(newH), 'x', num2str(newW)]);
