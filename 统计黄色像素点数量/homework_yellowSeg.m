%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Student: Chen Shufu
% ID: 2014141462015
%
%Last Modification Time：2016-9-14 23:25:15
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I = imread('homework_yellowSeg.bmp');
[row,col,tmp] = size(I);
pxNum = row*col;

%使用RGB颜色空间提取黄色的方法
%思路是获取包含R和G分量并且不包含B分量的像素点
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
B = im2bw(B,graythresh(B));
R = im2bw(R,graythresh(R));
G = im2bw(G,graythresh(G));
RGB_res = R&G;
for i = 1: row
    for j = 1 : col
        if RGB_res(i,j) && B(i,j)
            RGB_res(i,j) = 0;
        end
    end
end
RGB_ans = sum(sum(RGB_res))/pxNum;

%使用HSV颜色空间提取黄色的方法
%思路是获取H分量在45°到75°之间的像素区域
hsvImg = rgb2hsv(I);
H = hsvImg(:,:,1)*360;
HSV_res = false(row,col);
for i = 1: row
    for j = 1 : col
        if H(i,j)>=45 && H(i,j)<75
            HSV_res(i,j) = 1;
        else
            hsvImg(i,j,2) = 0;
            hsvImg(i,j,3) = 0;
        end
    end
end
HSV_ans = sum(sum(HSV_res)) /pxNum;

%保存结果及结果二值图像
fid = fopen('results.txt','w+');
fprintf(fid,'RGB下提取并计算的结果是：%g %% \n',RGB_ans*100);
fprintf(fid,'HSV下提取并计算的结果是：%g %% \n',HSV_ans*100);
fclose(fid);
imwrite(RGB_res,'RGB_BW.bmp');
imwrite(HSV_res,'HSV_BW.bmp');