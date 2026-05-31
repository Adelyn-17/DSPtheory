%% 1.5 scaling
img = im2double(imread('cameraman.tif'));
[H, W] = size(img);
scale = 1.5; 

% 1. FFT
F = fftshift(fft2(img));

% 2. Calculate new dimensions
newH = round(H * scale);
newW = round(W * scale);

% 3. Construct new matrix
F_new = zeros(newH, newW);

if scale >= 1
    % Upsample: Zero padding
    r_start = floor((newH - H) / 2) + 1;
    c_start = floor((newW - W) / 2) + 1;
    F_new(r_start : r_start + H - 1, c_start : c_start + W - 1) = F;
else
    % downsample: Truncate
    r_start = floor((H - newH) / 2) + 1;
    c_start = floor((W - newW) / 2) + 1;
    F_new = F(r_start : r_start + newH - 1, c_start : c_start + newW - 1);
end

% 4. Energy compensation
F_new = F_new * (scale^2);

% 5. IFFT
img_resampled = real(ifft2(ifftshift(F_new)));

% To prevent some pixels from going out of bounds due to ringing effect
img_resampled = max(min(img_resampled, 1), 0);

% results
figure('Name', 'FFT Arbitrary Resampling');
subplot(1,2,1); imshow(img); title(['initial', num2str(H), 'x', num2str(W)]);
subplot(1,2,2); imshow(img_resampled); title(['after processing (x', num2str(scale), ') ', num2str(newH), 'x', num2str(newW)]);
