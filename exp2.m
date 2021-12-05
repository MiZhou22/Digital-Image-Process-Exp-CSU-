% clear
close all; clear all; clc

pic = zeros(500, 500);
pic(250-50:251+50, 250-10:251+10) = pic(250-50:251+50, 250-10:251+10)+255;
pic = uint8(pic);

figure(1);
imshow(pic);
title("Original Picture");

%% 2D Fourier Transform(FFT) for pic
% FFT for pic
pic_fre = fft2(im2double(pic));
figure(2);

subplot(1, 2, 1);
imshow(mat2gray(abs(fftshift(pic_fre))));
title("FFT2 Result");
colorbar;

subplot(1, 2, 2);
imshow(mat2gray(abs(ifft2(pic_fre))));
title("IFFT2 Result");
colorbar;

%% FFT for (-1)^(x+y)*Pic
pic1 = pic;
pic1(1:2:end, 2:2:end) = -pic(1:2:end, 1:2:end);
pic1(2:2:end, 1:2:end) = -pic(2:2:end, 2:2:end);
pic1_fre = fft2(im2double(pic1));

figure(3);
subplot(1, 2, 1)
imshow(mat2gray(abs(fftshift(pic1_fre))));
title("FFT2 for (-1)^{(x+y)}*Pic");
colorbar;

subplot(1, 2, 2)
imshow(mat2gray(abs(ifft2(pic1_fre))));
title("IFFT2 for (-1)^{(x+y)}*Pic");
colorbar;

%% clock wise rotate pi/2
pic2 = imrotate(pic, -45);
pic2_fre = fft2(im2double(pic2));

figure(4);
subplot(1, 2, 1)
imshow(mat2gray(abs(fftshift(pic2_fre))));
title("FFT2 for Rotation Pic");
colorbar;

subplot(1, 2, 2)
imshow(mat2gray(abs(ifft2(pic2_fre))));
title("IFFT2 for Rotation Pic");
colorbar;

%% FFT for real image
pic4 = imread("person.jpg");
pic4 = im2gray(pic4);
pic4_fre = fft2(im2double(pic4));

figure(5);
subplot(3, 1, 1)
imshow(mat2gray(abs(fftshift(pic4_fre))));
title("FFT2 for Pic");
colorbar;

subplot(3, 1, 2)
imshow(mat2gray(angle(fftshift(pic4_fre))*180/pi));
title("IFFT2 for Pic");
colorbar;

subplot(3, 1, 3);
imshow(mat2gray(abs(ifft2(pic4_fre))));
title("IFFT2 for Pic");
colorbar;

%% different combination
A = 10;
pic4_fre1 = A*exp(1i*angle(pic4_fre));
pic4_fre2 = abs(pic4_fre)*exp(1i*0);
pic4_fre3 = imresize(abs(pic_fre),"OutputSize", size(angle(pic4_fre), [1 2])).*exp(1i*angle(pic4_fre));

figure(6);
subplot(3, 1, 1);
imshow(im2uint8(mat2gray(abs(ifft2(pic4_fre1)))));
title("A_{Constant}*e^{i*\phi_{real}}");

subplot(3, 1, 2);
imshow(im2uint8(mat2gray(abs(ifft2(pic4_fre2)))));
title("A_{real}*e^{i*\phi_{0}}");

subplot(3, 1, 3);
imshow(im2uint8(mat2gray(abs(ifft2(pic4_fre3)))));
title("A_{pre}*e^{i*\phi_{real}}");



