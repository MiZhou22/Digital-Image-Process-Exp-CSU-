% clear 
% copyrighy@zhoumi
close all; clear all; clc

pic = imread("goose.jpg");
pic = im2gray(pic);

%% add some noise
pic_gn = imnoise(pic, "gaussian");
pic_sn = imnoise(pic, "salt & pepper");

figure(1);
subplot(3, 1, 1);
imshow(pic);
title("Original Gray Image");

subplot(3, 1, 2);
imshow(pic_gn);
title("Gaussian Noisy Image");

subplot(3, 1, 3);
imshow(pic_sn);
title("Salt&Pepper Noisy Image");

%% Medium Filtering
pic_gn_medfil1 = medfilt2(pic_gn, [3 3], "symmetric");
pic_gn_medfil2 = medfilt2(pic_gn, [5 5], "symmetric");

pic_sn_medfil1 = medfilt2(pic_sn, [3 3], "symmetric");
pic_sn_medfil2 = medfilt2(pic_sn, [5 5], "symmetric");

figure(2);
subplot(3, 2, 1);
imshow(pic_sn);
title("Salt&Pepper Noisy Image");

subplot(3, 2, 2);
imshow(pic_gn);
title("Gaussian Noisy Image");

subplot(3, 2, 3);
imshow(pic_gn_medfil1);
title("3x3 Mask MedFilter for Gaussian Noise");

subplot(3, 2, 4);
imshow(pic_gn_medfil2);
title("5x5 Mask MedFilter for Gaussian Noise");

subplot(3, 2, 5);
imshow(pic_sn_medfil1);
title("3x3 Mask MedFilter for Salt&Pepper Noise");

subplot(3, 2, 6);
imshow(pic_sn_medfil2);
title("5x5 Mask MedFilter for Salt&Pepper Noise");

%% Average Filtering
pic_gn_avgfil1 = filter2(fspecial('average',3), pic_gn)/255;
pic_gn_avgfil2 = filter2(fspecial('average',5), pic_gn)/255;

pic_sn_avgfil1 = filter2(fspecial('average',3), pic_sn)/255;
pic_sn_avgfil2 = filter2(fspecial('average',5), pic_sn)/255;

figure(3);
subplot(3, 2, 1);
imshow(pic_sn);
title("Salt&Pepper Noisy Image");

subplot(3, 2, 2);
imshow(pic_gn);
title("Gaussian Noisy Image");

subplot(3, 2, 3);
imshow(pic_gn_avgfil1);
title("3x3 Mask AvgFilter for Gaussian Noise");

subplot(3, 2, 4);
imshow(pic_gn_avgfil2);
title("5x5 Mask AvgFilter for Gaussian Noise");

subplot(3, 2, 5);
imshow(pic_sn_avgfil1);
title("3x3 Mask AvgFilter for Salt&Pepper Noise");

subplot(3, 2, 6);
imshow(pic_sn_avgfil2);
title("5x5 Mask AvgFilter for Salt&Pepper Noise");

%% Filtering in Frequency Domain
pic_fre = fft2(im2double(pic));

lpf = zeros(size(pic_fre));
range = 25;
lpf(size(lpf, 1)/2-range:size(lpf, 1)/2+range+1, size(lpf, 2)/2-range:size(lpf, 2)/2+range+1) = 1;
hpf = 1-lpf;

glf = fspecial('gaussian',size(pic_fre), 15);
ghf = max(glf)-glf;

pic_re1 = im2uint8(mat2gray(abs(ifft2(fftshift(fftshift(pic_fre).*lpf)))));
pic_re2 = im2uint8(mat2gray(abs(ifft2(fftshift(fftshift(pic_fre).*hpf)))));
pic_re3 = im2uint8(mat2gray(abs(ifft2(fftshift(fftshift(pic_fre).*glf)))));
pic_re4 = im2uint8(mat2gray(abs(ifft2(fftshift(fftshift(pic_fre).*ghf)))));

figure(4);
subplot(3, 2, 1)
imshow(mat2gray(abs(log(1+fftshift(pic_fre)))));
title("Original Picture Space Domain");

subplot(3, 2, 2);
imshow(pic);
title("Original Picture Frequency Domain");

subplot(3, 2, 3);
imshow(pic_re1);
title("Ideal LPF");

subplot(3, 2, 4);
imshow(pic_re2);
title("Ideal HPF");

subplot(3, 2, 5);
imshow(pic_re3);
title("Gaussian LPF");

subplot(3, 2, 6);
imshow(pic_re4);
title("Gaussian HPF");


