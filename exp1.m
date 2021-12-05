% clear
clear all; close all; clc;

pic = imread("darksense.jpg");

g_a = 90; g_b =175;
f_a = 5; f_b = 75;
alpha = g_a/f_a;
beta = (g_b-g_a)/(f_b-f_a);
gama = (255-g_b)/(255-f_b);

%% linear tran
% 将pic矩阵分为满足三个区间的三个矩阵
pic1 = double(pic).*alpha.*(pic<f_a);
pic2 = (beta.*(double(pic)-f_a)+g_a).*((f_a<=pic) & (pic<f_b));
pic3 = (gama.*(double(pic)-f_b)+g_b).*(f_b<=pic);

% 矩阵叠加得到最终图像
pic_result = uint8(pic1+pic2+pic3);
figure(1);
subplot(1, 2, 1);
imshow(pic_result);
title("Linear Transform");
colorbar;

subplot(1, 2, 2);
imshow(pic);
title("Original Picture");
colorbar;


%% histogram equalization
figure(2);
[J, T] = histeq(pic);
subplot(1, 2, 1);
imshow(J);
title("Histogram Equalization Result");
colorbar;

subplot(1, 2, 2);
imhist(J);
title("Histogram of Result");
colorbar;

figure(3);
histogram(pic, 8);
title("Histogram of Original Picture");
colorbar;
